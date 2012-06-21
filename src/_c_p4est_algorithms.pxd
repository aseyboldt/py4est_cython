from _c_p4est cimport *

cdef extern from "p4est_algorithms.h" nogil:
    enum: P4EST_ALGORITHMS_H

    SC_EXTERN_C_BEGIN
    void p4est_quadrant_init_data (p4est_t * p4est, p4est_topidx_t which_tree, p4est_quadrant_t * quad, p4est_init_t init_fn)
    void p4est_quadrant_free_data (p4est_t * p4est, p4est_quadrant_t * quad)
    unsigned p4est_quadrant_checksum (sc_array_t * quadrants, sc_array_t * checkarray, size_t first_quadrant)
    int p4est_tree_is_sorted (p4est_tree_t * tree)
    int p4est_tree_is_linear (p4est_tree_t * tree)
    int p4est_tree_is_complete (p4est_tree_t * tree)
    int p4est_tree_is_almost_sorted (p4est_tree_t * tree, int check_linearity)
    void p4est_tree_print (int log_priority, p4est_tree_t * tree)
    int p4est_is_equal (p4est_t * p4est1, p4est_t * p4est2, int compare_data)
    int p4est_is_valid (p4est_t * p4est)
    void p4est_tree_compute_overlap (p4est_t * p4est, sc_array_t * in, sc_array_t * out)
    void p4est_tree_compute_overlap_new (p4est_t * p4est, sc_array_t * in, sc_array_t * out, p4est_connect_type_t balance, sc_array_t * borders, sc_array_t * inseeds)
    void p4est_tree_uniqify_overlap (sc_array_t * skip, sc_array_t * out)
    void p4est_tree_uniqify_overlap_new (sc_array_t * out)
    size_t p4est_tree_remove_nonowned (p4est_t * p4est, p4est_topidx_t which_tree)
    void p4est_complete_region (p4est_t * p4est, p4est_quadrant_t * q1, int include_q1, p4est_quadrant_t * q2, int include_q2, p4est_tree_t * tree, p4est_topidx_t which_tree, p4est_init_t init_fn)
    void p4est_complete_subtree (p4est_t * p4est, p4est_topidx_t which_tree, p4est_init_t init_fn)
    void p4est_balance_subtree (p4est_t * p4est, p4est_connect_type_t btype, p4est_topidx_t which_tree, p4est_init_t init_fn)
    void p4est_balance_border (p4est_t * p4est, p4est_connect_type_t btype, p4est_topidx_t which_tree, p4est_init_t init_fn, sc_array_t * borders)
    size_t p4est_linearize_tree (p4est_t * p4est, p4est_tree_t * tree)
    p4est_locidx_t p4est_partition_correction (p4est_gloidx_t * partition, int num_procs, int rank, p4est_gloidx_t min_quadrant_id, p4est_gloidx_t max_quadrant_id)
    int p4est_next_nonempty_process (int rank, int num_procs, p4est_locidx_t * num_quadrants_in_proc)
    p4est_gloidx_t p4est_partition_given (p4est_t * p4est, p4est_locidx_t * num_quadrants_in_proc)
    SC_EXTERN_C_END
