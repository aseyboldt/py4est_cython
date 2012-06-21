from _c_sc cimport *

cdef extern from "sc_reduce.h" nogil:
    enum: SC_REDUCE_H
    enum: SC_REDUCE_ALLTOALL_LEVEL

    ctypedef void (*sc_reduce_t) (void *sendbuf, void *recvbuf, int sendcount, MPI_Datatype sendtype)
    SC_EXTERN_C_BEGIN
    int sc_allreduce_custom (void *sendbuf, void *recvbuf, int sendcount, MPI_Datatype sendtype, sc_reduce_t reduce_fn, MPI_Comm mpicomm)
    int sc_reduce_custom (void *sendbuf, void *recvbuf, int sendcount, MPI_Datatype sendtype, sc_reduce_t reduce_fn, int target, MPI_Comm mpicomm)
    int sc_allreduce (void *sendbuf, void *recvbuf, int sendcount, MPI_Datatype sendtype, MPI_Op operation, MPI_Comm mpicomm)
    int sc_reduce (void *sendbuf, void *recvbuf, int sendcount, MPI_Datatype sendtype, MPI_Op operation, int target, MPI_Comm mpicomm)
    SC_EXTERN_C_END
