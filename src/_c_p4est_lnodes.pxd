from _c_p4est cimport *
from _c_p4est_ghost cimport *

cdef extern from "p4est_lnodes.h" nogil:
    enum: P4EST_LNODES_H

    SC_EXTERN_C_BEGIN
    ctypedef int8_t p4est_lnodes_code_t
    cdef struct p4est_lnodes:
        int degree, vnodes
        p4est_locidx_t num_local_elements
        p4est_locidx_t num_indep_nodes
        p4est_locidx_t owned_offset, owned_count
        p4est_lnodes_code_t *face_code
        p4est_locidx_t *local_nodes
        p4est_gloidx_t *global_nodes
        p4est_locidx_t *global_owned_count
        sc_array_t *sharers
    ctypedef p4est_lnodes p4est_lnodes_t
    cdef struct p4est_lnodes_rank:
        int rank
        sc_array_t shared_nodes
        p4est_locidx_t shared_mine_offset, shared_mine_count
        p4est_locidx_t owned_offset, owned_count
    ctypedef p4est_lnodes_rank p4est_lnodes_rank_t
    int p4est_lnodes_decode (p4est_lnodes_code_t face_code, int hanging_face[4])
    p4est_lnodes_t *p4est_lnodes_new (p4est_t * p4est, p4est_ghost_t * ghost_layer, int degree)
    void p4est_lnodes_destroy (p4est_lnodes_t * lnodes)
    cdef struct p4est_lnodes_buffer:
        sc_array_t *requests
        sc_array_t *send_buffers
        sc_array_t *recv_buffers
    ctypedef p4est_lnodes_buffer p4est_lnodes_buffer_t
    p4est_lnodes_buffer_t *p4est_lnodes_share_owned_begin (sc_array_t * node_data, p4est_lnodes_t * lnodes, p4est_t * p4est)
    void p4est_lnodes_share_owned_end (p4est_lnodes_buffer_t * buffer)
    void p4est_lnodes_share_owned (sc_array_t * node_data, p4est_lnodes_t * lnodes, p4est_t * p4est)
    p4est_lnodes_buffer_t *p4est_lnodes_share_all_begin (sc_array_t * node_data, p4est_lnodes_t * lnodes, p4est_t * p4est)
    void p4est_lnodes_share_all_end (p4est_lnodes_buffer_t * buffer)
    p4est_lnodes_buffer_t *p4est_lnodes_share_all (sc_array_t * node_data, p4est_lnodes_t * lnodes, p4est_t * p4est)
    void p4est_lnodes_buffer_destroy (p4est_lnodes_buffer_t * buffer)
    p4est_lnodes_rank_t * p4est_lnodes_rank_array_index_int (sc_array_t * array, int it)
    p4est_lnodes_rank_t * p4est_lnodes_rank_array_index (sc_array_t * array, size_t it)
    SC_EXTERN_C_END
