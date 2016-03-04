"""Tools for helping with testing capa."""

import gettext
import os
import os.path

import fs.osfs

from capa.capa_problem import LoncapaProblem, LoncapaSystem
from capa.inputtypes import Status
from mock import Mock, MagicMock

import xml.sax.saxutils as saxutils

TEST_DIR = os.path.dirname(os.path.realpath(__file__))


def tst_render_template(template, context):
    """
    A test version of render to template.  Renders to the repr of the context, completely ignoring
    the template name.  To make the output valid xml, quotes the content, and wraps it in a <div>
    """
    return '<div>{0}</div>'.format(saxutils.escape(repr(context)))


def calledback_url(dispatch='score_update'):
    return dispatch

xqueue_interface = MagicMock()
xqueue_interface.send_to_queue.return_value = (0, 'Success!')


def test_capa_system():
    """
    Construct a mock LoncapaSystem instance.

    """
    __test__ = False  # Do not discover this with the test runner.

    the_system = Mock(
        spec=LoncapaSystem,
        ajax_url='/dummy-ajax-url',
        anonymous_student_id='student',
        cache=None,
        can_execute_unsafe_code=lambda: False,
        get_python_lib_zip=lambda: None,
        DEBUG=True,
        filestore=fs.osfs.OSFS(os.path.join(TEST_DIR, "test_files")),
        i18n=gettext.NullTranslations(),
        node_path=os.environ.get("NODE_PATH", "/usr/local/lib/node_modules"),
        render_template=tst_render_template,
        seed=0,
        STATIC_URL='/dummy-static/',
        STATUS_CLASS=Status,
        xqueue={'interface': xqueue_interface, 'construct_callback': calledback_url, 'default_queuename': 'testqueue', 'waittime': 10},
    )
    return the_system


def mock_capa_module():
    """
    capa response types needs just two things from the capa_module: location and track_function.
    """
    capa_module = Mock()
    capa_module.location.to_deprecated_string.return_value = 'i4x://Foo/bar/mock/abc'
    # The following comes into existence by virtue of being called
    # capa_module.runtime.track_function
    return capa_module


def new_loncapa_problem(xml, capa_system=None, seed=723):
    """Construct a `LoncapaProblem` suitable for unit tests."""
    return LoncapaProblem(xml, id='1', seed=seed, capa_system=capa_system or test_capa_system(),
                          capa_module=mock_capa_module())


def load_fixture(relpath):
    """
    Return a `unicode` object representing the contents
    of the fixture file at the given path within a test_files directory
    in the same directory as the test file.
    """
    abspath = os.path.join(os.path.dirname(__file__), 'test_files', relpath)
    with open(abspath) as fixture_file:
        contents = fixture_file.read()
    return contents.decode('utf8')
