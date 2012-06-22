from _c_p8est cimport *
from _c_p8est_ghost cimport *

cdef extern from "p8est_lnodes.h" nogil:
    enum: P8EST_LNODES_H

    SC_EXTERN_C_BEGIN
    ctypedef int16_t p8est_lnodes_code_t
    cdef struct p8est_lnodes:
        int degree, vnodes
        p4est_locidx_t num_local_elements
        p4est_locidx_t num_indep_nodes
        p4est_locidx_t owned_offset, owned_count
        p8est_lnodes_code_t *face_code
        p4est_locidx_t *local_nodes
        p4est_gloidx_t *global_nodes
        p4est_locidx_t *global_owned_count
        sc_array_t *sharers
    ctypedef p8est_lnodes p8est_lnodes_t
    cdef struct p8est_lnodes_rank:
        int rank
        sc_array_t shared_nodes
        p4est_locidx_t shared_mine_offset, shared_mine_count
        p4est_locidx_t owned_offset, owned_count
    ctypedef p8est_lnodes_rank p8est_lnodes_rank_t
    int p8est_lnodes_decode (p8est_lnodes_code_t face_code, int hanging_face[6], int hanging_edge[12])
    p8est_lnodes_t *p8est_lnodes_new (p8est_t * p8est, p8est_ghost_t * ghost_layer, int degree)
    void p8est_lnodes_destroy (p8est_lnodes_t *)
    cdef struct p8est_lnodes_buffer:
        sc_array_t *requests
        sc_array_t *send_buffers
        sc_array_t *recv_buffers
    ctypedef p8est_lnodes_buffer p8est_lnodes_buffer_t
    p8est_lnodes_buffer_t *p8est_lnodes_share_owned_begin (sc_array_t * node_data, p8est_lnodes_t * lnodes, p8est_t * p8est)
    void p8est_lnodes_share_owned_end (p8est_lnodes_buffer_t * buffer)
    void p8est_lnodes_share_owned (sc_array_t * node_data, p8est_lnodes_t * lnodes, p8est_t * p8est)
    p8est_lnodes_buffer_t *p8est_lnodes_share_all_begin (sc_array_t * node_data, p8est_lnodes_t * lnodes, p8est_t * p8est)
    void p8est_lnodes_share_all_end (p8est_lnodes_buffer_t * buffer)
    p8est_lnodes_buffer_t *p8est_lnodes_share_all (sc_array_t * node_data, p8est_lnodes_t * lnodes, p8est_t * p8est)
    void p8est_lnodes_buffer_destroy (p8est_lnodes_buffer_t * buffer)
    p8est_lnodes_rank_t * p8est_lnodes_rank_array_index_int (sc_array_t * array, int it)
    p8est_lnodes_rank_t * p8est_lnodes_rank_array_index (sc_array_t * array, size_t it)
    SC_EXTERN_C_END
