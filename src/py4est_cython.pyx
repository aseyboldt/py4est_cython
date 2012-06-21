cimport mpi4py.MPI as MPI
cimport mpi4py.mpi_c as mpi_c
from mpi4py import MPI

# log level for p4est and sc
_LP = 0

from _c_p4est_base cimport p4est_init, p4est_topidx_t
from _c_p4est cimport p4est_t, p4est_quadrant_t, p4est_init_t, p4est_destroy
from _c_p4est_connectivity cimport (p4est_connectivity_t,
                                    p4est_connectivity_new_unitsquare,
                                    p4est_connectivity_destroy)
from _c_p4est_extended cimport p4est_new_ext
from _c_sc cimport sc_init, sc_finalize


cdef extern from "Python.h":
    int Py_AtExit(void (*)())


comm = MPI.COMM_WORLD
rank = comm.rank
size = comm.size
cdef mpi_c.MPI_Comm comm_c = (<MPI.Comm> comm).ob_mpi


cdef void module_cleanup():
    sc_finalize()

cdef int _failed = Py_AtExit(module_cleanup)
if _failed:
    raise(ImportError("unable to register cleanup code"))

sc_init(comm_c, 0, 0, NULL, _LP)
p4est_init(NULL, _LP)


cdef class Connectivity(object):
    cdef p4est_connectivity_t *_con
    
    def __cinit__(self, kind='unitsquare'):
        self._con = p4est_connectivity_new_unitsquare()  # TODO

    def __dealloc__(self):
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
        raise ValueError("Quadrant can not be instantiated for pure python")

    cdef _change_quadrant(self, p4est_quadrant_t *quadrant):
        self._quadrant = quadrant

    def __str__(self):
        return "Quadrant(x={}, y={}, level={}, pad8={}, pad16={})".format(
                self.x, self.y, self.level, self.pad8, self.pad16)




cdef class InitCallbackContainer:
    cdef p4est_init_t callback_c



cdef void _wrap_init_callback(p4est_t *p4est,
                                   p4est_topidx_t which_tree,
                                   p4est_quadrant_t *quadrant):
    cdef P4est p4est_py = <P4est> p4est.user_pointer
    p4est_py._quadrant_template._change_quadrant(quadrant)
    p4est_py._init_callback_python(p4est_py._quadrant_template)  #TODO



cdef class P4est(object):
    cdef p4est_t *_p4est
    cdef Connectivity _con
    cdef object _init_callback_python
    cdef Quadrant _quadrant_template

    def __init__(self, Connectivity connectivity not None,
                 user_data_init_callback=None,
                 initial_level=4,
                 fill_uniform=0,
                 data_size=5):

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
        self._p4est = p4est_new_ext(comm_c, self._con._con, 0, 
                                    initial_level, fill_uniform,
                                    data_size, callback_c,
                                    <void *> self)
        # TODO: error checking?

    def __dealloc__(self):
        if self._p4est is not NULL:
            p4est_destroy(self._p4est)
        self._p4est = NULL
        self._con = None 

    def quadrants(self):
        pass


#############################################
# Example for fast callback in cython       # 
#############################################

cdef void my_callback(p4est_t *p4est,
                      p4est_topidx_t which_tree,
                      p4est_quadrant_t *quadrant):
    print "hallo"


cdef InitCallbackContainer container = InitCallbackContainer()
container.callback_c = <p4est_init_t> my_callback

fast_callable = container

