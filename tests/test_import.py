"""
Tests in this file assume, that only one process is used
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
        eq_(len(list(forest.local_quadrants())), 4**i)
        eq_(forest.num_local_quadrants, 4**i)
        eq_(forest.num_global_quadrants, 4**i)


@raises(ValueError)
def test_create_forrest_big():
    con = Connectivity(kind='unitsquare')
    forest = Forest(con, lambda x: None, min_level=30)


def test_quadrant():
    con = Connectivity(kind='moebius')
    forest = Forest(con, lambda x: None, min_level=4)
    eq_(next(forest.local_quadrants()).x, 0)
    eq_(next(forest.local_quadrants()).y, 0)
    eq_(next(forest.local_quadrants(reuse_object=True)).level, 4)


def test_refine():
    con = Connectivity(kind='unitsquare')

    forest = Forest(con, min_level=2)
    eq_(forest.num_global_quadrants, 16)

    def refine_callback(quad):
        return quad.x == 0

    forest.refine(refine_callback)
    eq_(forest.num_global_quadrants, 28)


def test_balance():
    con = Connectivity(kind='unitsquare')
    forest = Forest(con, min_level=1)
    eq_(forest.num_global_quadrants, 4)

    forest.refine(lambda quad: quad.x == 0)
    forest.refine(lambda quad: quad.level == 2)

    eq_(forest.num_global_quadrants, 2 + 4 * 8)
    forest.balance()
    eq_(forest.num_global_quadrants, 40)

