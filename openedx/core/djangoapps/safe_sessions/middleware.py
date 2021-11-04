"""
This module defines SafeSessionMiddleware that makes use of a
SafeCookieData that cryptographically binds the user to the session id
in the cookie.

The primary goal is to avoid and detect situations where a session is
corrupted and the client becomes logged in as the wrong user. This
could happen via cache corruption (which we've seen before) or a
request handling bug. It's unlikely to happen again, but would be a
critical issue, so we've built in some checks to make sure the user on
the session doesn't change over the course of the session or between
the request and response phases.

The secondary goal is to improve upon Django's session handling by
including cryptographically enforced expiration.

The implementation is inspired in part by the proposal in the paper
<http://www.cse.msu.edu/~alexliu/publications/Cookie/cookie.pdf>
but deviates in a number of ways; mostly it just uses the technique
of an intermediate key for HMAC.

Note: The proposed protocol protects against replay attacks by
use of channel binding—specifically, by
incorporating the session key used in the SSL connection.  However,
this does not suit our needs since we want the ability to reuse the
same cookie over multiple browser sessions, and in any case the server
will be behind a load balancer and won't have access to the correct
SSL session information.  So instead, we mitigate
replay attacks by enforcing session cookie expiration
(via TimestampSigner) and assuming SESSION_COOKIE_SECURE (see below).

We use django's built-in Signer class, which makes use of a built-in
salted_hmac function that derives an intermediate key from the
server's SECRET_KEY, as proposed in the paper.

Note: The paper proposes deriving an intermediate key from the
session's expiration time in order to protect against volume attacks.
(Note that these hypothetical attacks would only succeed if HMAC-SHA1
were found to be weak, and there is presently no indication of this.)
However, since django does not always use an expiration time, we
instead use a random key salt to prevent volume attacks.

In fact, we actually use a specialized subclass of Signer called
TimestampSigner. This signer binds a timestamp along with the signed
data and verifies that the signature has not expired.  We do this
since django's session stores do not actually verify the expiration
of the session cookies.  Django instead relies on the browser to honor
session cookie expiration.

The resulting safe cookie data that gets stored as the value in the
session cookie is:

    version '|' session_id '|' key_salt '|' signed_hash

where signed_hash is a structure incorporating the following value and
a MAC (via TimestampSigner):

    SHA256(version '|' session_id '|' user_id '|')

TimestampSigner uses HMAC-SHA1 to derive a key from key_salt and the
server's SECRET_KEY; see django.core.signing for more details on the
structure of the output (which takes the form of colon-delimited
Base64.)

Note: We assume that the SESSION_COOKIE_SECURE setting is set to
TRUE to prevent inadvertent leakage of the session cookie to a
person-in-the-middle.  The SESSION_COOKIE_SECURE flag indicates
to the browser that the cookie should be sent only over an
SSL-protected channel.  Otherwise, a connection eavesdropper could copy
the entire cookie and use it to impersonate the victim.

Custom Attributes:
    safe_sessions.user_mismatch: 'request-response-mismatch' | 'request-session-mismatch'
        This attribute can be one of the above two values which correspond to the kind of comparison
        that failed when processing the response. See SafeSessionMiddleware._verify_user
"""

import inspect
from base64 import b64encode
from hashlib import sha1, sha256
from logging import getLogger
from typing import Union

from django.conf import settings
from django.contrib.auth import SESSION_KEY
from django.contrib.auth.views import redirect_to_login
from django.contrib.sessions.middleware import SessionMiddleware
from django.core import signing
from django.http import HttpResponse
from django.utils.crypto import get_random_string
from django.utils.deprecation import MiddlewareMixin

from edx_django_utils.monitoring import set_custom_attribute

from openedx.core.lib.mobile_utils import is_request_from_mobile_app

# .. toggle_name: LOG_REQUEST_USER_CHANGES
# .. toggle_implementation: SettingToggle
# .. toggle_default: False
# .. toggle_description: Turn this toggle on to provide additional debugging information in the case of a user
#      verification error. It will track anytime the `user` attribute of a request object is changed and store this
#      information on the request. This will also track the location where the change is coming from to quickly find
#      issues. If user verification fails at response time, all of the information about these
#      changes will be logged.
# .. toggle_warnings: Adds some processing overhead to all requests to gather debug info. Will also double the logging
#      for failed verification checks.
# .. toggle_use_cases: opt_in
# .. toggle_creation_date: 2021-03-25
# .. toggle_tickets: https://openedx.atlassian.net/browse/ARCHBOM-1718
LOG_REQUEST_USER_CHANGES = getattr(settings, 'LOG_REQUEST_USER_CHANGES', False)

log = getLogger(__name__)


class SafeCookieError(Exception):
    """
    An exception class for safe cookie related errors.
    """
    def __init__(self, error_message):
        super().__init__(error_message)
        log.error(error_message)


class SafeCookieData:
    """
    Cookie data that cryptographically binds and timestamps the user
    to the session id.  It verifies the freshness of the cookie by
    checking its creation date using settings.SESSION_COOKIE_AGE.
    """
    CURRENT_VERSION = '1'
    SEPARATOR = "|"

    def __init__(self, version, session_id, key_salt, signature):
        """
        Arguments:
            version (string): The data model version of the safe cookie
                data that is checked for forward and backward
                compatibility.
            session_id (string): Unique and unguessable session
                identifier to which this safe cookie data is bound.
            key_salt (string): A securely generated random string that
                is used to derive an intermediate secret key for
                signing the safe cookie data to protect against volume
                attacks.
            signature (string): Cryptographically created signature
                for the safe cookie data that binds the session_id
                and its corresponding user as described at the top of
                this file.
        """
        self.version = version
        self.session_id = session_id
        self.key_salt = key_salt
        self.signature = signature

    @classmethod
    def create(cls, session_id, user_id):
        """
        Factory method for creating the cryptographically bound
        safe cookie data for the session and the user.

        Raises SafeCookieError if session_id is None.
        """
        cls._validate_cookie_params(session_id, user_id)
        safe_cookie_data = SafeCookieData(
            cls.CURRENT_VERSION,
            session_id,
            key_salt=get_random_string(12),
            signature=None,
        )
        safe_cookie_data.sign(user_id)
        return safe_cookie_data

    @classmethod
    def parse(cls, safe_cookie_string):
        """
        Factory method that parses the serialized safe cookie data,
        verifies the version, and returns the safe cookie object.

        Raises SafeCookieError if there are any issues parsing the
        safe_cookie_string.
        """
        try:
            raw_cookie_components = str(safe_cookie_string).split(cls.SEPARATOR)
            safe_cookie_data = SafeCookieData(*raw_cookie_components)
        except TypeError:
            raise SafeCookieError(  # lint-amnesty, pylint: disable=raise-missing-from
                f"SafeCookieData BWC parse error: {safe_cookie_string!r}."
            )
        else:
            if safe_cookie_data.version != cls.CURRENT_VERSION:
                raise SafeCookieError(
                    "SafeCookieData version {!r} is not supported. Current version is {}.".format(
                        safe_cookie_data.version,
                        cls.CURRENT_VERSION,
                    ))
            return safe_cookie_data

    def __str__(self):
        """
        Returns a string serialization of the safe cookie data.
        """
        return self.SEPARATOR.join([self.version, self.session_id, self.key_salt, self.signature])

    def sign(self, user_id):
        """
        Signs the safe cookie data for this user using a timestamped signature
        and an intermediate key derived from key_salt and server's SECRET_KEY.
        Value under signature is the hexadecimal string from
        SHA256(version '|' session_id '|' user_id '|').
        """
        data_to_sign = self._compute_digest(user_id)
        self.signature = signing.dumps(data_to_sign, salt=self.key_salt)

    def verify(self, user_id):
        """
        Verifies the signature of this safe cookie data.
        Successful verification implies this cookie data is fresh
        (not expired) and bound to the given user.
        """
        try:
            unsigned_data = signing.loads(self.signature, salt=self.key_salt, max_age=settings.SESSION_COOKIE_AGE)
            if unsigned_data == self._compute_digest(user_id):
                return True
            log.error("SafeCookieData '%r' is not bound to user '%s'.", str(self), user_id)
        except signing.BadSignature as sig_error:
            log.error(
                "SafeCookieData signature error for cookie data {!r}: {}".format(  # pylint: disable=logging-format-interpolation
                    str(self),
                    str(sig_error),
                )
            )
        return False

    def _compute_digest(self, user_id):
        """
        Returns SHA256(version '|' session_id '|' user_id '|') hex string.
        """
        hash_func = sha256()
        for data_item in [self.version, self.session_id, user_id]:
            hash_func.update(str(data_item).encode())
            hash_func.update(b'|')
        return hash_func.hexdigest()

    @staticmethod
    def _validate_cookie_params(session_id, user_id):
        """
        Validates the given parameters for cookie creation.

        Raises SafeCookieError if session_id is None.
        """
        # Compare against unicode(None) as well since the 'value'
        # property of a cookie automatically serializes None to a
        # string.
        if not session_id or session_id == str(None):
            # The session ID should always be valid in the cookie.
            raise SafeCookieError(
                "SafeCookieData not created due to invalid value for session_id '{}' for user_id '{}'.".format(
                    session_id,
                    user_id,
                ))

        if not user_id:
            # The user ID is sometimes not set for
            # 3rd party Auth and external Auth transactions
            # as some of the session requests are made as
            # Anonymous users.
            log.debug(
                "SafeCookieData received empty user_id '%s' for session_id '%s'.",
                user_id,
                session_id,
            )


class SafeSessionMiddleware(SessionMiddleware, MiddlewareMixin):
    """
    A safer middleware implementation that uses SafeCookieData instead
    of just the session id to lookup and verify a user's session.
    """
    def process_request(self, request):
        """
        Processing the request is a multi-step process, as follows:

        Step 1. The safe_cookie_data is parsed and verified from the
        session cookie.

        Step 2. The session_id is retrieved from the safe_cookie_data
        and stored in place of the session cookie value, to be used by
        Django's Session middleware.

        Step 3. Call Django's Session Middleware to find the session
        corresponding to the session_id and to set the session in the
        request.

        Step 4. Once the session is retrieved, verify that the user
        bound in the safe_cookie_data matches the user attached to the
        server's session information. Otherwise, reject the request
        (bypass the view and return an error or redirect).

        Step 5. If all is successful, the now verified user_id is stored
        separately in the request object so it is available for another
        final verification before sending the response (in
        process_response).
        """
        # 2021-10-29: Temporary debugging attr to answer the question
        # "are browsers sometimes sending in multiple session
        # cookies?" We've observed behavior that might be consistent
        # with this, perhaps due to an additional cookie set on the
        # wrong domain, and assuming that the cookies *occasionally*
        # are sent in a different order. -- timmc
        try:
            set_custom_attribute(
                'safe_sessions.session_cookie_count',
                request.headers.get('Cookie', '').count(settings.SESSION_COOKIE_NAME + '=')
            )
        except:  # pylint: disable=bare-except
            pass

        cookie_data_string = request.COOKIES.get(settings.SESSION_COOKIE_NAME)
        if cookie_data_string:

            try:
                safe_cookie_data = SafeCookieData.parse(cookie_data_string)  # Step 1

            except SafeCookieError:
                # For security reasons, we don't support requests with
                # older or invalid session cookie models.
                return self._on_user_authentication_failed(request)

            else:
                request.COOKIES[settings.SESSION_COOKIE_NAME] = safe_cookie_data.session_id  # Step 2

                # Save off for debugging and logging in _verify_user
                request.cookie_session_field = safe_cookie_data.session_id

        process_request_response = super().process_request(request)  # Step 3  # lint-amnesty, pylint: disable=assignment-from-no-return, super-with-arguments
        if process_request_response:
            # The process_request pipeline has been short circuited so
            # return the response.
            return process_request_response

        user_id = self.get_user_id_from_session(request)
        if cookie_data_string and user_id is not None:

            if safe_cookie_data.verify(user_id):  # Step 4
                request.safe_cookie_verified_user_id = user_id  # Step 5
                request.safe_cookie_verified_session_id = request.session.session_key
                if LOG_REQUEST_USER_CHANGES:
                    track_request_user_changes(request)
            else:
                # Return an error or redirect, and don't continue to
                # the underlying view.
                return self._on_user_authentication_failed(request)

    def process_response(self, request, response):
        """
        When creating a cookie for the response, a safe_cookie_data
        is created and put in place of the session_id in the session
        cookie.

        Also, the session cookie is deleted if prior verification failed
        or the designated user in the request has changed since the
        original request.

        Processing the response is a multi-step process, as follows:

        Step 1. Call the parent's method to generate the basic cookie.

        Step 2. Verify that the user marked at the time of
        process_request matches the user at this time when processing
        the response.  If not, log the error.

        Step 3. If a cookie is being sent with the response, update
        the cookie by replacing its session_id with a safe_cookie_data
        that binds the session and its corresponding user.

        Step 4. Delete the cookie, if it's marked for deletion.

        """
        response = super().process_response(request, response)  # Step 1

        # 2021-10-29: Temporary debugging attrs, to answer the
        # question "are we calling _verify_user on too few responses?"
        # We should probably be calling it on every response, and it
        # looks like we might be missing most responses -- some
        # testing shows that most of my LMS responses do *not* get a
        # newly coined session cookie, but I seem to recall that that
        # used to happen. If so, we may have at some point stopped
        # calling _verify_user as often as we should. -- timmc
        try:
            set_custom_attribute(
                'safe_sessions.request_had_valid_session',
                hasattr(request, 'safe_cookie_verified_session_id')
            )
            set_custom_attribute(
                'safe_sessions.response_has_session_cookie',
                _is_cookie_present(response)
            )
        except:  # pylint: disable=bare-except
            pass

        if not _is_cookie_marked_for_deletion(request) and _is_cookie_present(response):
            try:
                user_id_in_session = self.get_user_id_from_session(request)
                self._verify_user(request, response, user_id_in_session)  # Step 2

                # Use the user_id marked in the session instead of the
                # one in the request in case the user is not set in the
                # request, for example during Anonymous API access.
                self.update_with_safe_session_cookie(response.cookies, user_id_in_session)  # Step 3

            except SafeCookieError:
                _mark_cookie_for_deletion(request)

        if _is_cookie_marked_for_deletion(request):
            _delete_cookie(request, response)  # Step 4

        return response

    @staticmethod
    def _on_user_authentication_failed(request):
        """
        To be called when user authentication fails when processing requests in the middleware.
        Sets a flag to delete the user's cookie and does one of the following:
        - Raises 401 for mobile requests and requests that are not specifically requesting a HTML response.
        - Redirects to login in case request expects a HTML response.
        """
        _mark_cookie_for_deletion(request)

        # Mobile apps have custom handling of authentication failures. They
        # should *not* be redirected to the website's login page.
        if is_request_from_mobile_app(request):
            set_custom_attribute("safe_sessions.auth_failure", "mobile")
            return HttpResponse(status=401)

        # only redirect to login if client is expecting html
        if 'text/html' in request.META.get('HTTP_ACCEPT', ''):
            set_custom_attribute("safe_sessions.auth_failure", "redirect_to_login")
            return redirect_to_login(request.path)
        set_custom_attribute("safe_sessions.auth_failure", "401")
        return HttpResponse(status=401)

    @staticmethod
    def _verify_user(request, response, userid_in_session):
        """
        Logs an error if the user marked at the time of process_request
        does not match either the current user in the request or the
        given userid_in_session.
        """
        # It's expected that a small number of views may change the
        # user over the course of the request. We have exemptions for
        # the user changing to/from None, but the login view can
        # sometimes change the user from one value to another between
        # the request and response phases, specifically when the login
        # page is used during an active session.
        #
        # The relevant views set a flag to indicate the exemption.
        if getattr(response, 'safe_sessions_expected_user_change', None):
            return

        if not hasattr(request, 'safe_cookie_verified_user_id'):
            # Skip verification if request didn't come in with a session cookie
            return

        if hasattr(request.user, 'real_user'):
            # If a view overrode the request.user with a masqueraded user, this will
            #   revert/clean-up that change during response processing.
            request.user = request.user.real_user

        # determine if the request.user is different now than it was on the initial request
        request_user_object_mismatch = request.safe_cookie_verified_user_id != request.user.id and\
            request.user.id is not None

        # determine if the current session user is different than the user in the initial request
        session_user_mismatch = request.safe_cookie_verified_user_id != userid_in_session and\
            userid_in_session is not None

        if not (request_user_object_mismatch or session_user_mismatch):
            # Great! No mismatch.
            return

        # Log accumulated information stored on request for each change of user
        extra_logs = []

        # Attach extra logging and metrics, but don't fail the request if there's a bug in here.
        try:
            response_session_id = getattr(getattr(request, 'session', None), 'session_key', None)

            # A safe-session user mismatch could be caused by the
            # wrong session being retrieved from cache. This
            # additional logging should reveal any such mismatch
            # (without revealing the actual session ID in logs).
            sessions_raw = [
                ('parsed_cookie', request.cookie_session_field),
                ('at_request', request.safe_cookie_verified_session_id),
                ('at_response', response_session_id),
            ]
            # Note that this is an ordered list of pairs, not a
            # dict, so that the output order is consistent.
            session_hashes = [(k, obscure_token(v)) for (k, v) in sessions_raw]
            session_id_changed = len(set(kv[1] for kv in sessions_raw)) > 1

            # delete old session id for security
            del request.safe_cookie_verified_session_id
            del request.cookie_session_field

            extra_logs.append('Session changed.' if session_id_changed else 'Session did not change.')

            # Allow comparing session IDs in both logs and metrics
            extra_logs.append(
                "Hash of session ID from various sources: " +
                '; '.join(f'{k}={v}' for (k, v) in session_hashes)
            )
            for source_name, id_hash in session_hashes:
                set_custom_attribute(f'safe_sessions.session_id_hash.{source_name}', id_hash)
            set_custom_attribute('safe_sessions.session_id_changed', session_id_changed)

            if hasattr(request, 'debug_user_changes'):
                extra_logs.append(
                    'An unsafe user transition was found. It either needs to be fixed or exempted.\n' +
                    '\n'.join(request.debug_user_changes)
                )
        except BaseException as e:
            log.error("SafeCookieData error while computing additional logs: %r", e)

        if request_user_object_mismatch and not session_user_mismatch:
            log.warning(
                (
                    "SafeCookieData user at initial request '{}' does not match user at response time: '{}' "
                    "for request path '{}'.\n{}"
                ).format(  # pylint: disable=logging-format-interpolation
                    request.safe_cookie_verified_user_id, request.user.id, request.path, '\n'.join(extra_logs)
                ),
            )
            set_custom_attribute("safe_sessions.user_mismatch", "request-response-mismatch")
        elif session_user_mismatch and not request_user_object_mismatch:
            log.warning(
                (
                    "SafeCookieData user at initial request '{}' does not match user in session: '{}' "
                    "for request path '{}'.\n{}"
                ).format(  # pylint: disable=logging-format-interpolation
                    request.safe_cookie_verified_user_id, userid_in_session, request.path, '\n'.join(extra_logs)
                ),
            )
            set_custom_attribute("safe_sessions.user_mismatch", "request-session-mismatch")
        else:
            log.warning(
                (
                    "SafeCookieData user at initial request '{}' matches neither user in session: '{}' "
                    "nor user at response time: '{}' for request path '{}'.\n{}"
                ).format(  # pylint: disable=logging-format-interpolation
                    request.safe_cookie_verified_user_id, userid_in_session, request.user.id, request.path,
                    '\n'.join(extra_logs)
                ),
            )
            set_custom_attribute("safe_sessions.user_mismatch", "request-response-and-session-mismatch")

    @staticmethod
    def get_user_id_from_session(request):
        """
        Return the user_id stored in the session of the request.
        """
        from django.contrib.auth import _get_user_session_key
        try:
            # Django call to get the user id which is serialized in the session.
            return _get_user_session_key(request)
        except KeyError:
            return None

    # TODO move to test code, maybe rename, get rid of old Django compat stuff
    @staticmethod
    def set_user_id_in_session(request, user):
        """
        Stores the user_id in the session of the request.
        Used by unit tests.
        """
        # Django's request.session[SESSION_KEY] should contain the user serialized to a string.
        #   This is different from request.session.session_key, which holds the session id.
        request.session[SESSION_KEY] = user._meta.pk.value_to_string(user)

    @staticmethod
    def update_with_safe_session_cookie(cookies, user_id):
        """
        Replaces the session_id in the session cookie with a freshly
        computed safe_cookie_data.
        """
        # Create safe cookie data that binds the user with the session
        # in place of just storing the session_key in the cookie.
        safe_cookie_data = SafeCookieData.create(
            cookies[settings.SESSION_COOKIE_NAME].value,
            user_id,
        )

        # Update the cookie's value with the safe_cookie_data.
        cookies[settings.SESSION_COOKIE_NAME] = str(safe_cookie_data)


def obscure_token(value: Union[str, None]) -> Union[str, None]:
    """
    Return a short string that can be used to detect other occurrences
    of this string without revealing the original. Return None if value
    is None.

    Outputs are intended to be *transient* and should not be stored or
    compared long-term, as they are dependent on the value of
    settings.SECRET_KEY, which can be rotated at any time.

    WARNING: This code must only be used for *high-entropy inputs*
    that an attacker cannot enumerate, predict, or guess for other
    parties. In particular, it must not be used for sequential IDs or
    timestamps, since an attacker possessing the pepper could
    precompute the hashes. A non-cryptographic de-identification
    technique must be used in such cases, such as a lookup table.
    """
    if value is None:
        return None
    else:
        # Use of hashing (and in particular use of SECRET_KEY as a
        # pepper) is overkill for safe-sessions, where at worst we
        # might end up logging an occasional session ID prefix... but
        # there's very little cost in overdoing it here, especially if
        # the code ends up getting copied around.
        return sha1((settings.SECRET_KEY + value).encode()).hexdigest()[:8]


def _mark_cookie_for_deletion(request):
    """
    Updates the given request object to designate that the session
    cookie should be deleted.
    """
    request.need_to_delete_cookie = True


def _is_cookie_marked_for_deletion(request):
    """
    Returns whether the session cookie has been designated for deletion
    in the given request object.
    """
    return getattr(request, 'need_to_delete_cookie', False)


def _is_cookie_present(response):
    """
    Returns whether the session cookie is present in the response.
    """
    return bool(
        response.cookies.get(settings.SESSION_COOKIE_NAME) and  # cookie in response
        response.cookies[settings.SESSION_COOKIE_NAME].value  # cookie is not empty
    )


def _delete_cookie(request, response):
    """
    Delete the cookie by setting the expiration to a date in the past,
    while maintaining the domain, secure, and httponly settings.
    """
    response.set_cookie(
        settings.SESSION_COOKIE_NAME,
        max_age=0,
        expires='Thu, 01-Jan-1970 00:00:00 GMT',
        domain=settings.SESSION_COOKIE_DOMAIN,
        secure=settings.SESSION_COOKIE_SECURE or None,
        httponly=settings.SESSION_COOKIE_HTTPONLY or None,
    )

    # Log the cookie, but cap the length and base64 encode to make sure nothing
    # malicious gets directly dumped into the log.
    cookie_header = request.META.get('HTTP_COOKIE', '')[:4096]
    log.warning(
        "Malformed Cookie Header? First 4K, in Base64: %s",
        b64encode(str(cookie_header).encode())
    )

    # Note, there is no request.user attribute at this point.
    if hasattr(request, 'session') and hasattr(request.session, 'session_key'):
        log.warning(
            "SafeCookieData deleted session cookie for session %s",
            request.session.session_key
        )


def track_request_user_changes(request):
    """
    Instrument the request object so that we store changes to the `user` attribute for future logging
    if needed for debugging user mismatches. This is done by changing the `__class__` attribute of the request
    object to point to a new class we created on the fly which is exactly the same as the underlying request class but
    with an override for the `__setattr__` function to catch the attribute changes.
    """
    original_user = getattr(request, 'user', None)

    class SafeSessionRequestWrapper(request.__class__):
        """
        A wrapper class for the request object.
        """

        def __setattr__(self, name, value):
            nonlocal original_user
            if name == 'user':
                stack = inspect.stack()
                # Written this way in case you need more of the stack for debugging.
                location = "\n".join("%30s : %s:%d" % (t[3], t[1], t[2]) for t in stack[0:12])

                if not hasattr(self, 'debug_user_changes'):
                    self.debug_user_changes = []  # pylint: disable=attribute-defined-outside-init

                if not hasattr(request, name):
                    original_user = value
                    if hasattr(value, 'id'):
                        self.debug_user_changes.append(
                            f"SafeCookieData: Setting for the first time: {value.id!r}\n"
                            f"{location}"
                        )
                    else:
                        self.debug_user_changes.append(
                            f"SafeCookieData: Setting for the first time, but user has no id: {value!r}\n"
                            f"{location}"
                        )
                elif value != getattr(request, name):
                    current_user = getattr(request, name)
                    if hasattr(value, 'id'):
                        self.debug_user_changes.append(
                            f"SafeCookieData: Changing request user. "
                            f"Originally {original_user.id!r}, now {current_user.id!r} and will become {value.id!r}\n"
                            f"{location}"
                        )
                    else:
                        self.debug_user_changes.append(
                            f"SafeCookieData: Changing request user but user has no id. "
                            f"Originally {original_user!r}, now {current_user!r} and will become {value!r}\n"
                            f"{location}"
                        )

                else:
                    # Value being set but not actually changing.
                    pass
            return super().__setattr__(name, value)
    request.__class__ = SafeSessionRequestWrapper


def mark_user_change_as_expected(response, new_user_id):
    """
    Indicate to the safe-sessions middleware that it is expected that
    the user is changing between the request and response phase of
    the current request.

    The new_user_id may be None or an LMS user ID, and may be the same
    as the previous user ID.
    """
    response.safe_sessions_expected_user_change = {'new_user_id': new_user_id}
