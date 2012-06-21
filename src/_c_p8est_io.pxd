from _c_p8est cimport *

cdef extern from "p8est_io.h" nogil:
    enum: P8EST_IO_H

    sc_array_t *p4est_deflate_quadrants (p8est_t * p8est, sc_array_t **data)
