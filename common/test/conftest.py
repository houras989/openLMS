"""Code run by pylint before running any tests."""

# Patch the xml libs before anything else.
from __future__ import absolute_import

import openedx.core.tests.pytest_hooks.pytest_json_modifyreport as custom_hook # pylint: disable=unused-import

from safe_lxml import defuse_xml_libs

defuse_xml_libs()


class DeferPlugin:
    """Simple plugin to defer pytest-xdist hook functions."""

    def pytest_json_modifyreport(self, json_report):
        """standard xdist hook function.
        """
        return custom_hook(json_report)


def pytest_configure(config):
    if config.pluginmanager.hasplugin("json-report"):
        config.pluginmanager.register(DeferPlugin())