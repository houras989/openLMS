"""
Run and manage servers for local development.
"""
from __future__ import print_function
import sys
import argparse
from paver.easy import *
from .utils.cmd import django_cmd
from .utils.process import run_process, run_multi_processes


DEFAULT_PORT = {"lms": 8000, "studio": 8001}
DEFAULT_SETTINGS = 'devstack'


def run_server(system, settings=None, port=None, skip_assets=False, watch_assets=False, contracts=False):
    """
    Start the server for the specified `system` (lms or studio).
    `settings` is the Django settings module to use; if not provided, use the default.
    `port` is the port to run the server on; if not provided, use the default port for the system.

    If `skip_assets` is True, skip the asset compilation step.
    If `watch_assets` is True, watch for assets modifications.
    """
    if system not in ['lms', 'studio']:
        print("System must be either lms or studio", file=sys.stderr)
        exit(1)

    if not settings:
        settings = DEFAULT_SETTINGS

    if not skip_assets:
        # Local dev settings use staticfiles to serve assets, so we can skip the collecstatic step
        args = [system, '--settings={}'.format(settings), '--skip-collect']
        call_task('pavelib.assets.update_assets', args=args)

    if watch_assets:
        call_task('pavelib.assets.watch_assets', options={
            'background': True,
            'systems': [system]
        })

    if port is None:
        port = DEFAULT_PORT[system]

    args = [settings, 'runserver', '--traceback', '--pythonpath=.', '0.0.0.0:{}'.format(port)]

    if contracts:
        args.append("--contracts")

    run_process(django_cmd(system, *args))


@task
@needs('pavelib.prereqs.install_prereqs')
@cmdopts([
    ("settings=", "s", "Django settings"),
    ("port=", "p", "Port"),
    ("fast", "f", "Skip updating assets"),
    ("watch", "w", "Watch assets modifications")
])
def lms(options):
    """
    Run the LMS server.
    """
    settings = getattr(options, 'settings', None)
    port = getattr(options, 'port', None)
    fast = getattr(options, 'fast', False)
    watch = getattr(options, 'watch', False)
    run_server('lms', settings=settings, port=port, skip_assets=fast, watch_assets=watch)


@task
@needs('pavelib.prereqs.install_prereqs')
@cmdopts([
    ("settings=", "s", "Django settings"),
    ("port=", "p", "Port"),
    ("fast", "f", "Skip updating assets"),
    ("watch", "w", "Watch assets modifications")
])
def studio(options):
    """
    Run the Studio server.
    """
    settings = getattr(options, 'settings', None)
    port = getattr(options, 'port', None)
    fast = getattr(options, 'fast', False)
    watch = getattr(options, 'watch', False)
    run_server('studio', settings=settings, port=port, skip_assets=fast, watch_assets=watch)


@task
@needs('pavelib.prereqs.install_prereqs')
@consume_args
@no_help
def devstack(args):
    """
    Start the devstack lms or studio server
    """
    parser = argparse.ArgumentParser(prog='paver devstack')
    parser.add_argument('system', type=str, nargs=1, help="lms or studio")
    parser.add_argument('--fast', action='store_true', default=False, help="Watch assets modifications")
    parser.add_argument('--watch', action='store_true', default=False, help="Skip updating assets")
    parser.add_argument(
        '--no-contracts',
        action='store_true',
        default=False,
        help="Disable contracts. By default, they're enabled in devstack."
    )
    args = parser.parse_args(args)
    run_server(args.system[0], settings='devstack', skip_assets=args.fast, watch_assets=args.watch, contracts=(not args.no_contracts))


@task
@needs('pavelib.prereqs.install_prereqs')
@cmdopts([
    ("settings=", "s", "Django settings"),
])
def celery(options):
    """
    Runs Celery workers.
    """
    settings = getattr(options, 'settings', 'dev_with_worker')
    run_process(django_cmd('lms', settings, 'celery', 'worker', '--loglevel=INFO', '--pythonpath=.'))


@task
@needs('pavelib.prereqs.install_prereqs')
@cmdopts([
    ("settings=", "s", "Django settings for both LMS and Studio"),
    ("worker_settings=", "w", "Celery worker Django settings"),
    ("fast", "f", "Skip updating assets"),
    ("watch", "w", "Watch assets modifications"),
    ("settings_lms=", "l", "Set LMS only, overriding the value from --settings (if provided)"),
    ("settings_cms=", "c", "Set Studio only, overriding the value from --settings (if provided)"),
])
def run_all_servers(options):
    """
    Runs Celery workers, Studio, and LMS.
    """
    settings = getattr(options, 'settings', DEFAULT_SETTINGS)
    settings_lms = getattr(options, 'settings_lms', settings)
    settings_cms = getattr(options, 'settings_cms', settings)
    worker_settings = getattr(options, 'worker_settings', 'dev_with_worker')
    fast = getattr(options, 'fast', False)
    watch = getattr(options, 'watch', False)

    if not fast:
        args = ['lms', '--settings={}'.format(settings_lms), '--skip-collect']
        call_task('pavelib.assets.update_assets', args=args)

        args = ['studio', '--settings={}'.format(settings_cms), '--skip-collect']
        call_task('pavelib.assets.update_assets', args=args)

    if watch:
        call_task('pavelib.assets.watch_assets', options={
            'background': True,
            'systems': ['lms', 'studio']
        })

    run_multi_processes([
        django_cmd('lms', settings_lms, 'runserver', '--traceback', '--pythonpath=.', "0.0.0.0:{}".format(DEFAULT_PORT['lms'])),
        django_cmd('studio', settings_cms, 'runserver', '--traceback', '--pythonpath=.', "0.0.0.0:{}".format(DEFAULT_PORT['studio'])),
        django_cmd('lms', worker_settings, 'celery', 'worker', '--loglevel=INFO', '--pythonpath=.')
    ])


@task
@needs('pavelib.prereqs.install_prereqs')
@cmdopts([
    ("settings=", "s", "Django settings"),
])
def update_db():
    """
    Runs syncdb and then migrate.
    """
    settings = getattr(options, 'settings', DEFAULT_SETTINGS)
    for system in ('lms', 'cms'):
        sh(django_cmd(system, settings, 'syncdb', '--migrate', '--traceback', '--pythonpath=.'))


@task
@needs('pavelib.prereqs.install_prereqs')
@consume_args
def check_settings(args):
    """
    Checks settings files.
    """
    parser = argparse.ArgumentParser(prog='paver check_settings')
    parser.add_argument('system', type=str, nargs=1, help="lms or studio")
    parser.add_argument('settings', type=str, nargs=1, help='Django settings')
    args = parser.parse_args(args)

    system = args.system[0]
    settings = args.settings[0]

    try:
        import_cmd = "echo 'import {system}.envs.{settings}'".format(system=system, settings=settings)
        django_shell_cmd = django_cmd(system, settings, 'shell', '--plain', '--pythonpath=.')
        sh("{import_cmd} | {shell_cmd}".format(import_cmd=import_cmd, shell_cmd=django_shell_cmd))

    except:
        print("Failed to import settings", file=sys.stderr)
