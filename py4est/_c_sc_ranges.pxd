from _c_sc cimport *

cdef extern from "sc_ranges.h" nogil:
    enum: SC_RANGES_H

    SC_EXTERN_C_BEGIN
    int sc_ranges_compute (int package_id, int num_procs, int *procs, int rank, int first_peer, int last_peer, int num_ranges, int *ranges)
    int sc_ranges_adaptive (int package_id, MPI_Comm mpicomm, int *procs, int *inout1, int *inout2, int num_ranges, int *ranges, int **global_ranges)
    void sc_ranges_decode (int num_procs, int rank, int max_ranges, int *global_ranges, int *num_receivers, int *receiver_ranks, int *num_senders, int *sender_ranks)
    void sc_ranges_statistics (int package_id, int log_priority, MPI_Comm mpicomm, int num_procs, int *procs, int rank, int num_ranges, int *ranges)
    SC_EXTERN_C_END
