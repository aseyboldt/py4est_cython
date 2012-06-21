from _c_sc cimport *
from _c_sc_keyvalue cimport *

cdef extern from "sc_statistics.h" nogil:
    enum: SC_STATISTICS_H

    SC_EXTERN_C_BEGIN
    cdef struct sc_statinfo:
        int dirty
        long count
        double sum_values, sum_squares, min, max
        int min_at_rank, max_at_rank
        double average, variance, standev
        double variance_mean, standev_mean
        char *variable
    ctypedef sc_statinfo sc_statinfo_t
    cdef struct sc_stats:
        MPI_Comm mpicomm
        sc_keyvalue_t *kv
        sc_array_t *sarray
    ctypedef sc_stats sc_statistics_t
    void sc_stats_set1 (sc_statinfo_t * stats, double value, char *variable)
    void sc_stats_init (sc_statinfo_t * stats, char *variable)
    void sc_stats_accumulate (sc_statinfo_t * stats, double value)
    void sc_stats_compute (MPI_Comm mpicomm, int nvars, sc_statinfo_t * stats)
    void sc_stats_compute1 (MPI_Comm mpicomm, int nvars, sc_statinfo_t * stats)
    void sc_stats_print (int package_id, int log_priority, int nvars, sc_statinfo_t * stats, int full, int summary)
    sc_statistics_t *sc_statistics_new (MPI_Comm mpicomm)
    void sc_statistics_destroy (sc_statistics_t * stats)
    void sc_statistics_add (sc_statistics_t * stats, char *name)
    void sc_statistics_add_empty (sc_statistics_t * stats, char *name)
    void sc_statistics_set (sc_statistics_t * stats, char *name, double value)
    void sc_statistics_accumulate (sc_statistics_t * stats, char *name, double value)
    void sc_statistics_compute (sc_statistics_t * stats)
    void sc_statistics_print (sc_statistics_t * stats, int package_id, int log_priority, int full, int summary)
    SC_EXTERN_C_END
