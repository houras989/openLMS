"""
Middleware for monitoring the LMS
"""
import logging
from django.urls import resolve
from edx_django_utils.cache import DEFAULT_REQUEST_CACHE
from edx_django_utils.monitoring import set_custom_metric

from .utils import get_code_owner_from_module, is_code_owner_mappings_configured

log = logging.getLogger(__name__)


class CodeOwnerMetricMiddleware:
    """
    Django middleware object to set custom metrics for the owner of each view.

    Custom metrics set:
    - code_owner: The owning team mapped to the current view.
    - code_owner_mapping_error: If there are any errors when trying to perform the mapping.
    - view_func_module: The __module__ of the view_func, which can be used to
        find missing mappings.

    """
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        self._set_owner_metrics_for_request(request)
        response = self.get_response(request)
        return response

    def process_view(self, request, view_func, view_args, view_kwargs):
        self._set_owner_metrics_for_view_func(view_func)

    def _set_owner_metrics_for_request(self, request):
        """
        Uses the request path to find the view_func and then sets code owner metrics based on the view.
        """
        if not is_code_owner_mappings_configured():
            return

        try:
            view_func, _, _ = resolve(request.path)
            self._set_owner_metrics_for_view_func(view_func)
        except Exception as e:
            set_custom_metric('code_owner_mapping_error', e)

    _VIEW_FUNC_MODULE_METRIC_CACHE_KEY = '{}.view_func_module_metric'.format(__file__)

    def _set_owner_metrics_for_view_func(self, view_func):
        """
        Set custom metrics for the code_owner of the view if configured to do so.
        """
        if not is_code_owner_mappings_configured():
            return

        try:
            view_func_module = view_func.__module__
            self._set_view_func_compare_metric(view_func_module)
            set_custom_metric('view_func_module', view_func_module)
            code_owner = get_code_owner_from_module(view_func_module)
            if code_owner:
                set_custom_metric('code_owner', code_owner)
        except Exception as e:
            set_custom_metric('code_owner_mapping_error', e)

    def _set_view_func_compare_metric(self, view_func_module):
        """
        Set temporary metric to ensure that the view_func of `process_view` always matches
        the one from using `resolve` on the request.
        """
        cached_response = DEFAULT_REQUEST_CACHE.get_cached_response(self._VIEW_FUNC_MODULE_METRIC_CACHE_KEY)
        if cached_response.is_found:
            view_func_compare = 'success' if view_func_module == cached_response.value else view_func_module
            set_custom_metric('temp_view_func_compare', view_func_compare)
        else:
            DEFAULT_REQUEST_CACHE.set(self._VIEW_FUNC_MODULE_METRIC_CACHE_KEY, view_func_module)
