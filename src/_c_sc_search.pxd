from _c_sc cimport *

cdef extern from "sc_search.h" nogil:
    enum: SC_SEARCH_H

    SC_EXTERN_C_BEGIN
    int sc_search_bias (int maxlevel, int level, int interval, int target)
    ssize_t sc_search_lower_bound64 (int64_t target, int64_t * array, size_t size, size_t guess)
    SC_EXTERN_C_END
