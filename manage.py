#!/usr/bin/env python
"""
Usage: manage.py {lms|cms} [-e env] ...

Run django management commands. Because edx-platform contains multiple django projects,
the first argument specifies which project to run (cms [Studio] or lms [Learning Management System]).

By default, those systems run in with a settings file appropriate for development. However,
by passing the --environment flag, you can specify what environment specific settings file to use.

Any arguments not understood by this manage.py will be passed to django-admin.py
"""

import os
import sys
import glob2
from argparse import ArgumentParser

def environments_for_service(service):
    """Yields a list of settings modules for service

    Each settings module is a submodule of {service}.envs.
    Ignores any __init__.py files.
    """
    env_prefix = '{}/envs/'.format(service)
    modules = glob2.glob("{}**/*.py".format(env_prefix))
    for module_path in modules:
        if module_path.endswith('__init__.py'):
            continue
        yield module_path[len(env_prefix):-3].replace('/', '.')


def parse_args():
    """Parse edx specific arguments to manage.py"""
    parser = ArgumentParser(add_help=False)
    subparsers = parser.add_subparsers(title='system', description='edx service to run')

    lms = subparsers.add_parser(
        'lms',
        help='Learning Management System',
        add_help=False,
        usage='%(prog)s [options] ...'
    )
    lms.add_argument('-h', '--help', action='store_true', help='show this help message and exit')
    lms.add_argument(
        '-e', '--environment',
        choices=list(environments_for_service('lms')),
        default='dev',
        help='Which environment settings module to use')
    lms.add_argument(
        '-s', '--service-variant',
        choices=['lms', 'lms-xml', 'lms-preview'],
        default='lms',
        help='Which service variant to run, when using the aws environment')
    lms.set_defaults(help_string=lms.format_help(), env_base='lms.envs')

    cms = subparsers.add_parser(
        'cms',
        help='Studio',
        add_help=False,
        usage='%(prog)s [options] ...'
    )
    cms.add_argument(
        '-e', '--environment',
        choices=list(environments_for_service('cms')),
        default='dev',
        help='Which environment settings module to use')
    cms.add_argument('-h', '--help', action='store_true', help='show this help message and exit')
    cms.set_defaults(help_string=cms.format_help(), env_base='cms.envs', service_variant='cms')


    edx_args, django_args = parser.parse_known_args()

    if edx_args.help:
        print "edX:"
        print edx_args.help_string

    return edx_args, django_args


if __name__ == "__main__":
    edx_args, django_args = parse_args()

    os.environ.setdefault("DJANGO_SETTINGS_MODULE", edx_args.env_base + '.' + edx_args.environment)
    os.environ.setdefault("SERVICE_VARIANT", edx_args.service_variant)
    if edx_args.help:
        print "Django:"
        # This will trigger django-admin.py to print out its help
        django_args.insert(0, '--help')

    from django.core.management import execute_from_command_line

    execute_from_command_line([sys.argv[0]] + django_args)