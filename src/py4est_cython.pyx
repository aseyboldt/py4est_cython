cimport mpi4py.MPI as MPI
cimport mpi4py.mpi_c as mpi_c

import atexit

# log level for p4est and sc
_LP = 0

from _c_p4est_base cimport p4est_init
from _c_sc cimport sc_init, sc_finalize

cdef mpi_c.MPI_Comm comm = MPI.Comm().ob_mpi

sc_init(comm, 0, 0, NULL, _LP)
p4est_init(NULL, _LP)

@atexit.register
def ceanup():
    sc_finalize()



def walk_local_leaves():
    pass
