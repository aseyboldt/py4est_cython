from _c_p8est_ghost cimport *

cdef extern from "p8est_mesh.h" nogil:
    enum: P8EST_MESH_H

    SC_EXTERN_C_BEGIN
    ctypedef struct p8est_mesh_t:
        p4est_locidx_t local_num_vertices
        p4est_locidx_t local_num_quadrants
        p4est_locidx_t ghost_num_quadrants
        double *vertices
        p4est_locidx_t *quad_to_vertex
        int *ghost_to_proc
        p4est_locidx_t *ghost_to_index
        p4est_locidx_t *quad_to_quad
        int8_t *quad_to_face
        sc_array_t *quad_to_half
    ctypedef struct p8est_mesh_face_neighbor_t:
        p8est_t *p4est
        p8est_ghost_t *ghost
        p8est_mesh_t *mesh
        p4est_topidx_t which_tree
        p4est_locidx_t quadrant_id
        p4est_locidx_t quadrant_code
        int face
        int subface
    size_t p8est_mesh_memory_used (p8est_mesh_t * mesh)
    p8est_mesh_t *p8est_mesh_new (p8est_t * p8est, p8est_ghost_t * ghost, p8est_connect_type_t btype)
    void p8est_mesh_destroy (p8est_mesh_t * mesh)
    p8est_quadrant_t *p8est_mesh_quadrant_cumulative (p8est_t * p8est, p4est_locidx_t cumulative_id, p4est_topidx_t * which_tree, p4est_locidx_t * quadrant_id)
    void p8est_mesh_face_neighbor_init2 (p8est_mesh_face_neighbor_t * mfn, p8est_t * p8est, p8est_ghost_t * ghost, p8est_mesh_t * mesh, p4est_topidx_t which_tree, p4est_locidx_t quadrant_id)
    void p8est_mesh_face_neighbor_init (p8est_mesh_face_neighbor_t * mfn, p8est_t * p8est, p8est_ghost_t * ghost, p8est_mesh_t * mesh, p4est_topidx_t which_tree, p8est_quadrant_t * quadrant)
    p8est_quadrant_t *p8est_mesh_face_neighbor_next (p8est_mesh_face_neighbor_t * mfn, p4est_topidx_t * ntree, p4est_locidx_t * nquad, int *nface, int *nrank)
    SC_EXTERN_C_END
