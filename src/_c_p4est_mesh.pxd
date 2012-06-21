from _c_p4est_ghost cimport *

cdef extern from "p4est_mesh.h" nogil:
    enum: P4EST_MESH_H

    SC_EXTERN_C_BEGIN
    ctypedef struct p4est_mesh_t:
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
    ctypedef struct p4est_mesh_face_neighbor_t:
        p4est_t *p4est
        p4est_ghost_t *ghost
        p4est_mesh_t *mesh
        p4est_topidx_t which_tree
        p4est_locidx_t quadrant_id
        p4est_locidx_t quadrant_code
        int face
        int subface
    size_t p4est_mesh_memory_used (p4est_mesh_t * mesh)
    p4est_mesh_t *p4est_mesh_new (p4est_t * p4est, p4est_ghost_t * ghost, p4est_connect_type_t btype)
    void p4est_mesh_destroy (p4est_mesh_t * mesh)
    p4est_quadrant_t *p4est_mesh_quadrant_cumulative (p4est_t * p4est, p4est_locidx_t cumulative_id, p4est_topidx_t * which_tree, p4est_locidx_t * quadrant_id)
    void p4est_mesh_face_neighbor_init2 (p4est_mesh_face_neighbor_t * mfn, p4est_t * p4est, p4est_ghost_t * ghost, p4est_mesh_t * mesh, p4est_topidx_t which_tree, p4est_locidx_t quadrant_id)
    void p4est_mesh_face_neighbor_init (p4est_mesh_face_neighbor_t * mfn, p4est_t * p4est, p4est_ghost_t * ghost, p4est_mesh_t * mesh, p4est_topidx_t which_tree, p4est_quadrant_t * quadrant)
    p4est_quadrant_t *p4est_mesh_face_neighbor_next (p4est_mesh_face_neighbor_t * mfn, p4est_topidx_t * ntree, p4est_locidx_t * nquad, int *nface, int *nrank)
    SC_EXTERN_C_END
