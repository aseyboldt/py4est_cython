from _c_p8est cimport *
from _c_p8est_ghost cimport *

cdef extern from "p8est_iterate.h" nogil:
    enum: P8EST_ITERATE_H

    SC_EXTERN_C_BEGIN
    cdef struct p8est_iter_volume_info:
        p8est_t *p4est
        p8est_ghost_t *ghost_layer
        p8est_quadrant_t *quad
        p4est_locidx_t quadid
        p4est_topidx_t treeid
    ctypedef p8est_iter_volume_info p8est_iter_volume_info_t
    ctypedef void (*p8est_iter_volume_t) (p8est_iter_volume_info_t * info, void *user_data)
    cdef struct _struct_full:
        int8_t is_ghost
        p8est_quadrant_t *quad
        p4est_locidx_t quadid
    cdef struct _struct_hanging:
        int8_t is_ghost[4]
        p8est_quadrant_t *quad[4]
        p4est_locidx_t quadid[4]
    cdef union p8est_iter_face_side_data:
        _struct_full full
        _struct_hanging hanging
    cdef struct p8est_iter_face_side:
        p4est_topidx_t treeid
        int8_t face
        int8_t is_hanging
        p8est_iter_face_side_data is
    ctypedef p8est_iter_face_side p8est_iter_face_side_t
    cdef struct p8est_iter_face_info:
        p8est_t *p4est
        p8est_ghost_t *ghost_layer
        int8_t orientation
        int8_t tree_boundary
        sc_array_t sides
    ctypedef p8est_iter_face_info p8est_iter_face_info_t
    ctypedef void (*p8est_iter_face_t) (p8est_iter_face_info_t * info, void *user_data)
    cdef struct _struct_full:
        int8_t is_ghost
        p8est_quadrant_t *quad
        p4est_locidx_t quadid
    cdef struct _struct_hanging:
        int8_t is_ghost[2]
        p8est_quadrant_t *quad[2]
        p4est_locidx_t quadid[2]
    cdef union p8est_iter_edge_side_data:
        _struct_full full
        _struct_hanging hanging
    cdef struct p8est_iter_edge_side:
        p4est_topidx_t treeid
        int8_t edge
        int8_t orientation
        int8_t is_hanging
        p8est_iter_edge_side_data is
    ctypedef p8est_iter_edge_side p8est_iter_edge_side_t
    cdef struct p8est_iter_edge_info:
        p8est_t *p4est
        p8est_ghost_t *ghost_layer
        int8_t tree_boundary
        sc_array_t sides
    ctypedef p8est_iter_edge_info p8est_iter_edge_info_t
    ctypedef void (*p8est_iter_edge_t) (p8est_iter_edge_info_t * info, void *user_data)
    cdef struct p8est_iter_corner_side:
        p4est_topidx_t treeid
        int8_t corner
        int8_t is_ghost
        p8est_quadrant_t *quad
        p4est_locidx_t quadid
    ctypedef p8est_iter_corner_side p8est_iter_corner_side_t
    cdef struct p8est_iter_corner_info:
        p8est_t *p4est
        p8est_ghost_t *ghost_layer
        int8_t tree_boundary
        sc_array_t sides
    ctypedef p8est_iter_corner_info p8est_iter_corner_info_t
    ctypedef void (*p8est_iter_corner_t) (p8est_iter_corner_info_t * info, void *user_data)
    void p8est_iterate (p8est_t * p4est, p8est_ghost_t * ghost_layer, void *user_data, p8est_iter_volume_t iter_volume, p8est_iter_face_t iter_face, p8est_iter_edge_t iter_edge, p8est_iter_corner_t iter_corner)
    p8est_iter_corner_side_t * p8est_iter_cside_array_index_int (sc_array_t * array, int it)
    p8est_iter_corner_side_t * p8est_iter_cside_array_index (sc_array_t * array, size_t it)
    p8est_iter_edge_side_t * p8est_iter_eside_array_index_int (sc_array_t * array, int it)
    p8est_iter_edge_side_t * p8est_iter_eside_array_index (sc_array_t * array, size_t it)
    p8est_iter_face_side_t * p8est_iter_fside_array_index_int (sc_array_t * array, int it)
    p8est_iter_face_side_t * p8est_iter_fside_array_index (sc_array_t * array, size_t it)
    SC_EXTERN_C_END
