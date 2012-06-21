from _c_p8est cimport *

cdef extern from "p8est_search.h" nogil:
    enum: P8EST_SEARCH_H

    SC_EXTERN_C_BEGIN
    ssize_t p8est_find_lower_bound (sc_array_t * array, p8est_quadrant_t * q, size_t guess)
    ssize_t p8est_find_higher_bound (sc_array_t * array, p8est_quadrant_t * q, size_t guess)
    void p8est_split_array (sc_array_t * array, int level, size_t indices[])
    int32_t p8est_find_range_boundaries (p8est_quadrant_t * lq, p8est_quadrant_t * uq, int level, int faces[], int edges[], int corners[])
    ctypedef int (*p8est_search_query_t) (p8est_t * p8est, p4est_topidx_t which_tree, p8est_quadrant_t * quadrant, int is_leaf, void *point)
    void p8est_search (p8est_t * p8est, p8est_search_query_t search_fn, sc_array_t * points)
    SC_EXTERN_C_END
