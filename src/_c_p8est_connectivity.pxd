from _c_sc_io cimport *
from _c_p4est_base cimport *

cdef extern from "p8est_connectivity.h" nogil:
    enum: P8EST_CONNECTIVITY_H
    enum: P8EST_DIM
    enum: P8EST_FACES
    enum: P8EST_CHILDREN
    enum: P8EST_HALF
    enum: P8EST_EDGES
    enum: P8EST_INSUL
    enum: P8EST_FTRANSFORM
    enum: P8EST_STRING
    enum: P8EST_ONDISK_FORMAT
    enum: P8EST_BALANCE_FACE
    enum: P8EST_BALANCE_EDGE
    enum: P8EST_BALANCE_CORNER
    enum: P8EST_BALANCE_DEFAULT
    enum: P8EST_BALANCE_FULL
    enum: p8est_balance_type_t

    SC_EXTERN_C_BEGIN
    enum p8est_connect_type_t:
        P8EST_CONNECT_FACE = 31
        P8EST_CONNECT_EDGE = 32
        P8EST_CONNECT_CORNER = 33
        P8EST_CONNECT_DEFAULT = P8EST_CONNECT_EDGE
        P8EST_CONNECT_FULL = P8EST_CONNECT_CORNER 
    enum p8est_connectivity_encode_t:
        P8EST_CONN_ENCODE_NONE = SC_IO_ENCODE_NONE
        P8EST_CONN_ENCODE_LAST 
    int p8est_connect_type_int (p8est_connect_type_t btype)
    char *p8est_connect_type_string (p8est_connect_type_t btype)
    cdef struct p8est_connectivity:
        p4est_topidx_t num_vertices
        p4est_topidx_t num_trees
        p4est_topidx_t num_edges
        p4est_topidx_t num_corners
        double *vertices
        p4est_topidx_t *tree_to_vertex
        int8_t *tree_to_attr
        p4est_topidx_t *tree_to_tree
        int8_t *tree_to_face
        p4est_topidx_t *tree_to_edge
        p4est_topidx_t *ett_offset
        p4est_topidx_t *edge_to_tree
        int8_t *edge_to_edge
        p4est_topidx_t *tree_to_corner
        p4est_topidx_t *ctt_offset
        p4est_topidx_t *corner_to_tree
        int8_t *corner_to_corner
    ctypedef p8est_connectivity p8est_connectivity_t
    size_t p8est_connectivity_memory_used (p8est_connectivity_t * conn)
    ctypedef struct p8est_edge_transform_t:
        p4est_topidx_t ntree
        int8_t nedge, naxis[3], nflip, corners
    ctypedef struct p8est_edge_info_t:
        int8_t iedge
        sc_array_t edge_transforms
    ctypedef struct p8est_corner_transform_t:
        p4est_topidx_t ntree
        int8_t ncorner
    ctypedef struct p8est_corner_info_t:
        p4est_topidx_t icorner
        sc_array_t corner_transforms
    int p8est_face_corners[6][4]
    int p8est_face_edges[6][4]
    int p8est_face_dual[6]
    int p8est_face_permutations[8][4]
    int p8est_face_permutation_sets[3][4]
    int p8est_face_permutation_refs[6][6]
    int p8est_edge_faces[12][2]
    int p8est_edge_corners[12][2]
    int p8est_edge_face_corners[12][6][2]
    int p8est_corner_faces[8][3]
    int p8est_corner_edges[8][3]
    int p8est_corner_face_corners[8][6]
    int p8est_child_edge_faces[8][12]
    int p8est_child_corner_faces[8][8]
    int p8est_child_corner_edges[8][8]
    p8est_connectivity_t *p8est_connectivity_new (p4est_topidx_t num_vertices, p4est_topidx_t num_trees, p4est_topidx_t num_edges, p4est_topidx_t num_ett, p4est_topidx_t num_corners, p4est_topidx_t num_ctt)
    p8est_connectivity_t *p8est_connectivity_new_copy (p4est_topidx_t num_vertices, p4est_topidx_t num_trees, p4est_topidx_t num_edges, p4est_topidx_t num_corners, double *vertices, p4est_topidx_t * ttv, p4est_topidx_t * ttt, int8_t * ttf, p4est_topidx_t * tte, p4est_topidx_t * eoff, p4est_topidx_t * ett, int8_t * ete, p4est_topidx_t * ttc, p4est_topidx_t * coff, p4est_topidx_t * ctt, int8_t * ctc)
    void p8est_connectivity_destroy (p8est_connectivity_t * connectivity)
    void p8est_connectivity_set_attr (p8est_connectivity_t * conn, int enable_tree_attr)
    int p8est_connectivity_is_valid (p8est_connectivity_t * connectivity)
    int p8est_connectivity_is_equal (p8est_connectivity_t * conn1, p8est_connectivity_t * conn2)
    int p8est_connectivity_sink (p8est_connectivity_t * conn, sc_io_sink_t * sink)
    sc_array_t *p8est_connectivity_deflate (p8est_connectivity_t * conn, p8est_connectivity_encode_t code)
    int p8est_connectivity_save (char *filename, p8est_connectivity_t * connectivity)
    p8est_connectivity_t *p8est_connectivity_source (sc_io_source_t * source)
    p8est_connectivity_t *p8est_connectivity_inflate (sc_array_t * buffer)
    p8est_connectivity_t *p8est_connectivity_load (char *filename, size_t * bytes)
    p8est_connectivity_t *p8est_connectivity_new_unitcube ()
    p8est_connectivity_t *p8est_connectivity_new_periodic ()
    p8est_connectivity_t *p8est_connectivity_new_rotwrap ()
    p8est_connectivity_t *p8est_connectivity_new_twocubes ()
    p8est_connectivity_t *p8est_connectivity_new_twowrap ()
    p8est_connectivity_t *p8est_connectivity_new_rotcubes ()
    p8est_connectivity_t *p8est_connectivity_new_brick (int m, int n, int p, int periodic_a, int periodic_b, int periodic_c)
    p8est_connectivity_t *p8est_connectivity_new_shell ()
    p8est_connectivity_t *p8est_connectivity_new_sphere ()
    p4est_topidx_t p8est_find_face_transform (p8est_connectivity_t * connectivity, p4est_topidx_t itree, int iface, int ftransform[])
    void p8est_find_edge_transform (p8est_connectivity_t * connectivity, p4est_topidx_t itree, int iedge, p8est_edge_info_t * ei)
    void p8est_find_corner_transform (p8est_connectivity_t * connectivity, p4est_topidx_t itree, int icorner, p8est_corner_info_t * ci)
    void p8est_connectivity_complete (p8est_connectivity_t * conn)
    void p8est_connectivity_permute (p8est_connectivity_t * conn, sc_array_t * perm, int is_current_to_new)
    void p8est_connectivity_reorder (MPI_Comm comm, int k, p8est_connectivity_t * conn, p8est_connect_type_t ctype)
    p8est_edge_transform_t * p8est_edge_array_index (sc_array_t * array, size_t it)
    p8est_corner_transform_t * p8est_corner_array_index (sc_array_t * array, size_t it)
    SC_EXTERN_C_END
