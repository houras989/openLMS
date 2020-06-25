"""Map new event context values to old top-level field values. Ensures events can be parsed by legacy parsers."""


import json

from .transformers import EventTransformerRegistry

CONTEXT_FIELDS_TO_INCLUDE = [
    'username',
    'session',
    'ip',
    'agent',
    'host',
    'referer',
    'accept_language'
]


class LegacyFieldMappingProcessor(object):
    """Ensures all required fields are included in emitted events"""

    def __call__(self, event):
        context = event.get('context', {})
        if 'context' in event:
            delete_from_context = True if context.get('event_source', '') != 'task' else False
            for field in CONTEXT_FIELDS_TO_INCLUDE:
                self.move_from_context(field, event, delete_from_context=delete_from_context)
            if delete_from_context:
                remove_shim_context(event)

        if 'data' in event:
            if context.get('event_source', '') == 'browser' and isinstance(event['data'], dict):
                event['event'] = json.dumps(event['data'])
            else:
                event['event'] = event['data']
            del event['data']
        else:
            event['event'] = {}

        if 'timestamp' in context:
            event['time'] = context['timestamp']
            del context['timestamp']
        elif 'timestamp' in event:
            event['time'] = event['timestamp']

        if 'timestamp' in event:
            del event['timestamp']

        self.move_from_context('event_type', event, event.get('name', ''))
        self.move_from_context('event_source', event, 'server')
        self.move_from_context('page', event, None)

    def move_from_context(self, field, event, default_value='', delete_from_context=True):
        """Move a field from the context to the top level of the event."""
        context = event.get('context', {})
        if field in context:
            event[field] = context[field]
            if delete_from_context:
                del context[field]
        else:
            event[field] = default_value


def remove_shim_context(event):
    """
    Remove obsolete fields from event context.
    """
    if 'context' in event:
        context = event['context']
        # These fields are present elsewhere in the event at this point
        context_fields_to_remove = set(CONTEXT_FIELDS_TO_INCLUDE)
        # This field is only used for Segment web analytics and does not concern researchers
        context_fields_to_remove.add('client_id')
        for field in context_fields_to_remove:
            if field in context:
                del context[field]


class GoogleAnalyticsProcessor(object):
    """Adds course_id as label, and sets nonInteraction property"""

    # documentation of fields here: https://segment.com/docs/integrations/google-analytics/
    # this should *only* be used on events destined for segment.com and eventually google analytics
    def __call__(self, event):
        context = event.get('context', {})
        course_id = context.get('course_id')

        copied_event = event.copy()
        if course_id is not None:
            copied_event['label'] = course_id

        copied_event['nonInteraction'] = 1

        return copied_event


class PrefixedEventProcessor(object):
    """
    Process any events whose name or prefix (ending with a '.') is registered
    as an EventTransformer.
    """

    def __call__(self, event):
        """
        If the event is registered with the EventTransformerRegistry, transform
        it.  Otherwise do nothing to it, and continue processing.
        """
        try:
            event = EventTransformerRegistry.create_transformer(event)
        except KeyError:
            return
        event.transform()
        return event
