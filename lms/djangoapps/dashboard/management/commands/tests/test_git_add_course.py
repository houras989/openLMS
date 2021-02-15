import pytest
"""
Provide tests for git_add_course management command.
"""


import logging
import os
import shutil
import subprocess
import unittest
from uuid import uuid4

import six
from django.conf import settings
from django.core.management import call_command
from django.core.management.base import CommandError
from django.test.utils import override_settings
from opaque_keys.edx.keys import CourseKey
from six import StringIO

import lms.djangoapps.dashboard.git_import as git_import
from lms.djangoapps.dashboard.git_import import (
    GitImportError,
    GitImportErrorBadRepo,
    GitImportErrorCannotPull,
    GitImportErrorNoDir,
    GitImportErrorRemoteBranchMissing,
    GitImportErrorUrlBad
)
from xmodule.modulestore import ModuleStoreEnum
from xmodule.modulestore.django import modulestore
from xmodule.modulestore.tests.django_utils import SharedModuleStoreTestCase
from xmodule.modulestore.tests.mongo_connection import MONGO_HOST, MONGO_PORT_NUM

TEST_MONGODB_LOG = {
    'host': MONGO_HOST,
    'port': MONGO_PORT_NUM,
    'user': '',
    'password': '',
    'db': 'test_xlog',
}


@override_settings(
    MONGODB_LOG=TEST_MONGODB_LOG,
    GIT_REPO_DIR=settings.TEST_ROOT / "course_repos_{}".format(uuid4().hex)
)
@unittest.skipUnless(settings.FEATURES.get('ENABLE_SYSADMIN_DASHBOARD'),
                     "ENABLE_SYSADMIN_DASHBOARD not set")
class TestGitAddCourse(SharedModuleStoreTestCase):
    """
    Tests the git_add_course management command for proper functions.
    """
    TEST_REPO = 'https://github.com/edx/edx4edx_lite.git'
    TEST_COURSE = 'MITx/edx4edx/edx4edx'
    TEST_BRANCH = 'testing_do_not_delete'
    TEST_BRANCH_COURSE = CourseKey.from_string('MITx/edx4edx_branch/edx4edx')

    ENABLED_CACHES = ['default', 'mongo_metadata_inheritance', 'loc_cache']

    def setUp(self):
        super(TestGitAddCourse, self).setUp()  # lint-amnesty, pylint: disable=super-with-arguments
        self.git_repo_dir = settings.GIT_REPO_DIR

    def assertCommandFailureRegexp(self, regex, *args):
        """
        Convenience function for testing command failures
        """
        with self.assertRaisesRegex(CommandError, regex):
            call_command('git_add_course', *args, stderr=StringIO())

    def test_command_args(self):
        """
        Validate argument checking
        """
        # No argument given.
        if six.PY2:
            self.assertCommandFailureRegexp('Error: too few arguments')
        else:
            self.assertCommandFailureRegexp('Error: the following arguments are required: repository_url')
        # Extra/Un-named arguments given.
        self.assertCommandFailureRegexp(
            'Error: unrecognized arguments: blah blah blah',
            'blah', 'blah', 'blah', 'blah')
        # Not a valid path.
        self.assertCommandFailureRegexp(
            u'Path {0} doesn\'t exist, please create it,'.format(self.git_repo_dir),
            'blah')
        # Test successful import from command
        if not os.path.isdir(self.git_repo_dir):
            os.mkdir(self.git_repo_dir)
        self.addCleanup(shutil.rmtree, self.git_repo_dir)

        # Make a course dir that will be replaced with a symlink
        # while we are at it.
        if not os.path.isdir(self.git_repo_dir / 'edx4edx'):
            os.mkdir(self.git_repo_dir / 'edx4edx')

        call_command('git_add_course', self.TEST_REPO,
                     directory_path=self.git_repo_dir / 'edx4edx_lite')

        # Test with all three args (branch)
        call_command('git_add_course', self.TEST_REPO,
                     directory_path=self.git_repo_dir / 'edx4edx_lite',
                     repository_branch=self.TEST_BRANCH)

    def test_add_repo(self):
        """
        Various exit path tests for test_add_repo
        """
        with pytest.raises(GitImportErrorNoDir):
            git_import.add_repo(self.TEST_REPO, None, None)

        os.mkdir(self.git_repo_dir)
        self.addCleanup(shutil.rmtree, self.git_repo_dir)

        with pytest.raises(GitImportErrorUrlBad):
            git_import.add_repo('foo', None, None)

        with pytest.raises(GitImportErrorCannotPull):
            git_import.add_repo('file:///foobar.git', None, None)

        # Test git repo that exists, but is "broken"
        bare_repo = os.path.abspath('{0}/{1}'.format(settings.TEST_ROOT, 'bare.git'))
        os.mkdir(bare_repo)
        self.addCleanup(shutil.rmtree, bare_repo)
        subprocess.check_output(['git', '--bare', 'init', ], stderr=subprocess.STDOUT,
                                cwd=bare_repo)

        with pytest.raises(GitImportErrorBadRepo):
            git_import.add_repo('file://{0}'.format(bare_repo), None, None)

    def test_detached_repo(self):
        """
        Test repo that is in detached head state.
        """
        repo_dir = self.git_repo_dir
        # Test successful import from command
        try:
            os.mkdir(repo_dir)
        except OSError:
            pass
        self.addCleanup(shutil.rmtree, repo_dir)
        git_import.add_repo(self.TEST_REPO, repo_dir / 'edx4edx_lite', None)
        subprocess.check_output(['git', 'checkout', 'HEAD~2', ],
                                stderr=subprocess.STDOUT,
                                cwd=repo_dir / 'edx4edx_lite')
        with pytest.raises(GitImportErrorCannotPull):
            git_import.add_repo(self.TEST_REPO, repo_dir / 'edx4edx_lite', None)

    def test_branching(self):
        """
        Exercise branching code of import
        """
        repo_dir = self.git_repo_dir
        # Test successful import from command
        if not os.path.isdir(repo_dir):
            os.mkdir(repo_dir)
        self.addCleanup(shutil.rmtree, repo_dir)

        # Checkout non existent branch
        with pytest.raises(GitImportErrorRemoteBranchMissing):
            git_import.add_repo(self.TEST_REPO, repo_dir / 'edx4edx_lite', 'asdfasdfasdf')

        # Checkout new branch
        git_import.add_repo(self.TEST_REPO,
                            repo_dir / 'edx4edx_lite',
                            self.TEST_BRANCH)
        def_ms = modulestore()
        # Validate that it is different than master
        assert def_ms.get_course(self.TEST_BRANCH_COURSE) is not None

        # Attempt to check out the same branch again to validate branch choosing
        # works
        git_import.add_repo(self.TEST_REPO,
                            repo_dir / 'edx4edx_lite',
                            self.TEST_BRANCH)

        # Delete to test branching back to master
        def_ms.delete_course(self.TEST_BRANCH_COURSE, ModuleStoreEnum.UserID.test)
        assert def_ms.get_course(self.TEST_BRANCH_COURSE) is None
        git_import.add_repo(self.TEST_REPO,
                            repo_dir / 'edx4edx_lite',
                            'master')
        assert def_ms.get_course(self.TEST_BRANCH_COURSE) is None
        assert def_ms.get_course(CourseKey.from_string(self.TEST_COURSE)) is not None

    def test_branch_exceptions(self):
        """
        This wil create conditions to exercise bad paths in the switch_branch function.
        """
        # create bare repo that we can mess with and attempt an import
        bare_repo = os.path.abspath('{0}/{1}'.format(settings.TEST_ROOT, 'bare.git'))
        os.mkdir(bare_repo)
        self.addCleanup(shutil.rmtree, bare_repo)
        subprocess.check_output(['git', '--bare', 'init', ], stderr=subprocess.STDOUT,
                                cwd=bare_repo)

        # Build repo dir
        repo_dir = self.git_repo_dir
        if not os.path.isdir(repo_dir):
            os.mkdir(repo_dir)
        self.addCleanup(shutil.rmtree, repo_dir)

        rdir = '{0}/bare'.format(repo_dir)
        with pytest.raises(GitImportErrorBadRepo):
            git_import.add_repo('file://{0}'.format(bare_repo), None, None)

        # Get logger for checking strings in logs
        output = StringIO()
        test_log_handler = logging.StreamHandler(output)
        test_log_handler.setLevel(logging.DEBUG)
        glog = git_import.log
        glog.addHandler(test_log_handler)

        # Move remote so fetch fails
        shutil.move(bare_repo, '{0}/not_bare.git'.format(settings.TEST_ROOT))
        try:
            git_import.switch_branch('master', rdir)
        except GitImportError:
            assert 'Unable to fetch remote' in output.getvalue()
        shutil.move('{0}/not_bare.git'.format(settings.TEST_ROOT), bare_repo)
        output.truncate(0)

        # Replace origin with a different remote
        subprocess.check_output(
            ['git', 'remote', 'rename', 'origin', 'blah', ],
            stderr=subprocess.STDOUT, cwd=rdir
        )
        with pytest.raises(GitImportError):
            git_import.switch_branch('master', rdir)
        assert 'Getting a list of remote branches failed' in output.getvalue()
