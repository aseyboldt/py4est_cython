from _c_sc_blas cimport *

cdef extern from "sc_lapack.h" nogil:
    enum: SC_LAPACK_H
    enum: LAPACK_DGELS
    enum: LAPACK_DGETRF
    enum: LAPACK_DGETRS
    enum: LAPACK_DSTEV
    enum: LAPACK_DTRSM
    enum: LAPACK_DLAIC1
    enum: LAPACK_ILAENV
    enum: LAPACK_DGELS
    enum: LAPACK_DGETRF
    enum: LAPACK_DGETRS
    enum: LAPACK_DSTEV
    enum: LAPACK_DTRSM
    enum: LAPACK_DLAIC1
    enum: LAPACK_ILAENV

    SC_EXTERN_C_BEGIN
    enum sc_jobz_t:
        SC_EIGVALS_ONLY
        SC_EIGVALS_AND_EIGVECS
        SC_JOBZ_ANCHOR 
    char sc_jobzchar[]
    void LAPACK_DGELS (char *trans, sc_bint_t * m, sc_bint_t * n, sc_bint_t * nrhs, double *a, sc_bint_t * lda, double *b, sc_bint_t * ldb, double *work, sc_bint_t * lwork, sc_bint_t * info)
    void LAPACK_DGETRF (sc_bint_t * m, sc_bint_t * n, double *a, sc_bint_t * lda, sc_bint_t * ipiv, sc_bint_t * info)
    void LAPACK_DGETRS (char *trans, sc_bint_t * n, sc_bint_t * nrhs, double *a, sc_bint_t * lda, sc_bint_t * ipiv, double *b, sc_bint_t * ldx, sc_bint_t * info)
    void LAPACK_DSTEV (char *jobz, sc_bint_t * n, double *d, double *e, double *z, sc_bint_t * ldz, double *work, sc_bint_t * info)
    void LAPACK_DTRSM (char *side, char *uplo, char *transa, char *diag, sc_bint_t * m, sc_bint_t * n, double *alpha, double *a, sc_bint_t * lda, double *b, sc_bint_t * ldb)
    void LAPACK_DLAIC1 (int *job, int *j, double *x, double *sest, double *w, double *gamma, double *sestpr, double *s, double *c)
    int LAPACK_ILAENV (sc_bint_t * ispec, char *name, char *opts, sc_bint_t * N1, sc_bint_t * N2, sc_bint_t * N3, sc_bint_t * N4, sc_buint_t name_length, sc_buint_t opts_length)
    int sc_lapack_nonimplemented ()
    SC_EXTERN_C_END
