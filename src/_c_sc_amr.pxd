from _c_sc_statistics cimport *

cdef extern from "sc_amr.h" nogil:
    enum: SC_AMR_H

    SC_EXTERN_C_BEGIN
    cdef struct sc_amr_control:
        double *restrict errors
        sc_statinfo_t estats
        MPI_Comm mpicomm
        long num_procs_long
        long num_total_elements
        double coarsen_threshold
        double refine_threshold
        long num_total_coarsen
        long num_total_refine
        long num_total_estimated
    ctypedef sc_amr_control sc_amr_control_t
    void sc_amr_error_stats (MPI_Comm mpicomm, long num_local_elements, double *restrict errors, sc_amr_control_t * amr)
    ctypedef long (*sc_amr_count_coarsen_fn) (sc_amr_control_t * amr, void *user_data)
    ctypedef long (*sc_amr_count_refine_fn) (sc_amr_control_t * amr, void *user_data)
    void sc_amr_coarsen_specify (int package_id, sc_amr_control_t * amr, double coarsen_threshold, sc_amr_count_coarsen_fn cfn, void *user_data)
    void sc_amr_coarsen_search (int package_id, sc_amr_control_t * amr, long num_total_ideal, double coarsen_threshold_high, double target_window, int max_binary_steps, sc_amr_count_coarsen_fn cfn, void *user_data)
    void sc_amr_refine_search (int package_id, sc_amr_control_t * amr, long num_total_ideal, double refine_threshold_low, double target_window, int max_binary_steps, sc_amr_count_refine_fn rfn, void *user_data)
    SC_EXTERN_C_END
