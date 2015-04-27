"""
Helper HTML related utility functions
"""

from HTMLParser import HTMLParser


class MLStripper(HTMLParser):
    """
    Overrides HTMLParser which returns a string with the HTML
    stripped out
    """

    def __init__(self):
        """
            Initializer
            """
        HTMLParser.__init__(self)
        self.reset()
        self.fed = []

    def handle_data(self, d):
        """
        Override of HTMLParser
        """
        self.fed.append(d)

    def get_data(self):
        """
        Returns the stripped out string
        """
        return ''.join(self.fed)


def strip_tags(html):
    """
    Calls into the MLStripper to return a string with HTML stripped out
    """
    stripper = MLStripper()
    stripper.feed(html)
    return stripper.get_data()
