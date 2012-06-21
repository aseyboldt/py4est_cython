from _c_sc cimport *

cdef extern from "sc_flops.h" nogil:
    enum: SC_FLOPS_H

    SC_EXTERN_C_BEGIN
    cdef struct sc_flopinfo:
        double seconds
        double cwtime
        float crtime
        float cptime
        long long cflpops
        double iwtime
        float irtime
        float iptime
        long long iflpops
        float mflops
    ctypedef sc_flopinfo sc_flopinfo_t
    void sc_flops_papi (float *rtime, float *ptime, long long *flpops, float *mflops)
    void sc_flops_start (sc_flopinfo_t * fi)
    void sc_flops_count (sc_flopinfo_t * fi)
    void sc_flops_snap (sc_flopinfo_t * fi, sc_flopinfo_t * snapshot)
    void sc_flops_shot (sc_flopinfo_t * fi, sc_flopinfo_t * snapshot)
    void sc_flops_shotv (sc_flopinfo_t * fi, ...)
    SC_EXTERN_C_END
