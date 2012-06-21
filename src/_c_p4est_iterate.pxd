from _c_p4est cimport *
from _c_p4est_ghost cimport *

cdef extern from "p4est_iterate.h" nogil:
    enum: P4EST_ITERATE_H

    SC_EXTERN_C_BEGIN
    cdef struct p4est_iter_volume_info:
        p4est_t *p4est
        p4est_ghost_t *ghost_layer
        p4est_quadrant_t *quad
        p4est_locidx_t quadid
        p4est_topidx_t treeid
    ctypedef p4est_iter_volume_info p4est_iter_volume_info_t
    ctypedef void (*p4est_iter_volume_t) (p4est_iter_volume_info_t * info, void *user_data)
    cdef struct _struct_full:
        int8_t is_ghost
        p4est_quadrant_t *quad
        p4est_locidx_t quadid
    cdef struct _struct_hanging:
        int8_t is_ghost[2]
        p4est_quadrant_t *quad[2]
        p4est_locidx_t quadid[2]
    cdef union p4est_iter_face_side_data:
        _struct_full full
        _struct_hanging hanging
    cdef struct p4est_iter_face_side:
        p4est_topidx_t treeid
        int8_t face
        int8_t is_hanging
        p4est_iter_face_side_data is
    ctypedef p4est_iter_face_side p4est_iter_face_side_t
    cdef struct p4est_iter_face_info:
        p4est_t *p4est
        p4est_ghost_t *ghost_layer
        int8_t orientation
        int8_t tree_boundary
        sc_array_t sides
    ctypedef p4est_iter_face_info p4est_iter_face_info_t
    ctypedef void (*p4est_iter_face_t) (p4est_iter_face_info_t * info, void *user_data)
    cdef struct p4est_iter_corner_side:
        p4est_topidx_t treeid
        int8_t corner
        int8_t is_ghost
        p4est_quadrant_t *quad
        p4est_locidx_t quadid
    ctypedef p4est_iter_corner_side p4est_iter_corner_side_t
    cdef struct p4est_iter_corner_info:
        p4est_t *p4est
        p4est_ghost_t *ghost_layer
        int8_t tree_boundary
        sc_array_t sides
    ctypedef p4est_iter_corner_info p4est_iter_corner_info_t
    ctypedef void (*p4est_iter_corner_t) (p4est_iter_corner_info_t * info, void *user_data)
    void p4est_iterate (p4est_t * p4est, p4est_ghost_t * ghost_layer, void *user_data, p4est_iter_volume_t iter_volume, p4est_iter_face_t iter_face, p4est_iter_corner_t iter_corner)
    p4est_iter_corner_side_t * p4est_iter_cside_array_index_int (sc_array_t * array, int it)
    p4est_iter_corner_side_t * p4est_iter_cside_array_index (sc_array_t * array, size_t it)
    p4est_iter_face_side_t * p4est_iter_fside_array_index_int (sc_array_t * array, int it)
    p4est_iter_face_side_t * p4est_iter_fside_array_index (sc_array_t * array, size_t it)
    SC_EXTERN_C_END
