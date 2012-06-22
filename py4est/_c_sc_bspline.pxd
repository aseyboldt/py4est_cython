from _c_sc_dmatrix cimport *

cdef extern from "sc_bspline.h" nogil:
    enum: SC_BSPLINE_H

    SC_EXTERN_C_BEGIN
    ctypedef struct sc_bspline_t:
        int d
        int p
        int n
        int m
        int l
        int cacheknot
        sc_dmatrix_t *points
        sc_dmatrix_t *knots
        int knots_owned
        sc_dmatrix_t *works
        int works_owned
    int sc_bspline_min_number_points (int n)
    int sc_bspline_min_number_knots (int n)
    sc_dmatrix_t *sc_bspline_knots_new (int n, sc_dmatrix_t * points)
    sc_dmatrix_t *sc_bspline_knots_new_length (int n, sc_dmatrix_t * points)
    sc_dmatrix_t *sc_bspline_knots_new_periodic (int n, sc_dmatrix_t * points)
    sc_dmatrix_t *sc_bspline_knots_new_length_periodic (int n, sc_dmatrix_t * points)
    void sc_bspline_make_points_periodic (int n, sc_dmatrix_t * points)
    sc_dmatrix_t *sc_bspline_workspace_new (int n, int d)
    sc_bspline_t *sc_bspline_new (int n, sc_dmatrix_t * points, sc_dmatrix_t * knots, sc_dmatrix_t * works)
    void sc_bspline_destroy (sc_bspline_t * bs)
    void sc_bspline_evaluate (sc_bspline_t * bs, double t, double *result)
    void sc_bspline_derivative (sc_bspline_t * bs, double t, double *result)
    void sc_bspline_derivative_n (sc_bspline_t * bs, int order, double t, double *result)
    void sc_bspline_derivative2 (sc_bspline_t * bs, double t, double *result)
    SC_EXTERN_C_END
