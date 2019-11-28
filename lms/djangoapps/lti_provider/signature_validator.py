"""
Subclass of oauthlib's RequestValidator that checks an OAuth signature.
"""

from __future__ import absolute_import

import six
from oauthlib.oauth1 import RequestValidator, SignatureOnlyEndpoint


class SignatureValidator(RequestValidator):
    """
    Helper class that verifies the OAuth signature on a request.

    The pattern required by the oauthlib library mandates that subclasses of
    RequestValidator contain instance methods that can be called back into in
    order to fetch the consumer secret or to check that fields conform to
    application-specific requirements.
    """

    def __init__(self, lti_consumer):
        super(SignatureValidator, self).__init__()
        self.endpoint = SignatureOnlyEndpoint(self)
        self.lti_consumer = lti_consumer

    # The OAuth signature uses the endpoint URL as part of the request to be
    # hashed. By default, the oauthlib library rejects any URLs that do not
    # use HTTPS. We turn this behavior off in order to allow edX to run without
    # SSL in development mode. When the platform is deployed and running with
    # SSL enabled, the URL passed to the signature verifier must start with
    # 'https', otherwise the message signature would not match the one generated
    # on the platform.
    enforce_ssl = False

    def check_client_key(self, key):
        """
        Verify that the key supplied by the LTI consumer is valid for an LTI
        launch. This method is only concerned with the structure of the key;
        whether the key is associated with a known LTI consumer is checked in
        validate_client_key. This method signature is required by the oauthlib
        library.

        :return: True if the client key is valid, or False if it is not.
        """
        return key is not None and 0 < len(key) <= 32

    def check_nonce(self, nonce):
        """
        Verify that the nonce value that accompanies the OAuth signature is
        valid. This method is concerned only with the structure of the nonce;
        the validate_timestamp_and_nonce method will check that the nonce has
        not been used within the specified time frame. This method signature is
        required by the oauthlib library.

        :return: True if the OAuth nonce is valid, or False if it is not.
        """
        return nonce is not None and 0 < len(nonce) <= 64

    def validate_timestamp_and_nonce(self, client_key, timestamp, nonce,
                                     request, request_token=None,
                                     access_token=None):
        """
        Verify that the request is not too old (according to the timestamp), and
        that the nonce value has not been used already within the period of time
        in which the timestamp marks a request as valid. This method signature
        is required by the oauthlib library.

        :return: True if the OAuth nonce and timestamp are valid, False if they
        are not.
        """
        return True

    def validate_client_key(self, client_key, request):
        """
        Ensure that the client key supplied with the LTI launch is on that has
        been generated by our platform, and that it has an associated client
        secret.

        :return: True if the key is valid, False if it is not.
        """
        return self.lti_consumer.consumer_key == client_key

    def get_client_secret(self, client_key, request):
        """
        Fetch the client secret from the database. This method signature is
        required by the oauthlib library.

        :return: the client secret that corresponds to the supplied key if
        present, or None if the key does not exist in the database.
        """
        return self.lti_consumer.consumer_secret

    def verify(self, request):
        """
        Check the OAuth signature on a request. This method uses the
        SignatureEndpoint class in the oauthlib library that in turn calls back
        to the other methods in this class.

        :param request: the HttpRequest object to be verified
        :return: True if the signature matches, False if it does not.
        """

        method = six.text_type(request.method)
        url = request.build_absolute_uri()
        body = request.body

        # The oauthlib library assumes that headers are passed directly from the
        # request, but Django mangles them into its own format. The only header
        # that the library requires (for now) is 'Content-Type', so we
        # reconstruct just that one.
        headers = {"Content-Type": request.META['CONTENT_TYPE']}
        result, __ = self.endpoint.validate_request(url, method, body, headers)
        return result

    def get_request_token_secret(self, client_key, token, request):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError

    def get_redirect_uri(self, token, request):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError

    def get_realms(self, token, request):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError

    def invalidate_request_token(self, client_key, request_token, request):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError

    def get_rsa_key(self, client_key, request):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError

    def dummy_access_token(self):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError

    def dummy_client(self):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError

    def verify_realms(self, token, realms, request):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError

    def validate_realms(self, client_key, token, request, uri=None,
                        realms=None):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError

    def save_verifier(self, token, verifier, request):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError

    def dummy_request_token(self):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError

    def validate_redirect_uri(self, client_key, redirect_uri, request):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError

    def verify_request_token(self, token, request):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError

    def validate_request_token(self, client_key, token, request):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError

    def get_default_realms(self, client_key, request):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError

    def validate_access_token(self, client_key, token, request):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError

    def save_access_token(self, token, request):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError

    def validate_requested_realms(self, client_key, realms, request):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError

    def validate_verifier(self, client_key, token, verifier, request):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError

    def save_request_token(self, token, request):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError

    def get_access_token_secret(self, client_key, token, request):
        """
        Unused abstract method from super class. See documentation in RequestValidator
        """
        raise NotImplementedError
