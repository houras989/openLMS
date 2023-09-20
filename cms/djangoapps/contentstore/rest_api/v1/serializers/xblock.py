"""
API Serializers for xblocks
"""
from rest_framework import serializers
from .common import StrictSerializer

class XblockSerializer(StrictSerializer):
    """
    Strict Serializer for xblocks.
    Validates top-level field types and that no extra fields are passed in.
    This is an incomplete list of fields currently, designed so that the CMS API demo works.

    Optional fields that were easy to discover were added.
    """
    id=serializers.CharField(required=False)
    parent_locator=serializers.CharField(required=False, allow_null=True)
    display_name=serializers.CharField(required=False, allow_null=True)
    category=serializers.CharField(required=False, allow_null=True)
    data=serializers.CharField(required=False, allow_null=True)
    metadata=serializers.DictField(required=False, allow_null=True)
    has_changes=serializers.BooleanField(required=False, allow_null=True)
    publish=serializers.CharField(required=False, allow_null=True)   # this takes one of several string values
    children=serializers.ListField(required=False, allow_null=True)
    fields=serializers.DictField(required=False, allow_null=True)
    has_children=serializers.BooleanField(required=False, allow_null=True)
    video_sharing_enabled=serializers.BooleanField(required=False, allow_null=True)
    video_sharing_options=serializers.CharField(required=False, allow_null=True)
    video_sharing_doc_url=serializers.CharField(required=False, allow_null=True)
    edited_on=serializers.CharField(required=False, allow_null=True)
    published=serializers.BooleanField(required=False, allow_null=True)
    published_on=serializers.JSONField(required=False, allow_null=True)
    studio_url=serializers.CharField(required=False, allow_null=True)
    released_to_students=serializers.BooleanField(required=False, allow_null=True)
    release_date=serializers.JSONField(required=False, allow_null=True)
    visibility_state=serializers.CharField(required=False, allow_null=True)
    has_explicit_staff_lock=serializers.BooleanField(required=False, allow_null=True)
    start=serializers.CharField(required=False, allow_null=True)
    graded=serializers.BooleanField(required=False, allow_null=True)
    due_date=serializers.CharField(required=False, allow_null=True)
    due=serializers.JSONField(required=False, allow_null=True)
    relative_weeks_due=serializers.JSONField(required=False, allow_null=True)
    format=serializers.JSONField(required=False, allow_null=True)
    course_graders=serializers.ListField(required=False, allow_null=True)
    actions=serializers.DictField(required=False, allow_null=True)
    explanatory_message=serializers.Field(required=False, allow_null=True)
    group_access=serializers.DictField(required=False, allow_null=True)
    user_partitions=serializers.ListField(required=False, allow_null=True)
    show_correctness=serializers.CharField(required=False, allow_null=True)
    discussion_enabled=serializers.BooleanField(required=False, allow_null=True)
    ancestor_has_staff_lock=serializers.BooleanField(required=False, allow_null=True)
    user_partition_info=serializers.DictField(required=False, allow_null=True)
    summary_configuration_enabled=serializers.JSONField(required=False, allow_null=True)
