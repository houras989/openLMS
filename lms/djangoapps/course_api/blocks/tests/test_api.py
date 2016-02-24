"""
Tests for Blocks api.py
"""

from django.test.client import RequestFactory

from course_blocks.tests.helpers import EnableTransformerRegistryMixin
from student.tests.factories import UserFactory
from xmodule.modulestore import ModuleStoreEnum
from xmodule.modulestore.tests.django_utils import SharedModuleStoreTestCase
from xmodule.modulestore.tests.factories import SampleCourseFactory

from ..api import get_blocks


class TestGetBlocks(EnableTransformerRegistryMixin, SharedModuleStoreTestCase):
    """
    Tests for the get_blocks function
    """
    @classmethod
    def setUpClass(cls):
        super(TestGetBlocks, cls).setUpClass()
        cls.course = SampleCourseFactory.create()

        # hide the html block
        cls.html_block = cls.store.get_item(cls.course.id.make_usage_key('html', 'html_x1a_1'))
        cls.html_block.visible_to_staff_only = True
        cls.store.update_item(cls.html_block, ModuleStoreEnum.UserID.test)

    def setUp(self):
        super(TestGetBlocks, self).setUp()
        self.user = UserFactory.create()
        self.request = RequestFactory().get("/dummy")
        self.request.user = self.user

    def test_basic(self):
        blocks = get_blocks(self.request, self.course.location, self.user)
        self.assertEquals(blocks['root'], unicode(self.course.location))

        # subtract for (1) the orphaned course About block and (2) the hidden Html block
        self.assertEquals(len(blocks['blocks']), len(self.store.get_items(self.course.id)) - 2)
        self.assertNotIn(unicode(self.html_block.location), blocks['blocks'])

    def test_no_user(self):
        blocks = get_blocks(self.request, self.course.location)
        self.assertIn(unicode(self.html_block.location), blocks['blocks'])

    def test_access_before_api_transformer_order(self):
        """
        Tests the order of transformers: access checks are made before the api
        transformer is applied.
        """
        blocks = get_blocks(self.request, self.course.location, self.user, nav_depth=5, requested_fields=['nav_depth'])
        vertical_block = self.store.get_item(self.course.id.make_usage_key('vertical', 'vertical_x1a'))
        problem_block = self.store.get_item(self.course.id.make_usage_key('problem', 'problem_x1a_1'))

        vertical_descendants = blocks['blocks'][unicode(vertical_block.location)]['descendants']

        self.assertIn(unicode(problem_block.location), vertical_descendants)
        self.assertNotIn(unicode(self.html_block.location), vertical_descendants)

    def test_sub_structure(self):
        sequential_block = self.store.get_item(self.course.id.make_usage_key('sequential', 'sequential_y1'))

        blocks = get_blocks(self.request, sequential_block.location, self.user)
        self.assertEquals(blocks['root'], unicode(sequential_block.location))
        self.assertEquals(len(blocks['blocks']), 5)

        for block_type, block_name, is_inside_of_structure in (
                ('vertical', 'vertical_y1a', True),
                ('problem', 'problem_y1a_1', True),
                ('chapter', 'chapter_y', False),
                ('sequential', 'sequential_x1', False),
        ):
            block = self.store.get_item(self.course.id.make_usage_key(block_type, block_name))
            if is_inside_of_structure:
                self.assertIn(unicode(block.location), blocks['blocks'])
            else:
                self.assertNotIn(unicode(block.location), blocks['blocks'])

    def test_visible_to_staff_only(self):
        """
        Assert that visible_to_staff_only works as a requested_field
        """
        # Update user factory to have staff access
        self.user = UserFactory.create(is_staff=True)
        self.request = RequestFactory().get("/dummy")
        self.request.user = self.user

        # self.course.visible_to_staff_only is False
        blocks = get_blocks(self.request, self.course.location, self.user, requested_fields=['visible_to_staff_only'])
        block = blocks['blocks'][blocks['root']]
        self.assertFalse(block['visible_to_staff_only'])

        # self.html_block.visible_to_staff_only was set to True in setUpClass
        blocks = get_blocks(self.request, self.html_block.location, self.user, requested_fields=['visible_to_staff_only'])
        block = blocks['blocks'][blocks['root']]
        self.assertTrue(block['visible_to_staff_only'])

        # Not there by default
        blocks = get_blocks(self.request, self.html_block.location, self.user)
        block = blocks['blocks'][blocks['root']]
        self.assertNotIn('visible_to_staff_only', block)
