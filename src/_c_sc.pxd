from _c_sc_config cimport *
from _c_mpi cimport *
from libc.math cimport *
from _c_ctype cimport *
from libc.float cimport *
from _c_libgen cimport *
from libc.limits cimport *
from _c_stdarg cimport *
from libc.stddef cimport *
from libc.stdint cimport *
from libc.stdio cimport *
from libc.stdlib cimport *
from libc.string cimport *
from posix.unistd cimport *
from _c_sc_c99_functions cimport *
from _c_sc_mpi cimport *

cdef extern from "sc.h" nogil:
    enum: SC_H
    enum: __STDC_LIMIT_MACROS
    enum: SC_EXTERN_C_BEGIN
    enum: SC_EXTERN_C_END
    enum: SC_EXTERN_C_BEGIN
    enum: SC_EXTERN_C_END
    enum: M_E
    enum: M_LOG2E
    enum: M_LOG10E
    enum: M_LN2
    enum: M_LN10
    enum: M_PI
    enum: M_PI_2
    enum: M_PI_4
    enum: M_1_PI
    enum: M_2_PI
    enum: M_2_SQRTPI
    enum: M_SQRT2
    enum: M_SQRT1_2
    enum: SC_EPS
    enum: SC_1000_EPS
    enum: index
    enum: rindex
    enum: link
    enum: NO_DEFINE_DONT_USE_CONFLICT
    enum: SC_LC_GLOBAL
    enum: SC_LC_NORMAL
    enum: SC_LP_DEFAULT
    enum: SC_LP_ALWAYS
    enum: SC_LP_TRACE
    enum: SC_LP_DEBUG
    enum: SC_LP_VERBOSE
    enum: SC_LP_INFO
    enum: SC_LP_STATISTICS
    enum: SC_LP_PRODUCTION
    enum: SC_LP_ESSENTIAL
    enum: SC_LP_ERROR
    enum: SC_LP_SILENT
    enum: SC_LP_THRESHOLD
    enum: SC_LP_THRESHOLD
    enum: SC_LP_THRESHOLD

    SC_EXTERN_C_BEGIN
    int sc_log2_lookup_table[256]
    int sc_package_id
    FILE *sc_trace_file
    int sc_trace_prio
    void SC_ABORTF (char *fmt, ...) __attribute__ ((format (printf, 1, 2))) __attribute__ ((noreturn))
    void SC_CHECK_ABORTF (int success, char *fmt, ...) __attribute__ ((format (printf, 2, 3)))
    void SC_GEN_LOGF (int package, int category, int priority, char *fmt, ...) __attribute__ ((format (printf, 4, 5)))
    void SC_GLOBAL_LOGF (int priority, char *fmt, ...) __attribute__ ((format (printf, 2, 3)))
    void SC_LOGF (int priority, char *fmt, ...) __attribute__ ((format (printf, 2, 3)))
    void SC_GLOBAL_TRACEF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void SC_GLOBAL_LDEBUGF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void SC_GLOBAL_VERBOSEF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void SC_GLOBAL_INFOF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void SC_GLOBAL_STATISTICSF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void SC_GLOBAL_PRODUCTIONF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void SC_GLOBAL_ESSENTIALF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void SC_GLOBAL_LERRORF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void SC_TRACEF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void SC_LDEBUGF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void SC_VERBOSEF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void SC_INFOF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void SC_STATISTICSF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void SC_PRODUCTIONF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void SC_ESSENTIALF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    void SC_LERRORF (char *fmt, ...) __attribute__ ((format (printf, 1, 2)))
    ctypedef void (*sc_handler_t) (void *data)
    ctypedef void (*sc_log_handler_t) (FILE * log_stream, char *filename, int lineno, int package, int category, int priority, char *msg)
    void *sc_malloc (int package, size_t size)
    void *sc_calloc (int package, size_t nmemb, size_t size)
    void *sc_realloc (int package, void *ptr, size_t size)
    char *sc_strdup (int package, char *s)
    void sc_free (int package, void *ptr)
    void sc_memory_check (int package)
    int sc_int_compare (void *v1, void *v2)
    int sc_int16_compare (void *v1, void *v2)
    int sc_int32_compare (void *v1, void *v2)
    int sc_int64_compare (void *v1, void *v2)
    int sc_double_compare (void *v1, void *v2)
    void sc_set_log_defaults (FILE * log_stream, sc_log_handler_t log_handler, int log_thresold)
    void sc_log (char *filename, int lineno, int package, int category, int priority, char *msg)
    void sc_logf (char *filename, int lineno, int package, int category, int priority, char *fmt, ...) __attribute__ ((format (printf, 6, 7)))
    void sc_logv (char *filename, int lineno, int package, int category, int priority, char *fmt, va_list ap)
    void sc_abort (void) __attribute__ ((noreturn))
    void sc_abort_verbose (char *filename, int lineno, char *msg) __attribute__ ((noreturn))
    void sc_abort_verbosef (char *filename, int lineno, char *fmt, ...) __attribute__ ((format (printf, 3, 4))) __attribute__ ((noreturn))
    void sc_abort_verbosev (char *filename, int lineno, char *fmt, va_list ap) __attribute__ ((noreturn))
    void sc_abort_collective (char *msg) __attribute__ ((noreturn))
    int sc_package_register (sc_log_handler_t log_handler, int log_threshold, char *name, char *full)
    int sc_package_is_registered (int package_id)
    void sc_package_unregister (int package_id)
    void sc_package_print_summary (int log_priority)
    void sc_init (MPI_Comm mpicomm, int catch_signals, int print_backtrace, sc_log_handler_t log_handler, int log_threshold)
    void sc_finalize ()
    int sc_is_root ()
    SC_EXTERN_C_END
