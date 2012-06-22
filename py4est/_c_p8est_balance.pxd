from _c_p8est cimport *

cdef extern from "p8est_balance.h" nogil:
    enum: P8EST_BALANCE_H

    int p8est_balance_seeds (p8est_quadrant_t * q, p8est_quadrant_t * p, p8est_connect_type_t balance, sc_array_t * seeds)
    int p8est_balance_seeds_face (p8est_quadrant_t * q, p8est_quadrant_t * p, int face, p8est_connect_type_t balance, sc_array_t * seeds)
    int p8est_balance_seeds_edge (p8est_quadrant_t * q, p8est_quadrant_t * p, int face, p8est_connect_type_t balance, sc_array_t * seeds)
    int p8est_balance_seeds_corner (p8est_quadrant_t * q, p8est_quadrant_t * p, int face, p8est_connect_type_t balance, sc_array_t * seeds)
