from _c_sc cimport *

cdef extern from "sc_warp.h" nogil:
    enum: SC_WARP_H

    cdef struct sc_warp_interval:
        pass
    ctypedef sc_warp_interval sc_warp_interval_t
    cdef struct sc_warp_interval:
        int level
        double r_low, r_high
        sc_warp_interval_t *left, *right
    SC_EXTERN_C_BEGIN
    sc_warp_interval_t *sc_warp_new (double r_low, double r_high)
    void sc_warp_destroy (sc_warp_interval_t * root)
    void sc_warp_update (sc_warp_interval_t * root, int num_points, double *r_points, double r_tol, int max_level)
    void sc_warp_print (int package_id, int log_priority, sc_warp_interval_t * root)
    void sc_warp_write (sc_warp_interval_t * root, FILE * nout)
    SC_EXTERN_C_END
