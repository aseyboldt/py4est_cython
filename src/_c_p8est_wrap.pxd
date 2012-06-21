from _c_p8est_mesh cimport *

cdef extern from "p8est_wrap.h" nogil:

    SC_EXTERN_C_BEGIN
    enum p8est_wrap_flags_t:
        P8EST_WRAP_REFINE = 1
        P8EST_WRAP_COARSEN = 2 
    cdef struct p8est_wrap:
        int p4est_dim
        int p4est_half
        int p4est_faces
        int p4est_children
        p8est_connectivity_t *conn
        p8est_t *p4est
        int8_t *flags
        p8est_ghost_t *ghost
        p8est_mesh_t *mesh
        p8est_ghost_t *ghost_aux
        p8est_mesh_t *mesh_aux
        int match_aux
    ctypedef p8est_wrap p8est_wrap_t
    void p8est_wrap_init ()
    void p8est_wrap_finalize ()
    p8est_wrap_t *p8est_wrap_new (int initial_level)
    void p8est_wrap_destroy (p8est_wrap_t * pp)
    void p8est_wrap_refine (p8est_wrap_t * pp)
    void p8est_wrap_partition (p8est_wrap_t * pp)
    void p8est_wrap_complete (p8est_wrap_t * pp)
    cdef struct p8est_wrap_leaf:
        p8est_wrap_t *pp
        int level
        p4est_topidx_t which_tree
        p4est_locidx_t which_quad
        p4est_locidx_t total_quad
        p8est_tree_t *tree
        p8est_quadrant_t *quad
        double lowerleft[3]
        double upperright[3]
    ctypedef p8est_wrap_leaf p8est_wrap_leaf_t
    p8est_wrap_leaf_t *p8est_wrap_leaf_first (p8est_wrap_t * pp)
    p8est_wrap_leaf_t *p8est_wrap_leaf_next (p8est_wrap_leaf_t * leaf)
    SC_EXTERN_C_END
