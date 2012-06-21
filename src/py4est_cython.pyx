cimport mpi4py.MPI as MPI
cimport mpi4py.mpi_c as mpi_c

import atexit

#from p4est cimport *

# log level for p4est and sc
_LP = 0


#from _c_p4est cimport *
from _c_p4est_base cimport p4est_init
from _c_sc cimport sc_init, sc_finalize


"""
cdef extern from "p4est_wrap.h":
    void p4est_wrap_init(mpi_c.MPI_Comm)

cdef extern from "sc.h":
    void sc_init(mpi_c.MPI_Comm,
                 int catch_signals,
                 int print_backtrace,
                 void *log_handler,
                 int log_threshold)
    void sc_finalize()


cdef extern from "p4est_base.h":
    void p4est_init (void*, int log_threshold) # Todo void *

cdef extern from "p4est_ext.h":
    p4est_t *p4est_new_ext (MPI_Comm mpicomm,
                            void * connectivity, #Todo void *
                            p4est_locidx_t min_quadrants,
                            int min_level, int fill_uniform,
                            size_t data_size,
                            p4est_init_t init_fn,
                            void *user_pointer)

"""


cdef mpi_c.MPI_Comm comm = MPI.Comm().ob_mpi

sc_init(comm, 0, 0, NULL, _LP)
p4est_init(NULL, _LP)

@atexit.register
def ceanup():
    sc_finalize()



def walk_local_leaves():
    pass
