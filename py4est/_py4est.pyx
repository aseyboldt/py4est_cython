cimport mpi4py.MPI as MPI
cimport mpi4py.mpi_c as mpi_c
from mpi4py import MPI

from _c_p4est_base cimport p4est_init, p4est_topidx_t
from _c_p4est cimport (p4est_t, p4est_quadrant_t, p4est_init_t,
                       p4est_destroy, p4est_tree_t, p4est_tree_array_index,
                       p4est_quadrant_array_index)
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
    from within pure python. Do not store Quadrant-objects yourself
    as they are only valid during an iteration. (The underlying c struct
    will change!)
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

cdef QuadrantFactory(p4est_quadrant_t *quadrant):
    cdef Quadrant quad = Quadrant.__new__(Quadrant)
    quad._change_quadrant(quadrant)
    return quad


cdef class Ghost:
    cdef p4est_ghost_t *_ghost

    def __init__(self, Forest forest not None):
        self._ghost = p4est_ghost_new(forest._p4est, P4EST_CONNECT_FULL)

    def __dealloc__(self):
        if self._ghost is not NULL:
            p4est_ghost_destroy(self._ghost)  # TODO


cdef class Mesh:
    cdef p4est_mesh_t *_mesh

    def __init__(self, Forest forest not None, Ghost ghost not None):
        self._mesh = p4est_mesh_new(forest._p4est, ghost._ghost,
                                    P4EST_CONNECT_FULL)

    def __dealloc__(self):
        if self._mesh is not NULL:
            p4est_mesh_destroy(self._mesh)  # TODO


# wrap python function inside C
cdef void _wrap_init_callback(p4est_t *p4est,
                                   p4est_topidx_t which_tree,
                                   p4est_quadrant_t *quadrant) with gil:
    cdef Forest forest_py = <Forest> p4est.user_pointer
    forest_py._quadrant_template._change_quadrant(quadrant)
    forest_py._init_callback_python(forest_py._quadrant_template)


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


cdef class Forest:
    """ Create the local part of the specified forest

    Use the same specifications on all processors. If you don't, this
    might crash the program (right? TODO)

    Parameters
    ----------
    connectivity : Connectivity
       Object describing how the trees are connected
    init_callback : callable or InitCallbackContainer
       This functon is called with each new quadrant as parameter
    mpicomm : MPI.Com
       The MPI Communicator to be used by p4est
    min_level : int
       The forest is refined at least to this level
    min_quadrants : int
       Minimum initial quadrants per processor
    fill_uniform : bool
       If true, fill the forest with a uniform mesh. If false, fill
       it with the coarsest possible one. 
    """
    cdef p4est_t *_p4est
    cdef Connectivity _con
    cdef Ghost _ghost
    cdef Mesh _mesh

    # used for python callbacks in py4est
    cdef object _init_callback_python
    cdef Quadrant _quadrant_template

    cdef MPI.Comm _mpicomm

    def __init__(self, Connectivity connectivity not None, 
                 init_callback=lambda x: None,
                 MPI.Comm mpicomm not None=MPI.COMM_WORLD,
                 min_level=0,
                 fill_uniform=1,
                 data_size=0):
        if min_level >= 30:
            raise ValueError("initial_level too big (max is 30)")
        self._con = connectivity
        
        # handle init_callback 
        cdef p4est_init_t callback_c
        cdef InitCallbackContainer callback_cont

        if isinstance(init_callback, InitCallbackContainer):
            callback_cont =  <InitCallbackContainer> init_callback
            callback_c = <p4est_init_t> callback_cont.callback_c
        elif callable(init_callback):
            self._init_callback_python = init_callback
            callback_c = <p4est_init_t> _wrap_init_callback
        else:
            raise TypeError('user_data_init_callback neither callabel ' + 
                            'nor of type InitCallbackContainer')

        self._con = connectivity
        self._quadrant_template = Quadrant.__new__(Quadrant)
        self._p4est = p4est_new_ext(mpicomm.ob_mpi,
                                    self._con._con, 0, 
                                    min_level, fill_uniform,
                                    data_size, callback_c,
                                    <void *> self)
        # TODO: error checking?


        self._ghost = Ghost(self)
        self._mesh = Mesh(self, self._ghost)
        self._mpicomm = mpicomm

    def __dealloc__(self):
        if self._p4est is not NULL:
            p4est_destroy(self._p4est)

    def leafs(self, reuse_object=False):
        """ Return iterator for all leafs owned by this process

        Parameters
        ----------
        reuse_object : bool, optional
           Use the same python object for all leafs. Change only
           the underlying c-struct

        Returns
        -------
        leaf : Quadrant
        """
        cdef p4est_t *p4est = self._p4est
        
        cdef p4est_topidx_t which_tree
        cdef p4est_topidx_t which_quad
        cdef p4est_tree_t *tree

        cdef Quadrant leaf

        if p4est.local_num_quadrants == 0:
            raise StopIteration

        which_tree = p4est.first_local_tree
        tree = p4est_tree_array_index(p4est.trees, which_tree)
        which_quad = 0  # why 0 ????? #TODO
        
        leaf = QuadrantFactory(p4est_quadrant_array_index(&tree.quadrants,
                                                          which_quad))

        while True:
            yield leaf
            
            if <size_t> which_quad + 1 == tree.quadrants.elem_count:
                which_tree += 1
                if which_tree  > p4est.last_local_tree:
                    raise StopIteration
                
                tree = p4est_tree_array_index(p4est.trees, which_tree)
                which_quad = 0;
            else:
                which_quad += 1

            if reuse_object:
                leaf._change_quadrant(
                        p4est_quadrant_array_index(&tree.quadrants, which_quad))
            else:
                leaf = QuadrantFactory(
                        p4est_quadrant_array_index(&tree.quadrants, which_quad))

