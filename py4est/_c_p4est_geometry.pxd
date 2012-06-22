from _c_p4est cimport *

cdef extern from "p4est_geometry.h" nogil:
    enum: P4EST_GEOMETRY_H

    SC_EXTERN_C_BEGIN
    cdef struct p4est_geometry:
        pass
    ctypedef p4est_geometry p4est_geometry_t
    SC_EXTERN_C_END
