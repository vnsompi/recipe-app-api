"""
simple test
"""

from django.test import SimpleTestCase
from app.app import calc


class CalcTests(SimpleTestCase):
    """test the calc module """

    def test_add_numbers(self):
        """test adding numbers together"""
        res = calc.add(1, 2)
        self.assertEqual(res, 3)