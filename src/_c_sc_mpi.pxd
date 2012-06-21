from _c_sc cimport *

cdef extern from "sc_mpi.h" nogil:
    enum: SC_MPI_H
    enum: MPI_SUCCESS
    enum: MPI_COMM_NULL
    enum: MPI_COMM_WORLD
    enum: MPI_COMM_SELF
    enum: MPI_ANY_SOURCE
    enum: MPI_ANY_TAG
    enum: MPI_STATUS_IGNORE
    enum: MPI_STATUSES_IGNORE
    enum: MPI_REQUEST_NULL
    enum: MPI_CHAR
    enum: MPI_SIGNED_CHAR
    enum: MPI_UNSIGNED_CHAR
    enum: MPI_BYTE
    enum: MPI_SHORT
    enum: MPI_UNSIGNED_SHORT
    enum: MPI_INT
    enum: MPI_UNSIGNED
    enum: MPI_LONG
    enum: MPI_UNSIGNED_LONG
    enum: MPI_LONG_LONG_INT
    enum: MPI_FLOAT
    enum: MPI_DOUBLE
    enum: MPI_LONG_DOUBLE
    enum: MPI_MAX
    enum: MPI_MIN
    enum: MPI_SUM
    enum: MPI_PROD
    enum: MPI_LAND
    enum: MPI_BAND
    enum: MPI_LOR
    enum: MPI_BOR
    enum: MPI_LXOR
    enum: MPI_BXOR
    enum: MPI_MINLOC
    enum: MPI_MAXLOC
    enum: MPI_REPLACE
    enum: MPI_UNDEFINED

    SC_EXTERN_C_BEGIN
    enum sc_tag_t:
        SC_TAG_AG_ALLTOALL = '' + ''
        SC_TAG_AG_RECURSIVE_A
        SC_TAG_AG_RECURSIVE_B
        SC_TAG_AG_RECURSIVE_C
        SC_TAG_NOTIFY_RECURSIVE
        SC_TAG_REDUCE
        SC_TAG_PSORT_LO
        SC_TAG_PSORT_HI 
    ctypedef int MPI_Comm
    ctypedef int MPI_Datatype
    ctypedef int MPI_Op
    ctypedef int MPI_Request
    cdef struct MPI_Status:
        int count
        int cancelled
        int MPI_SOURCE
        int MPI_TAG
        int MPI_ERROR
    ctypedef MPI_Status MPI_Status
    int MPI_Init (int *, char ***)
    int MPI_Finalize ()
    int MPI_Abort (MPI_Comm, int) __attribute__ ((noreturn))
    int MPI_Comm_dup (MPI_Comm, MPI_Comm *)
    int MPI_Comm_free (MPI_Comm *)
    int MPI_Comm_size (MPI_Comm, int *)
    int MPI_Comm_rank (MPI_Comm, int *)
    int MPI_Barrier (MPI_Comm)
    int MPI_Bcast (void *, int, MPI_Datatype, int, MPI_Comm)
    int MPI_Gather (void *, int, MPI_Datatype, void *, int, MPI_Datatype, int, MPI_Comm)
    int MPI_Gatherv (void *, int, MPI_Datatype, void *, int *, int *, MPI_Datatype, int, MPI_Comm)
    int MPI_Allgather (void *, int, MPI_Datatype, void *, int, MPI_Datatype, MPI_Comm)
    int MPI_Allgatherv (void *, int, MPI_Datatype, void *, int *, int *, MPI_Datatype, MPI_Comm)
    int MPI_Reduce (void *, void *, int, MPI_Datatype, MPI_Op, int, MPI_Comm)
    int MPI_Allreduce (void *, void *, int, MPI_Datatype, MPI_Op, MPI_Comm)
    double MPI_Wtime ()
    int MPI_Recv (void *, int, MPI_Datatype, int, int, MPI_Comm, MPI_Status *)
    int MPI_Irecv (void *, int, MPI_Datatype, int, int, MPI_Comm, MPI_Request *)
    int MPI_Send (void *, int, MPI_Datatype, int, int, MPI_Comm)
    int MPI_Isend (void *, int, MPI_Datatype, int, int, MPI_Comm, MPI_Request *)
    int MPI_Probe (int, int, MPI_Comm, MPI_Status *)
    int MPI_Iprobe (int, int, MPI_Comm, int *, MPI_Status *)
    int MPI_Get_count (MPI_Status *, MPI_Datatype, int *)
    int MPI_Wait (MPI_Request *, MPI_Status *)
    int MPI_Waitsome (int, MPI_Request *, int *, int *, MPI_Status *)
    int MPI_Waitall (int, MPI_Request *, MPI_Status *)
    size_t sc_mpi_sizeof (MPI_Datatype t)
    SC_EXTERN_C_END
