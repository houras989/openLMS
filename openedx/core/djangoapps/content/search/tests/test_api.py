"""
Tests for the Studio content search API.
"""
from __future__ import annotations

import copy

from datetime import datetime, timezone
from unittest.mock import MagicMock, call, patch
from opaque_keys.edx.keys import UsageKey

import ddt
from django.test import override_settings
from freezegun import freeze_time
from organizations.tests.factories import OrganizationFactory

from common.djangoapps.student.tests.factories import UserFactory
from openedx.core.djangoapps.content_libraries import api as library_api
from openedx.core.djangoapps.content_tagging import api as tagging_api
from openedx.core.djangoapps.content.course_overviews.api import CourseOverview
from openedx.core.djangolib.testing.utils import skip_unless_cms
from xmodule.modulestore.tests.django_utils import TEST_DATA_SPLIT_MODULESTORE, ModuleStoreTestCase


try:
    # This import errors in the lms because content.search is not an installed app there.
    from .. import api
    from ..models import SearchAccess
except RuntimeError:
    SearchAccess = {}

STUDIO_SEARCH_ENDPOINT_URL = "/api/content_search/v2/studio/"


@ddt.ddt
@skip_unless_cms
@patch("openedx.core.djangoapps.content.search.api._wait_for_meili_task", new=MagicMock(return_value=None))
@patch("openedx.core.djangoapps.content.search.api.MeilisearchClient")
class TestSearchApi(ModuleStoreTestCase):
    """
    Tests for the Studio content search and index API.
    """

    MODULESTORE = TEST_DATA_SPLIT_MODULESTORE

    def setUp(self):
        super().setUp()
        self.user = UserFactory.create()
        self.user_id = self.user.id

        self.modulestore_patcher = patch(
            "openedx.core.djangoapps.content.search.api.modulestore", return_value=self.store
        )
        self.addCleanup(self.modulestore_patcher.stop)
        self.modulestore_patcher.start()

        # Clear the Meilisearch client to avoid side effects from other tests
        api.clear_meilisearch_client()

        # Create course
        self.course = self.store.create_course(
            "org1",
            "test_course",
            "test_run",
            self.user_id,
            fields={"display_name": "Test Course"},
        )
        course_access, _ = SearchAccess.objects.get_or_create(context_key=self.course.id)
        self.course_block_key = "block-v1:org1+test_course+test_run+type@course+block@course"

        # Create XBlocks
        self.sequential = self.store.create_child(self.user_id, self.course.location, "sequential", "test_sequential")
        self.doc_sequential = {
            "id": "block-v1org1test_coursetest_runtypesequentialblocktest_sequential-f702c144",
            "type": "course_block",
            "usage_key": "block-v1:org1+test_course+test_run+type@sequential+block@test_sequential",
            "block_id": "test_sequential",
            "display_name": "sequential",
            "block_type": "sequential",
            "context_key": "course-v1:org1+test_course+test_run",
            "org": "org1",
            "breadcrumbs": [
                {
                    "display_name": "Test Course",
                },
            ],
            "content": {},
            "access_id": course_access.id,
        }
        self.store.create_child(self.user_id, self.sequential.location, "vertical", "test_vertical")
        self.doc_vertical = {
            "id": "block-v1org1test_coursetest_runtypeverticalblocktest_vertical-e76a10a4",
            "type": "course_block",
            "usage_key": "block-v1:org1+test_course+test_run+type@vertical+block@test_vertical",
            "block_id": "test_vertical",
            "display_name": "vertical",
            "block_type": "vertical",
            "context_key": "course-v1:org1+test_course+test_run",
            "org": "org1",
            "breadcrumbs": [
                {
                    "display_name": "Test Course",
                },
                {
                    "display_name": "sequential",
                    "usage_key": "block-v1:org1+test_course+test_run+type@sequential+block@test_sequential",
                },
            ],
            "content": {},
            "access_id": course_access.id,
        }
        # Make sure the CourseOverview for the course is created:
        CourseOverview.get_from_id(self.course.id)

        # Create a content library:
        self.library = library_api.create_library(
            library_type=library_api.COMPLEX,
            org=OrganizationFactory.create(short_name="org1"),
            slug="lib",
            title="Library",
        )
        lib_access, _ = SearchAccess.objects.get_or_create(context_key=self.library.key)

        # Populate it with 2 problems, freezing the date so we can verify created date serializes correctly.
        created_date = datetime(2023, 4, 5, 6, 7, 8, tzinfo=timezone.utc)
        with freeze_time(created_date):
            self.problem1 = library_api.create_library_block(self.library.key, "problem", "p1")
            self.problem2 = library_api.create_library_block(self.library.key, "problem", "p2")
        # Update problem1, freezing the date so we can verify modified date serializes correctly.
        modified_date = datetime(2024, 5, 6, 7, 8, 9, tzinfo=timezone.utc)
        with freeze_time(modified_date):
            library_api.set_library_block_olx(self.problem1.usage_key, "<problem />")

        self.doc_problem1 = {
            "id": "lborg1libproblemp1-a698218e",
            "usage_key": "lb:org1:lib:problem:p1",
            "block_id": "p1",
            "display_name": "Blank Problem",
            "block_type": "problem",
            "context_key": "lib:org1:lib",
            "org": "org1",
            "breadcrumbs": [{"display_name": "Library"}],
            "content": {"problem_types": [], "capa_content": " "},
            "type": "library_block",
            "access_id": lib_access.id,
            "last_published": None,
            "created": created_date.timestamp(),
            "modified": modified_date.timestamp(),
        }
        self.doc_problem2 = {
            "id": "lborg1libproblemp2-b2f65e29",
            "usage_key": "lb:org1:lib:problem:p2",
            "block_id": "p2",
            "display_name": "Blank Problem",
            "block_type": "problem",
            "context_key": "lib:org1:lib",
            "org": "org1",
            "breadcrumbs": [{"display_name": "Library"}],
            "content": {"problem_types": [], "capa_content": " "},
            "type": "library_block",
            "access_id": lib_access.id,
            "last_published": None,
            "created": created_date.timestamp(),
            "modified": created_date.timestamp(),
        }

        # Create a couple of taxonomies with tags
        self.taxonomyA = tagging_api.create_taxonomy(name="A", export_id="A")
        self.taxonomyB = tagging_api.create_taxonomy(name="B", export_id="B")
        tagging_api.set_taxonomy_orgs(self.taxonomyA, all_orgs=True)
        tagging_api.set_taxonomy_orgs(self.taxonomyB, all_orgs=True)
        tagging_api.add_tag_to_taxonomy(self.taxonomyA, "one")
        tagging_api.add_tag_to_taxonomy(self.taxonomyA, "two")
        tagging_api.add_tag_to_taxonomy(self.taxonomyB, "three")
        tagging_api.add_tag_to_taxonomy(self.taxonomyB, "four")

    @override_settings(MEILISEARCH_ENABLED=False)
    def test_reindex_meilisearch_disabled(self, mock_meilisearch):
        with self.assertRaises(RuntimeError):
            api.rebuild_index()

        mock_meilisearch.return_value.swap_indexes.assert_not_called()

    @override_settings(MEILISEARCH_ENABLED=True)
    def test_reindex_meilisearch(self, mock_meilisearch):

        # Add tags field to doc, since reindex calls includes tags
        doc_sequential = copy.deepcopy(self.doc_sequential)
        doc_sequential["tags"] = {}
        doc_vertical = copy.deepcopy(self.doc_vertical)
        doc_vertical["tags"] = {}
        doc_problem1 = copy.deepcopy(self.doc_problem1)
        doc_problem1["tags"] = {}
        doc_problem2 = copy.deepcopy(self.doc_problem2)
        doc_problem2["tags"] = {}

        api.rebuild_index()
        mock_meilisearch.return_value.index.return_value.add_documents.assert_has_calls(
            [
                call([doc_sequential, doc_vertical]),
                call([doc_problem1, doc_problem2]),
            ],
            any_order=True,
        )

    @override_settings(MEILISEARCH_ENABLED=True)
    def test_reindex_meilisearch_library_block_error(self, mock_meilisearch):

        # Add tags field to doc, since reindex calls includes tags
        doc_sequential = copy.deepcopy(self.doc_sequential)
        doc_sequential["tags"] = {}
        doc_vertical = copy.deepcopy(self.doc_vertical)
        doc_vertical["tags"] = {}
        doc_problem2 = copy.deepcopy(self.doc_problem2)
        doc_problem2["tags"] = {}

        orig_from_component = library_api.LibraryXBlockMetadata.from_component

        def mocked_from_component(lib_key, component):
            # Simulate an error when processing problem 1
            if component.key == 'xblock.v1:problem:p1':
                raise Exception('Error')

            return orig_from_component(lib_key, component)

        with patch.object(
            library_api.LibraryXBlockMetadata,
            "from_component",
            new=mocked_from_component,
        ):
            api.rebuild_index()

        mock_meilisearch.return_value.index.return_value.add_documents.assert_has_calls(
            [
                call([doc_sequential, doc_vertical]),
                # Problem 1 should not be indexed
                call([doc_problem2]),
            ],
            any_order=True,
        )

        # Check that the sorting-related settings were updated to support sorting on the expected fields
        mock_meilisearch.return_value.index.return_value.update_sortable_attributes.assert_called_with([
            "display_name",
            "created",
            "modified",
            "last_published",
        ])
        mock_meilisearch.return_value.index.return_value.update_ranking_rules.assert_called_with([
            "sort",
            "words",
            "typo",
            "proximity",
            "attribute",
            "exactness",
        ])

    @ddt.data(
        True,
        False
    )
    @override_settings(MEILISEARCH_ENABLED=True)
    def test_index_xblock_metadata(self, recursive, mock_meilisearch):
        """
        Test indexing an XBlock.
        """
        api.upsert_xblock_index_doc(self.sequential.usage_key, recursive=recursive)

        if recursive:
            expected_docs = [self.doc_sequential, self.doc_vertical]
        else:
            expected_docs = [self.doc_sequential]

        mock_meilisearch.return_value.index.return_value.update_documents.assert_called_once_with(expected_docs)

    @override_settings(MEILISEARCH_ENABLED=True)
    def test_no_index_excluded_xblocks(self, mock_meilisearch):
        api.upsert_xblock_index_doc(UsageKey.from_string(self.course_block_key))

        mock_meilisearch.return_value.index.return_value.update_document.assert_not_called()

    @override_settings(MEILISEARCH_ENABLED=True)
    def test_index_xblock_tags(self, mock_meilisearch):
        """
        Test indexing an XBlock with tags.
        """

        # Tag XBlock (these internally call `upsert_block_tags_index_docs`)
        tagging_api.tag_object(str(self.sequential.usage_key), self.taxonomyA, ["one", "two"])
        tagging_api.tag_object(str(self.sequential.usage_key), self.taxonomyB, ["three", "four"])

        # Build expected docs with tags at each stage
        doc_sequential_with_tags1 = {
            "id": self.doc_sequential["id"],
            "tags": {
                'taxonomy': ['A'],
                'level0': ['A > one', 'A > two']
            }
        }
        doc_sequential_with_tags2 = {
            "id": self.doc_sequential["id"],
            "tags": {
                'taxonomy': ['A', 'B'],
                'level0': ['A > one', 'A > two', 'B > four', 'B > three']
            }
        }

        mock_meilisearch.return_value.index.return_value.update_documents.assert_has_calls(
            [
                call([doc_sequential_with_tags1]),
                call([doc_sequential_with_tags2]),
            ],
            any_order=True,
        )

    @override_settings(MEILISEARCH_ENABLED=True)
    def test_delete_index_xblock(self, mock_meilisearch):
        """
        Test deleting an XBlock doc from the index.
        """
        api.delete_index_doc(self.sequential.usage_key)

        mock_meilisearch.return_value.index.return_value.delete_document.assert_called_once_with(
            self.doc_sequential['id']
        )

    @override_settings(MEILISEARCH_ENABLED=True)
    def test_index_library_block_metadata(self, mock_meilisearch):
        """
        Test indexing a Library Block.
        """
        api.upsert_library_block_index_doc(self.problem1.usage_key)

        mock_meilisearch.return_value.index.return_value.update_documents.assert_called_once_with([self.doc_problem1])

    @override_settings(MEILISEARCH_ENABLED=True)
    def test_index_library_block_tags(self, mock_meilisearch):
        """
        Test indexing an Library Block with tags.
        """

        # Tag XBlock (these internally call `upsert_block_tags_index_docs`)
        tagging_api.tag_object(str(self.problem1.usage_key), self.taxonomyA, ["one", "two"])
        tagging_api.tag_object(str(self.problem1.usage_key), self.taxonomyB, ["three", "four"])

        # Build expected docs with tags at each stage
        doc_problem_with_tags1 = {
            "id": self.doc_problem1["id"],
            "tags": {
                'taxonomy': ['A'],
                'level0': ['A > one', 'A > two']
            }
        }
        doc_problem_with_tags2 = {
            "id": self.doc_problem1["id"],
            "tags": {
                'taxonomy': ['A', 'B'],
                'level0': ['A > one', 'A > two', 'B > four', 'B > three']
            }
        }

        mock_meilisearch.return_value.index.return_value.update_documents.assert_has_calls(
            [
                call([doc_problem_with_tags1]),
                call([doc_problem_with_tags2]),
            ],
            any_order=True,
        )

    @override_settings(MEILISEARCH_ENABLED=True)
    def test_delete_index_library_block(self, mock_meilisearch):
        """
        Test deleting a Library Block doc from the index.
        """
        api.delete_index_doc(self.problem1.usage_key)

        mock_meilisearch.return_value.index.return_value.delete_document.assert_called_once_with(
            self.doc_problem1['id']
        )

    @override_settings(MEILISEARCH_ENABLED=True)
    def test_index_content_library_metadata(self, mock_meilisearch):
        """
        Test indexing a whole content library.
        """
        api.upsert_content_library_index_docs(self.library.key)

        mock_meilisearch.return_value.index.return_value.update_documents.assert_called_once_with(
            [self.doc_problem1, self.doc_problem2]
        )

    @override_settings(MEILISEARCH_ENABLED=True)
    def test_delete_all_drafts(self, mock_meilisearch):
        """
        Test deleting all draft documents from the index.
        """
        api.delete_all_draft_docs_for_library(self.library.key)

        delete_filter = [
            f'context_key="{self.library.key}"',
            ['last_published IS EMPTY', 'last_published IS NULL'],
        ]
        mock_meilisearch.return_value.index.return_value.delete_documents.assert_called_once_with(
            filter=delete_filter
        )
