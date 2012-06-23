"""
All tests in this file assume, that only one process is used
"""

from nose.tools import *
from py4est import *


def test_create_forrest():
    con = Connectivity(kind='unitsquare')

    counter = [0]

    def data_init(quadrant):
        counter[0] += 1

    for i in range(6):
        counter[0] = 0
        forest = Forest(con, data_init, min_level=i)
        eq_(counter[0], 4**i)
        eq_(len(list(forest.leafs())), 4**i)


@raises(ValueError)
def test_create_forrest_big():
    con = Connectivity(kind='unitsquare')
    forest = Forest(con, lambda x: None, min_level=30)


def test_quadrant():
    con = Connectivity(kind='moebius')
    forest = Forest(con, lambda x: None, min_level=4)
    eq_(next(forest.leafs()).x, 0)
    eq_(next(forest.leafs()).y, 0)
    eq_(next(forest.leafs(reuse_object=True)).level, 4)

