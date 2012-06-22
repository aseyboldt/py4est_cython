from _c_p8est cimport *

cdef extern from "p8est_algorithms.h" nogil:
    enum: P8EST_ALGORITHMS_H

    SC_EXTERN_C_BEGIN
    void p8est_quadrant_init_data (p8est_t * p8est, p4est_topidx_t which_tree, p8est_quadrant_t * quad, p8est_init_t init_fn)
    void p8est_quadrant_free_data (p8est_t * p8est, p8est_quadrant_t * quad)
    unsigned p8est_quadrant_checksum (sc_array_t * quadrants, sc_array_t * checkarray, size_t first_quadrant)
    int p8est_tree_is_sorted (p8est_tree_t * tree)
    int p8est_tree_is_linear (p8est_tree_t * tree)
    int p8est_tree_is_complete (p8est_tree_t * tree)
    int p8est_tree_is_almost_sorted (p8est_tree_t * tree, int check_linearity)
    void p8est_tree_print (int log_priority, p8est_tree_t * tree)
    int p8est_is_equal (p8est_t * p8est1, p8est_t * p8est2, int compare_data)
    int p8est_is_valid (p8est_t * p8est)
    void p8est_tree_compute_overlap (p8est_t * p8est, sc_array_t * in, sc_array_t * out)
    void p8est_tree_compute_overlap_new (p8est_t * p8est, sc_array_t * in, sc_array_t * out, p8est_connect_type_t balance, sc_array_t * borders, sc_array_t * inseeds)
    void p8est_tree_uniqify_overlap (sc_array_t * skip, sc_array_t * out)
    void p8est_tree_uniqify_overlap_new (sc_array_t * out)
    size_t p8est_tree_remove_nonowned (p8est_t * p8est, p4est_topidx_t which_tree)
    void p8est_complete_region (p8est_t * p8est, p8est_quadrant_t * q1, int include_q1, p8est_quadrant_t * q2, int include_q2, p8est_tree_t * tree, p4est_topidx_t which_tree, p8est_init_t init_fn)
    void p8est_complete_subtree (p8est_t * p8est, p4est_topidx_t which_tree, p8est_init_t init_fn)
    void p8est_balance_subtree (p8est_t * p8est, p8est_connect_type_t btype, p4est_topidx_t which_tree, p8est_init_t init_fn)
    void p8est_balance_border (p8est_t * p8est, p8est_connect_type_t btype, p4est_topidx_t which_tree, p8est_init_t init_fn, sc_array_t * borders)
    size_t p8est_linearize_tree (p8est_t * p8est, p8est_tree_t * tree)
    p4est_locidx_t p8est_partition_correction (p4est_gloidx_t * partition, int num_procs, int rank, p4est_gloidx_t min_quadrant_id, p4est_gloidx_t max_quadrant_id)
    int p8est_next_nonempty_process (int rank, int num_procs, p4est_locidx_t * num_quadrants_in_proc)
    p4est_gloidx_t p8est_partition_given (p8est_t * p8est, p4est_locidx_t * num_quadrants_in_proc)
    SC_EXTERN_C_END
