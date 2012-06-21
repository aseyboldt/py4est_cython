from _c_p8est cimport *

cdef extern from "p8est_ghost.h" nogil:
    enum: P8EST_GHOST_H

    SC_EXTERN_C_BEGIN
    ctypedef struct p8est_ghost_t:
        int mpisize
        p4est_topidx_t num_trees
        sc_array_t ghosts
        p4est_locidx_t *tree_offsets
        p4est_locidx_t *proc_offsets
    size_t p8est_ghost_memory_used (p8est_ghost_t * ghost)
    int p8est_quadrant_find_owner (p8est_t * p8est, p4est_topidx_t treeid, int face, p8est_quadrant_t * q)
    p8est_ghost_t *p8est_ghost_new (p8est_t * p8est, p8est_connect_type_t btype)
    void p8est_ghost_destroy (p8est_ghost_t * ghost)
    ssize_t p8est_ghost_tree_bsearch (p8est_ghost_t * ghost, p4est_topidx_t which_tree, p8est_quadrant_t * q)
    p4est_locidx_t p8est_face_quadrant_exists (p8est_t * p8est, p8est_ghost_t * ghost, p4est_topidx_t treeid, p8est_quadrant_t * q, int *face, int *hang, int *owner_rank)
    int p8est_quadrant_exists (p8est_t * p8est, p8est_ghost_t * ghost, p4est_topidx_t treeid, p8est_quadrant_t * q, sc_array_t * exists_arr)
    int p8est_is_balanced (p8est_t * p8est, p8est_connect_type_t btype)
    unsigned p8est_ghost_checksum (p8est_t * p8est, p8est_ghost_t * ghost)
    SC_EXTERN_C_END
