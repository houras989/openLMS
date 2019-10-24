# -*- coding: utf-8 -*-
#
# Configuration file for the Sphinx documentation builder.
#
# This file does only contain a selection of the most common options. For a
# full list see the documentation:
# http://www.sphinx-doc.org/en/master/config

from __future__ import absolute_import, unicode_literals

import datetime
import os
import sys
from subprocess import check_call

import django
import edx_theme
import six
from path import Path

root = Path('../..').abspath()

# Hack the PYTHONPATH to match what LMS and Studio use so all the code
# can be successfully imported
sys.path.insert(0, root)
sys.path.append(root / "docs/guides")
sys.path.append(root / "cms/djangoapps")
sys.path.append(root / "common/djangoapps")
sys.path.append(root / "common/lib/capa")
sys.path.append(root / "common/lib/safe_lxml")
sys.path.append(root / "common/lib/xmodule")
sys.path.append(root / "lms/djangoapps")
sys.path.append(root / "lms/envs")
sys.path.append(root / "openedx/core/djangoapps")
sys.path.append(root / "openedx/features")

# Use a settings module that allows all LMS and Studio code to be imported
# without errors.  If running sphinx-apidoc, we already set a different
# settings module to use in the on_init() hook of the parent process
if 'DJANGO_SETTINGS_MODULE' not in os.environ:
    os.environ['DJANGO_SETTINGS_MODULE'] = 'docs.docs_settings'

django.setup()

# -- Project information -----------------------------------------------------

project = u'edx-platform'
copyright = edx_theme.COPYRIGHT
author = edx_theme.AUTHOR

# The short X.Y version
version = u''
# The full version, including alpha/beta/rc tags
release = u''


# -- General configuration ---------------------------------------------------

# If your documentation needs a minimal Sphinx version, state it here.
#
# needs_sphinx = '1.0'

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
    'sphinx.ext.autodoc',
    'sphinx.ext.coverage',
    'sphinx.ext.doctest',
    'sphinx.ext.ifconfig',
    'sphinx.ext.intersphinx',
    'sphinx.ext.mathjax',
    'sphinx.ext.napoleon',
]

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# The suffix(es) of source filenames.
# You can specify multiple suffix as a list of string:
#
# source_suffix = ['.rst', '.md']
source_suffix = '.rst'

# The master toctree document.
master_doc = 'index'

# The language for content autogenerated by Sphinx. Refer to documentation
# for a list of supported languages.
#
# This is also used if you do content translation via gettext catalogs.
# Usually you set "language" from the command line for these cases.
language = None

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = [u'_build', 'Thumbs.db', '.DS_Store']

# The name of the Pygments (syntax highlighting) style to use.
pygments_style = None

# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
html_theme = 'edx_theme'

html_theme_path = [edx_theme.get_html_theme_path()]

html_theme_options = {'navigation_depth': 3}

html_favicon = os.path.join(edx_theme.get_html_theme_path(), 'edx_theme', 'static', 'css', 'favicon.ico')

# Theme options are theme-specific and customize the look and feel of a theme
# further.  For a list of options available for each theme, see the
# documentation.
#
# html_theme_options = {}

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static']

# Custom sidebar templates, must be a dictionary that maps document names
# to template names.
#
# The default sidebars (for documents that don't match any pattern) are
# defined by theme itself.  Builtin themes are using these templates by
# default: ``['localtoc.html', 'relations.html', 'sourcelink.html',
# 'searchbox.html']``.
#
# html_sidebars = {}


# -- Options for HTMLHelp output ---------------------------------------------

# Output file base name for HTML help builder.
htmlhelp_basename = 'edx-platformdoc'


# -- Options for LaTeX output ------------------------------------------------

latex_elements = {
    # The paper size ('letterpaper' or 'a4paper').
    #
    # 'papersize': 'letterpaper',

    # The font size ('10pt', '11pt' or '12pt').
    #
    # 'pointsize': '10pt',

    # Additional stuff for the LaTeX preamble.
    #
    # 'preamble': '',

    # Latex figure (float) alignment
    #
    # 'figure_align': 'htbp',
}

# Grouping the document tree into LaTeX files. List of tuples
# (source start file, target name, title,
#  author, documentclass [howto, manual, or own class]).
latex_documents = [
    (master_doc, 'edx-platform.tex', u'edx-platform Documentation',
     author, 'manual'),
]


# -- Options for manual page output ------------------------------------------

# One entry per manual page. List of tuples
# (source start file, name, description, authors, manual section).
man_pages = [
    (master_doc, 'edx-platform', u'edx-platform Documentation',
     [author], 1)
]


# -- Options for Texinfo output ----------------------------------------------

# Grouping the document tree into Texinfo files. List of tuples
# (source start file, target name, title, author,
#  dir menu entry, description, category)
texinfo_documents = [
    (master_doc, 'edx-platform', u'edx-platform Documentation',
     author, 'edx-platform', 'The Open edX platform, the software that powers edX!',
     'Miscellaneous'),
]


# -- Options for Epub output -------------------------------------------------

# Bibliographic Dublin Core info.
epub_title = project

# The unique identifier of the text. This can be a ISBN number
# or the project homepage.
#
# epub_identifier = ''

# A unique identification for the text.
#
# epub_uid = ''

# A list of files that should not be packed into the epub file.
epub_exclude_files = ['search.html']


# -- Extension configuration -------------------------------------------------

# -- Options for intersphinx extension ---------------------------------------

# Example configuration for intersphinx: refer to the Python standard library.
intersphinx_mapping = {
    'https://docs.python.org/2.7': None,
    'django': ('https://docs.djangoproject.com/en/1.11/', 'https://docs.djangoproject.com/en/1.11/_objects/'),
}

# Mock out these external modules during code import to avoid errors
autodoc_mock_imports = [
    'MySQLdb',
    'contracts',
    'django_mysql',
    'pymongo',
]

# Start building a map of the directories relative to the repository root to
# run sphinx-apidoc against and the directories under "docs" in which to store
# the generated *.rst files
modules = {
    'cms': 'cms',
    'common/lib/capa/capa': 'common/lib/capa',
    'common/lib/safe_lxml/safe_lxml': 'common/lib/safe_lxml',
    'common/lib/xmodule/xmodule': 'common/lib/xmodule',
    'lms': 'lms',
    'openedx': 'openedx',
}

# These Django apps under cms don't import correctly with the "cms.djangapps" prefix
# Others don't import correctly without it...INSTALLED_APPS entries are inconsistent
cms_djangoapps = ['contentstore', 'course_creators', 'xblock_config']
for app in cms_djangoapps:
    path = os.path.join('cms', 'djangoapps', app)
    modules[path] = path

# The Django apps under common must be imported directly, not under their path
for app in os.listdir(six.text_type(root / 'common' / 'djangoapps')):
    path = os.path.join('common', 'djangoapps', app)
    if os.path.isdir(six.text_type(root / path)) and app != 'terrain':
        modules[path] = path

# These Django apps under lms don't import correctly with the "lms.djangapps" prefix
# Others don't import correctly without it...INSTALLED_APPS entries are inconsistent
lms_djangoapps = ['badges', 'branding', 'bulk_email', 'courseware',
                  'coursewarehistoryextended', 'email_marketing', 'experiments', 'lti_provider',
                  'mobile_api', 'notes', 'rss_proxy', 'shoppingcart', 'survey']
for app in lms_djangoapps:
    path = os.path.join('lms', 'djangoapps', app)
    modules[path] = path


def update_settings_module(service='lms'):
    """
    Set the "DJANGO_SETTINGS_MODULE" environment variable appropriately
    for the module sphinx-apidoc is about to be run on.
    """
    if os.environ['EDX_PLATFORM_SETTINGS'] == 'devstack_docker':
        settings_module = '{}.envs.devstack_docker'.format(service)
    else:
        settings_module = '{}.envs.devstack'.format(service)
    os.environ['DJANGO_SETTINGS_MODULE'] = settings_module


def on_init(app):  # pylint: disable=unused-argument
    """
    Run sphinx-apidoc after Sphinx initialization.

    Read the Docs won't run tox or custom shell commands, so we need this to
    avoid checking in the generated reStructuredText files.
    """
    docs_path = root / 'docs' / 'guides'
    apidoc_path = 'sphinx-apidoc'
    if hasattr(sys, 'real_prefix'):  # Check to see if we are in a virtualenv
        # If we are, assemble the path manually
        bin_path = os.path.abspath(os.path.join(sys.prefix, 'bin'))
        apidoc_path = os.path.join(bin_path, apidoc_path)
    exclude_dirs = ['envs', 'migrations', 'test', 'tests']
    exclude_dirs.extend(cms_djangoapps)
    exclude_dirs.extend(lms_djangoapps)
    exclude_files = ['admin.py', 'test.py', 'testing.py', 'tests.py', 'testutils.py', 'wsgi.py']
    for module in modules:
        module_path = six.text_type(root / module)
        output_path = six.text_type(docs_path / modules[module])
        args = [apidoc_path, '--ext-intersphinx', '-o',
                output_path, module_path]
        exclude = []
        if module == 'cms':
            update_settings_module('cms')
        else:
            update_settings_module('lms')
        for dirpath, dirnames, filenames in os.walk(module_path):
            to_remove = []
            for name in dirnames:
                if name in exclude_dirs:
                    to_remove.append(name)
                    exclude.append(os.path.join(dirpath, name))
            if 'features' in dirnames and 'openedx' not in dirpath:
                to_remove.append('features')
                exclude.append(os.path.join(dirpath, 'features'))
            for name in to_remove:
                dirnames.remove(name)
            for name in filenames:
                if name in exclude_files:
                    exclude.append(os.path.join(dirpath, name))
        if exclude:
            args.extend(exclude)
        check_call(args)


def setup(app):
    """Sphinx extension: run sphinx-apidoc."""
    event = b'builder-inited' if six.PY2 else 'builder-inited'
    app.connect(event, on_init)
