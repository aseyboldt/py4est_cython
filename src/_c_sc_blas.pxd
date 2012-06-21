from _c_sc cimport *

cdef extern from "sc_blas.h" nogil:
    enum: SC_BLAS_H
    enum: BLAS_DLAMCH
    enum: BLAS_DSCAL
    enum: BLAS_DCOPY
    enum: BLAS_DAXPY
    enum: BLAS_DDOT
    enum: BLAS_DGEMV
    enum: BLAS_DGEMM
    enum: BLAS_DLAMCH
    enum: BLAS_DSCAL
    enum: BLAS_DCOPY
    enum: BLAS_DAXPY
    enum: BLAS_DDOT
    enum: BLAS_DGEMM
    enum: BLAS_DGEMV

    SC_EXTERN_C_BEGIN
    ctypedef int sc_bint_t
    ctypedef unsigned int sc_buint_t
    enum sc_trans_t:
        SC_NO_TRANS
        SC_TRANS
        SC_TRANS_ANCHOR 
    enum sc_uplo_t:
        SC_UPPER
        SC_LOWER
        SC_UPLO_ANCHOR 
    enum sc_cmach_t:
        SC_CMACH_EPS
        SC_CMACH_SFMIN
        SC_CMACH_BASE
        SC_CMACH_PREC
        SC_CMACH_T
        SC_CMACH_RND
        SC_CMACH_EMIN
        SC_CMACH_RMIN
        SC_CMACH_EMAX
        SC_CMACH_RMAX
        SC_CMACH_ANCHOR 
    char sc_transchar[]
    char sc_antitranschar[]
    char sc_uplochar[]
    char sc_cmachchar[]
    double BLAS_DLAMCH (char *cmach)
    void BLAS_DSCAL (sc_bint_t * n, double *alpha, double *X, sc_bint_t * incx)
    void BLAS_DCOPY (sc_bint_t * n, double *X, sc_bint_t * incx, double *Y, sc_bint_t * incy)
    void BLAS_DAXPY (sc_bint_t * n, double *alpha, double *X, sc_bint_t * incx, double *Y, sc_bint_t * incy)
    double BLAS_DDOT (sc_bint_t * n, double *X, sc_bint_t * incx, double *Y, sc_bint_t * incy)
    void BLAS_DGEMV (char *transa, sc_bint_t * m, sc_bint_t * n, double *alpha, double *a, sc_bint_t * lda, double *x, sc_bint_t * incx, double *beta, double *y, sc_bint_t * incy)
    void BLAS_DGEMM (char *transa, char *transb, sc_bint_t * m, sc_bint_t * n, sc_bint_t * k, double *alpha, double *a, sc_bint_t * lda, double *b, sc_bint_t * ldb, double *beta, double *c, sc_bint_t * ldc)
    int sc_blas_nonimplemented ()
    SC_EXTERN_C_END
