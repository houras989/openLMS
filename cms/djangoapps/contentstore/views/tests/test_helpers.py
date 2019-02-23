"""
Unit tests for helpers.py.
"""

from django.utils import http

from contentstore.tests.utils import CourseTestCase
from contentstore.views.helpers import xblock_studio_url, xblock_type_display_name
from xmodule.modulestore.tests.factories import ItemFactory, LibraryFactory


class HelpersTestCase(CourseTestCase):
    """
    Unit tests for helpers.py.
    """

    def test_xblock_studio_url(self):

        # Verify course URL
        course_url = '/course/{}'.format(str(self.course.id))
        self.assertEqual(xblock_studio_url(self.course), course_url)

        # Verify chapter URL
        chapter = ItemFactory.create(parent_location=self.course.location, category='chapter',
                                     display_name="Week 1")
        self.assertEqual(
            xblock_studio_url(chapter),
            '{}?show={}'.format(course_url, http.urlquote(chapter.location))
        )

        # Verify sequential URL
        sequential = ItemFactory.create(parent_location=chapter.location, category='sequential',
                                        display_name="Lesson 1")
        self.assertEqual(
            xblock_studio_url(sequential),
            '{}?show={}'.format(course_url, http.urlquote(sequential.location))
        )

        # Verify unit URL
        vertical = ItemFactory.create(parent_location=sequential.location, category='vertical',
                                      display_name='Unit')
        self.assertEqual(xblock_studio_url(vertical), '/container/{}'.format(vertical.location))

        # Verify child vertical URL
        child_vertical = ItemFactory.create(parent_location=vertical.location, category='vertical',
                                            display_name='Child Vertical')
        self.assertEqual(xblock_studio_url(child_vertical), '/container/{}'.format(child_vertical.location))

        # Verify video URL
        video = ItemFactory.create(parent_location=child_vertical.location, category="video",
                                   display_name="My Video")
        self.assertIsNone(xblock_studio_url(video))

        # Verify library URL
        library = LibraryFactory.create()
        expected_url = '/library/{}'.format(str(library.location.library_key))
        self.assertEqual(xblock_studio_url(library), expected_url)

    def test_xblock_type_display_name(self):

        # Verify chapter type display name
        chapter = ItemFactory.create(parent_location=self.course.location, category='chapter')
        self.assertEqual(xblock_type_display_name(chapter), 'Section')
        self.assertEqual(xblock_type_display_name('chapter'), 'Section')

        # Verify sequential type display name
        sequential = ItemFactory.create(parent_location=chapter.location, category='sequential')
        self.assertEqual(xblock_type_display_name(sequential), 'Subsection')
        self.assertEqual(xblock_type_display_name('sequential'), 'Subsection')

        # Verify unit type display names
        vertical = ItemFactory.create(parent_location=sequential.location, category='vertical')
        self.assertEqual(xblock_type_display_name(vertical), 'Unit')
        self.assertEqual(xblock_type_display_name('vertical'), 'Unit')

        # Verify child vertical type display name
        child_vertical = ItemFactory.create(parent_location=vertical.location, category='vertical',
                                            display_name='Child Vertical')
        self.assertEqual(xblock_type_display_name(child_vertical), 'Vertical')

        # Verify video type display names
        video = ItemFactory.create(parent_location=vertical.location, category="video")
        self.assertEqual(xblock_type_display_name(video), 'Video')
        self.assertEqual(xblock_type_display_name('video'), 'Video')

        # Verify split test type display names
        split_test = ItemFactory.create(parent_location=vertical.location, category="split_test")
        self.assertEqual(xblock_type_display_name(split_test), 'Content Experiment')
        self.assertEqual(xblock_type_display_name('split_test'), 'Content Experiment')
