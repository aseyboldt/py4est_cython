from _c_p4est cimport *

cdef extern from "p4est_io.h" nogil:
    enum: P4EST_IO_H

    sc_array_t *p4est_deflate_quadrants (p4est_t * p4est, sc_array_t **data)
