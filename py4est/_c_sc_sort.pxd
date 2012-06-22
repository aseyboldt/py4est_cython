from _c_sc cimport *

cdef extern from "sc_sort.h" nogil:
    enum: SC_SORT_H

    SC_EXTERN_C_BEGIN
    void sc_psort (MPI_Comm mpicomm, void *base, size_t * nmemb, size_t size, int (*compar) (void *, void *))
    SC_EXTERN_C_END
