from _c_p4est_config cimport *
from _c_sc_containers cimport *

cdef extern from "p4est_base.h" nogil:
    enum: P4EST_BASE_H
    enum: P4EST_MPI_QCOORD
    enum: P4EST_VTK_QCOORD
    enum: P4EST_QCOORD_MIN
    enum: P4EST_QCOORD_MAX
    enum: P4EST_QCOORD_1
    enum: P4EST_MPI_TOPIDX
    enum: P4EST_VTK_TOPIDX
    enum: P4EST_TOPIDX_MAX
    enum: P4EST_TOPIDX_FITS_32
    enum: P4EST_TOPIDX_1
    enum: p4est_locidx_compare
    enum: P4EST_MPI_LOCIDX
    enum: P4EST_VTK_LOCIDX
    enum: P4EST_LOCIDX_MAX
    enum: P4EST_LOCIDX_1
    enum: P4EST_MPI_GLOIDX
    enum: P4EST_VTK_GLOIDX
    enum: P4EST_GLOIDX_MAX
    enum: P4EST_GLOIDX_1
    enum: P4EST_GLOBAL_NOTICE
    enum: P4EST_GLOBAL_NOTICEF
    enum: P4EST_NOTICE
    enum: P4EST_NOTICEF

    SC_EXTERN_C_BEGIN
    ctypedef int32_t p4est_qcoord_t
    ctypedef int32_t p4est_topidx_t
    ctypedef int32_t p4est_locidx_t
    ctypedef int64_t p4est_gloidx_t
    void P4EST_GLOBAL_LOGF (int priority, char *fmt, ...) __attribute__ ((format (printf, 2, 3)))
    void P4EST_LOGF (int priority, char *fmt, ...) __attribute__ ((format (printf, 2, 3)))
    void P4EST_GLOBAL_TRACEF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void P4EST_GLOBAL_LDEBUGF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void P4EST_GLOBAL_VERBOSEF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void P4EST_GLOBAL_INFOF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void P4EST_GLOBAL_STATISTICSF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void P4EST_GLOBAL_PRODUCTIONF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void P4EST_GLOBAL_ESSENTIALF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void P4EST_GLOBAL_LERRORF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void P4EST_TRACEF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void P4EST_LDEBUGF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void P4EST_VERBOSEF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void P4EST_INFOF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void P4EST_STATISTICSF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void P4EST_PRODUCTIONF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void P4EST_ESSENTIALF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void P4EST_LERRORF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    int p4est_package_id
    void p4est_init (sc_log_handler_t log_handler, int log_threshold)
    unsigned p4est_topidx_hash2 (p4est_topidx_t * tt)
    unsigned p4est_topidx_hash3 (p4est_topidx_t * tt)
    unsigned p4est_topidx_hash4 (p4est_topidx_t * tt)
    int p4est_topidx_is_sorted (p4est_topidx_t * t, int length)
    void p4est_topidx_bsort (p4est_topidx_t * t, int length)
    SC_EXTERN_C_END
