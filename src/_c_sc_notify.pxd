from _c_sc cimport *

cdef extern from "sc_notify.h" nogil:
    enum: SC_NOTIFY_H

    SC_EXTERN_C_BEGIN
    int sc_notify_allgather (int *receivers, int num_receivers, int *senders, int *num_senders, MPI_Comm mpicomm)
    int sc_notify (int *receivers, int num_receivers, int *senders, int *num_senders, MPI_Comm mpicomm)
    SC_EXTERN_C_END
