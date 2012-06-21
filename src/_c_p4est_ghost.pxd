from _c_p4est cimport *

cdef extern from "p4est_ghost.h" nogil:
    enum: P4EST_GHOST_H

    ctypedef struct p4est_ghost_t:
        int mpisize
        p4est_topidx_t num_trees
        sc_array_t ghosts
        p4est_locidx_t *tree_offsets
        p4est_locidx_t *proc_offsets
    size_t p4est_ghost_memory_used (p4est_ghost_t * ghost)
    int p4est_quadrant_find_owner (p4est_t * p4est, p4est_topidx_t treeid, int face, p4est_quadrant_t * q)
    p4est_ghost_t *p4est_ghost_new (p4est_t * p4est, p4est_connect_type_t btype)
    void p4est_ghost_destroy (p4est_ghost_t * ghost)
    ssize_t p4est_ghost_tree_bsearch (p4est_ghost_t * ghost, p4est_topidx_t which_tree, p4est_quadrant_t * q)
    p4est_locidx_t p4est_face_quadrant_exists (p4est_t * p4est, p4est_ghost_t * ghost, p4est_topidx_t treeid, p4est_quadrant_t * q, int *face, int *hang, int *owner_rank)
    int p4est_quadrant_exists (p4est_t * p4est, p4est_ghost_t * ghost, p4est_topidx_t treeid, p4est_quadrant_t * q, sc_array_t * exists_arr)
    int p4est_is_balanced (p4est_t * p4est, p4est_connect_type_t btype)
    unsigned p4est_ghost_checksum (p4est_t * p4est, p4est_ghost_t * ghost)

