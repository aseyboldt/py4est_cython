from _c_p4est cimport *

cdef extern from "p4est_search.h" nogil:
    enum: P4EST_SEARCH_H

    SC_EXTERN_C_BEGIN
    ssize_t p4est_find_lower_bound (sc_array_t * array, p4est_quadrant_t * q, size_t guess)
    ssize_t p4est_find_higher_bound (sc_array_t * array, p4est_quadrant_t * q, size_t guess)
    void p4est_split_array (sc_array_t * array, int level, size_t indices[])
    int32_t p4est_find_range_boundaries (p4est_quadrant_t * lq, p4est_quadrant_t * uq, int level, int faces[], int corners[])
    ctypedef int (*p4est_search_query_t) (p4est_t * p4est, p4est_topidx_t which_tree, p4est_quadrant_t * quadrant, int is_leaf, void *point)
    void p4est_search (p4est_t * p4est, p4est_search_query_t search_fn, sc_array_t * points)
    SC_EXTERN_C_END
