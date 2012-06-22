from _c_p4est_mesh cimport *

cdef extern from "p4est_wrap.h" nogil:

    SC_EXTERN_C_BEGIN
    enum p4est_wrap_flags_t:
        P4EST_WRAP_REFINE = 1
        P4EST_WRAP_COARSEN = 2 
    cdef struct p4est_wrap:
        int p4est_dim
        int p4est_half
        int p4est_faces
        int p4est_children
        p4est_connectivity_t *conn
        p4est_t *p4est
        int8_t *flags
        p4est_ghost_t *ghost
        p4est_mesh_t *mesh
        p4est_ghost_t *ghost_aux
        p4est_mesh_t *mesh_aux
        int match_aux
    ctypedef p4est_wrap p4est_wrap_t
    void p4est_wrap_init ()
    void p4est_wrap_finalize ()
    p4est_wrap_t *p4est_wrap_new (int initial_level)
    void p4est_wrap_destroy (p4est_wrap_t * pp)
    void p4est_wrap_refine (p4est_wrap_t * pp)
    void p4est_wrap_partition (p4est_wrap_t * pp)
    void p4est_wrap_complete (p4est_wrap_t * pp)
    cdef struct p4est_wrap_leaf:
        p4est_wrap_t *pp
        int level
        p4est_topidx_t which_tree
        p4est_locidx_t which_quad
        p4est_locidx_t total_quad
        p4est_tree_t *tree
        p4est_quadrant_t *quad
        double lowerleft[3]
        double upperright[3]
    ctypedef p4est_wrap_leaf p4est_wrap_leaf_t
    p4est_wrap_leaf_t *p4est_wrap_leaf_first (p4est_wrap_t * pp)
    p4est_wrap_leaf_t *p4est_wrap_leaf_next (p4est_wrap_leaf_t * leaf)
    SC_EXTERN_C_END
