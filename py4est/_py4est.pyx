cimport mpi4py.MPI as MPI
cimport mpi4py.mpi_c as mpi_c
from mpi4py import MPI

from _c_p4est_base cimport p4est_init, p4est_topidx_t
from _c_p4est cimport (p4est_t, p4est_quadrant_t, p4est_init_t,
                       p4est_destroy, p4est_tree_t, p4est_tree_array_index)
from _c_p4est_connectivity cimport (p4est_connectivity_t,
                                    p4est_connectivity_new_unitsquare,
                                    p4est_connectivity_new_periodic,
                                    p4est_connectivity_new_moebius,
                                    p4est_connectivity_destroy,
                                    P4EST_CONNECT_FULL)
from _c_p4est_ghost cimport p4est_ghost_t, p4est_ghost_new, p4est_ghost_destroy
from _c_p4est_mesh cimport p4est_mesh_t, p4est_mesh_new, p4est_mesh_destroy
from _c_p4est_extended cimport p4est_new_ext
from _c_sc cimport sc_init, sc_finalize, sc_set_log_defaults, sc_log_handler_t

cdef extern from "Python.h":
    int Py_AtExit(void (*)())


import sys
import logging


# initialize sc and p4est and pass a customized log
# handler, that wraps the python logging module

cdef _log_handler(void * log_stream,
                  char *filename, int lineno,
                  int package, int category,
                  int priority, char *msg) with gil:
    message = "package {} file {} line {}: {}".format(
                   package, filename, lineno, msg)
    if priority <= 2:
        logging.debug(message)
    elif priority <= 5:
        logging.info(message)
    elif priority == 6:
        logging.warning(message)
    elif priority == 7:
        logging.error(message)
    elif priority == 8:
        logging.critical(message)

def _init_sc_and_p4est():
    comm = MPI.COMM_WORLD
    rank = comm.rank
    size = comm.size
    cdef mpi_c.MPI_Comm comm_c = (<MPI.Comm> comm).ob_mpi

    sc_init(comm_c, 0, 1, <sc_log_handler_t> _log_handler, 0)
    p4est_init(<sc_log_handler_t> _log_handler, 0)

# clean up, when python exits
cdef void module_cleanup():
    sc_finalize()

cdef int _failed = Py_AtExit(module_cleanup)
if _failed:
    raise(ImportError("unable to register cleanup code"))

_init_sc_and_p4est()





cdef class Connectivity(object):
    """ This class describes inter-tree connectivity 
    
    wraps py4est_connectivity
    """

    cdef p4est_connectivity_t *_con
    
    def __cinit__(self, kind='unitsquare'):
        if kind == 'unitsquare':
            self._con = p4est_connectivity_new_unitsquare()
        elif kind == 'periodic':
            self._con = p4est_connectivity_new_periodic()
        elif kind == 'moebius':
            self._con = p4est_connectivity_new_moebius()
        else:
            raise ValueError("kind {} not understood".format(kind))

    def __dealloc__(self):
        if self._con is not NULL:
            p4est_connectivity_destroy(self._con)


cdef class Quadrant:
    """
    Wrap a p4est_qudrant and provide methods to access the members.

    It does not own the underlying c-object and can not be instantiated
    from within pure python. Do not store Quadrant-objects yourself as they
    are only valid during an iteration. (The underlying c struct will change!)
    """
    cdef p4est_quadrant_t *_quadrant

    property x:
        def __get__(self):
            return self._quadrant.x

    property y:
        def __get__(self):
            return self._quadrant.y
    
    property level:
        def __get__(self):
            return self._quadrant.level

    property pad8:
        def __get__(self):
            return self._quadrant.pad8

    property pad16:
        def __get__(self):
            return self._quadrant.pad16

    property data:  # TODO (union?)
        def __get__(self):
            raise NotImplementedError()


    def __init__(self):
        raise ValueError("Quadrant can not be instantiated")

    cdef _change_quadrant(self, p4est_quadrant_t *quadrant):
        self._quadrant = quadrant

    def __str__(self):
        return "Quadrant(x={}, y={}, level={}, pad8={}, pad16={})".format(
                self.x, self.y, self.level, self.pad8, self.pad16)




cdef class InitCallbackContainer:
    """ A simple wrapper around a p4est_init_t function

    Useage from cython::

        cdef void my_callback(p4est_t *p4est,
                              p4est_topidx_t which_tree,
                              p4est_quadrant_t *quadrant) with gil:
            print "hallo"

        cdef InitCallbackContainer container = InitCallbackContainer()
        container.callback_c = <p4est_init_t> my_callback

        fast_callable = container

        # pass fast_callable to Forest or ...
    
    """
    cdef p4est_init_t callback_c



cdef void _wrap_init_callback(p4est_t *p4est,
                                   p4est_topidx_t which_tree,
                                   p4est_quadrant_t *quadrant) with gil:
    cdef P4est p4est_py = <P4est> p4est.user_pointer
    p4est_py._quadrant_template._change_quadrant(quadrant)
    p4est_py._init_callback_python(p4est_py._quadrant_template)  #TODO



cdef class P4est(object):
    cdef p4est_t *_p4est
    cdef Connectivity _con
    cdef object _init_callback_python
    cdef Quadrant _quadrant_template

    def __init__(self, MPI.Comm mpicomm not None,
                 Connectivity connectivity not None,
                 user_data_init_callback=None,
                 initial_level=0,
                 fill_uniform=1,
                 data_size=0):

        cdef p4est_init_t callback_c
        cdef InitCallbackContainer callback_cont

        if isinstance(user_data_init_callback, InitCallbackContainer):
            callback_cont =  <InitCallbackContainer> user_data_init_callback
            callback_c = <p4est_init_t> callback_cont.callback_c
        elif callable(user_data_init_callback):
            self._init_callback_python = user_data_init_callback
            callback_c = <p4est_init_t> _wrap_init_callback
        else:
            raise TypeError('user_data_init_callback neither callabel ' + 
                            'nor of type InitCallbackContainer')

        self._con = connectivity
        self._quadrant_template = Quadrant.__new__(Quadrant)
        self._p4est = p4est_new_ext(mpicomm.ob_mpi,
                                    self._con._con, 0, 
                                    initial_level, fill_uniform,
                                    data_size, callback_c,
                                    <void *> self)
        # TODO: error checking?

    def __dealloc__(self):
        if self._p4est is not NULL:
            p4est_destroy(self._p4est)
        self._p4est = NULL
        self._con = None 


cdef class Ghost:
    cdef p4est_ghost_t *_ghost
    cdef P4est _p4est

    def __init__(self, P4est p4est not None):
        self._ghost = p4est_ghost_new(p4est._p4est, P4EST_CONNECT_FULL)
        self._p4est = p4est

    def __dealloc__(self):
        if self._ghost is not NULL:
            p4est_ghost_destroy(self._ghost)

cdef class Mesh:
    cdef p4est_mesh_t *_mesh
    cdef Ghost _ghost
    cdef P4est _p4est

    def __init__(self, P4est p4est not None, Ghost ghost not None):
        self._mesh = p4est_mesh_new(p4est._p4est, ghost._ghost,
                                    P4EST_CONNECT_FULL)
        self._p4est = p4est
        self._ghost = ghost

    def __dealloc__(self):
        if self._mesh is not NULL:
            p4est_mesh_destroy(self._mesh)


cdef class Leaf:
    cdef p4est_topidx_t _which_tree
    cdef p4est_topidx_t _which_quad
    cdef p4est_tree_t *_tree

    cdef Forest _forest

    def __init__(self, Forest forest not None):
        self._forest = forest

    def __str__(self):
        return "Leaf(which_tree={}, which_quad={})".format(
                  self._which_tree, self._which_quad)


cdef class Forest:
    cdef P4est _p4est
    cdef Connectivity _con
    cdef Ghost _ghost
    cdef Mesh _mesh

    cdef MPI.Comm _mpicomm

    def __init__(self, Connectivity connectivity not None, init_callback,
                 MPI.Comm mpicomm not None=MPI.COMM_WORLD,
                 initial_level=0):  # TODO arguments?
        if initial_level >= 30:
            raise ValueError("initial_level too big (max is 30)")
        self._con = connectivity
        self._p4est = P4est(mpicomm, self._con, user_data_init_callback=init_callback,
                            initial_level=initial_level)
        self._ghost = Ghost(self._p4est)
        self._mesh = Mesh(self._p4est, self._ghost)
        self._mpicomm = mpicomm

    def leafs(self):
        cdef p4est_t *p4est = self._p4est._p4est
        
        if p4est.local_num_quadrants == 0:
            raise StopIteration

        cdef Leaf leaf = Leaf(self)
        leaf._which_tree = p4est.first_local_tree
        leaf._tree = p4est_tree_array_index(p4est.trees, leaf._which_tree)
        leaf._which_quad = 0

        while True:
            yield leaf
            
            if <size_t> leaf._which_quad + 1 == leaf._tree.quadrants.elem_count:
                leaf._which_tree += 1
                if leaf._which_tree  > p4est.last_local_tree:
                    raise StopIteration
                
                leaf._tree = p4est_tree_array_index(p4est.trees, leaf._which_tree)
                leaf._which_quad = 0;
            else:
                leaf._which_quad += 1

        cdef int a = 0

