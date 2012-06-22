from _c_p8est cimport *
from _c_p8est_ghost cimport *

cdef extern from "p8est_nodes.h" nogil:
    enum: P8EST_NODES_H

    SC_EXTERN_C_BEGIN
    cdef struct _struct_piggy1:
        p4est_topidx_t which_tree
        int owner_rank
    cdef struct _struct_piggy_unused2:
        p4est_topidx_t which_tree
        p4est_topidx_t from_tree
    cdef struct _struct_piggy3:
        p4est_topidx_t which_tree
        p4est_locidx_t local_num
    cdef union p4est_indep_data:
        void *unused
        p4est_topidx_t which_tree
        _struct_piggy1 piggy1
        _struct_piggy_unused2 piggy_unused2
        _struct_piggy3 piggy3
    cdef struct p8est_indep:
        p4est_qcoord_t x, y, z
        int8_t level, pad8
        int16_t pad16
        p4est_indep_data p
    ctypedef p8est_indep p8est_indep_t
    cdef struct _struct_piggy_unused1:
        p4est_topidx_t which_tree
        int owner_rank
    cdef struct _struct_piggy_unused2:
        p4est_topidx_t which_tree
        p4est_topidx_t from_tree
    cdef struct _struct_piggy_unused3:
        p4est_topidx_t which_tree
        p4est_locidx_t local_num
    cdef struct _struct_piggy:
        p4est_topidx_t which_tree
        p4est_locidx_t depends[2]
    cdef union p8est_hang2_data:
        void *unused
        p4est_topidx_t which_tree
        _struct_piggy_unused1 piggy_unused1
        _struct_piggy_unused2 piggy_unused2
        _struct_piggy_unused3 piggy_unused3
        _struct_piggy piggy
    cdef struct p8est_hang2:
        p4est_qcoord_t x, y, z
        int8_t level, pad8
        int16_t pad16
        p8est_hang2_data p
    ctypedef p8est_hang2 p8est_hang2_t
    cdef struct _struct_piggy_unused1:
        p4est_topidx_t which_tree
        int owner_rank
    cdef struct _struct_piggy_unused2:
        p4est_topidx_t which_tree
        p4est_topidx_t from_tree
    cdef struct _struct_piggy_unused3:
        p4est_topidx_t which_tree
        p4est_locidx_t local_num
    cdef struct _struct_piggy:
        p4est_topidx_t which_tree
        p4est_locidx_t depends[4]
    cdef union p8est_hang4_data:
        void *unused
        p4est_topidx_t which_tree
        _struct_piggy_unused1 piggy_unused1
        _struct_piggy_unused2 piggy_unused2
        _struct_piggy_unused3 piggy_unused3
        _struct_piggy piggy
    cdef struct p8est_hang4:
        p4est_qcoord_t x, y, z
        int8_t level, pad8
        int16_t pad16
        p8est_hang4_data p
    ctypedef p8est_hang4 p8est_hang4_t
    cdef struct p8est_nodes:
        p4est_locidx_t num_local_quadrants
        p4est_locidx_t num_owned_indeps, num_owned_shared
        p4est_locidx_t offset_owned_indeps
        sc_array_t indep_nodes
        sc_array_t face_hangings
        sc_array_t edge_hangings
        p4est_locidx_t *local_nodes
        sc_array_t shared_indeps
        p4est_locidx_t *shared_offsets
        int *nonlocal_ranks
        p4est_locidx_t *global_owned_indeps
    ctypedef p8est_nodes p8est_nodes_t
    p8est_nodes_t *p8est_nodes_new (p8est_t * p8est, p8est_ghost_t * ghost)
    void p8est_nodes_destroy (p8est_nodes_t * nodes)
    int p8est_nodes_is_valid (p8est_t * p8est, p8est_nodes_t * nodes)
    SC_EXTERN_C_END
