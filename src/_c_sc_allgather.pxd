from _c_sc cimport *

cdef extern from "sc_allgather.h" nogil:
    enum: SC_ALLGATHER_H
    enum: SC_AG_ALLTOALL_MAX

    SC_EXTERN_C_BEGIN
    void sc_ag_alltoall (MPI_Comm mpicomm, char *data, int datasize, int groupsize, int myoffset, int myrank)
    void sc_ag_recursive (MPI_Comm mpicomm, char *data, int datasize, int groupsize, int myoffset, int myrank)
    int sc_allgather (void *sendbuf, int sendcount, MPI_Datatype sendtype, void *recvbuf, int recvcount, MPI_Datatype recvtype, MPI_Comm mpicomm)
    SC_EXTERN_C_END
