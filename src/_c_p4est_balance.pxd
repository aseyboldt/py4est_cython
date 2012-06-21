from _c_p4est cimport *

cdef extern from "p4est_balance.h" nogil:
    enum: P4EST_BALANCE_H

    int p4est_balance_seeds (p4est_quadrant_t * q, p4est_quadrant_t * p, p4est_connect_type_t balance, sc_array_t * seeds)
    int p4est_balance_seeds_face (p4est_quadrant_t * q, p4est_quadrant_t * p, int face, p4est_connect_type_t balance, sc_array_t * seeds)
    int p4est_balance_seeds_corner (p4est_quadrant_t * q, p4est_quadrant_t * p, int face, p4est_connect_type_t balance, sc_array_t * seeds)
