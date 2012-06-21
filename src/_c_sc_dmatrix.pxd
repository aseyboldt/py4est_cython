from _c_sc_blas cimport *
from _c_sc_containers cimport *

cdef extern from "sc_dmatrix.h" nogil:
    enum: SC_DMATRIX_H

    SC_EXTERN_C_BEGIN
    cdef struct sc_dmatrix:
        double **e
        sc_bint_t m, n
        int view
    ctypedef sc_dmatrix sc_dmatrix_t
    int sc_darray_is_valid (double *darray, size_t nelem)
    int sc_darray_is_range (double *darray, size_t nelem, double low, double high)
    sc_dmatrix_t *sc_dmatrix_new (sc_bint_t m, sc_bint_t n)
    sc_dmatrix_t *sc_dmatrix_new_zero (sc_bint_t m, sc_bint_t n)
    sc_dmatrix_t *sc_dmatrix_clone (sc_dmatrix_t * dmatrix)
    sc_dmatrix_t *sc_dmatrix_new_data (sc_bint_t m, sc_bint_t n, double *data)
    sc_dmatrix_t *sc_dmatrix_new_view (sc_bint_t m, sc_bint_t n, sc_dmatrix_t * orig)
    sc_dmatrix_t *sc_dmatrix_new_view_offset (sc_bint_t o, sc_bint_t m, sc_bint_t n, sc_dmatrix_t * orig)
    void sc_dmatrix_reshape (sc_dmatrix_t * dmatrix, sc_bint_t m, sc_bint_t n)
    void sc_dmatrix_resize (sc_dmatrix_t * dmatrix, sc_bint_t m, sc_bint_t n)
    void sc_dmatrix_resize_in_place (sc_dmatrix_t * dmatrix, sc_bint_t m, sc_bint_t n)
    void sc_dmatrix_destroy (sc_dmatrix_t * dmatrix)
    int sc_dmatrix_is_valid (sc_dmatrix_t * A)
    int sc_dmatrix_is_symmetric (sc_dmatrix_t * A, double tolerance)
    void sc_dmatrix_set_zero (sc_dmatrix_t * dmatrix)
    void sc_dmatrix_set_value (sc_dmatrix_t * dmatrix, double value)
    void sc_dmatrix_scale (double alpha, sc_dmatrix_t * X)
    void sc_dmatrix_shift (double alpha, sc_dmatrix_t * X)
    void sc_dmatrix_alphadivide (double alpha, sc_dmatrix_t * X)
    void sc_dmatrix_pow (double exponent, sc_dmatrix_t * X)
    void sc_dmatrix_fabs (sc_dmatrix_t * X, sc_dmatrix_t * Y)
    void sc_dmatrix_sqrt (sc_dmatrix_t * X, sc_dmatrix_t * Y)
    void sc_dmatrix_getsign (sc_dmatrix_t * X, sc_dmatrix_t * Y)
    void sc_dmatrix_greaterequal (sc_dmatrix_t * X, double bound, sc_dmatrix_t * Y)
    void sc_dmatrix_lessequal (sc_dmatrix_t * X, double bound, sc_dmatrix_t * Y)
    void sc_dmatrix_maximum (sc_dmatrix_t * X, sc_dmatrix_t * Y)
    void sc_dmatrix_minimum (sc_dmatrix_t * X, sc_dmatrix_t * Y)
    void sc_dmatrix_dotmultiply (sc_dmatrix_t * X, sc_dmatrix_t * Y)
    void sc_dmatrix_dotdivide (sc_dmatrix_t * X, sc_dmatrix_t * Y)
    void sc_dmatrix_copy (sc_dmatrix_t * X, sc_dmatrix_t * Y)
    void sc_dmatrix_transpose (sc_dmatrix_t * X, sc_dmatrix_t * Y)
    void sc_dmatrix_add (double alpha, sc_dmatrix_t * X, sc_dmatrix_t * Y)
    void sc_dmatrix_vector (sc_trans_t transa, sc_trans_t transx, sc_trans_t transy, double alpha, sc_dmatrix_t * A, sc_dmatrix_t * X, double beta, sc_dmatrix_t * Y)
    void sc_dmatrix_multiply (sc_trans_t transa, sc_trans_t transb, double alpha, sc_dmatrix_t * A, sc_dmatrix_t * B, double beta, sc_dmatrix_t * C)
    void sc_dmatrix_ldivide (sc_trans_t transa, sc_dmatrix_t * A, sc_dmatrix_t * B, sc_dmatrix_t * C)
    void sc_dmatrix_rdivide (sc_trans_t transb, sc_dmatrix_t * A, sc_dmatrix_t * B, sc_dmatrix_t * C)
    void sc_dmatrix_write (sc_dmatrix_t * dmatrix, FILE * fp)
    cdef struct sc_dmatrix_pool:
        int m, n
        size_t elem_count
        sc_array_t freed
    ctypedef sc_dmatrix_pool sc_dmatrix_pool_t
    sc_dmatrix_pool_t *sc_dmatrix_pool_new (int m, int n)
    void sc_dmatrix_pool_destroy (sc_dmatrix_pool_t * dmpool)
    sc_dmatrix_t *sc_dmatrix_pool_alloc (sc_dmatrix_pool_t * dmpool)
    void sc_dmatrix_pool_free (sc_dmatrix_pool_t * dmpool, sc_dmatrix_t * dm)
    SC_EXTERN_C_END
