from _c_sc_io cimport *
from _c_p4est_base cimport *

cdef extern from "p4est_connectivity.h" nogil:
    enum: P4EST_CONNECTIVITY_H
    enum: P4EST_DIM
    enum: P4EST_FACES
    enum: P4EST_CHILDREN
    enum: P4EST_HALF
    enum: P4EST_INSUL
    enum: P4EST_FTRANSFORM
    enum: P4EST_STRING
    enum: P4EST_ONDISK_FORMAT
    enum: P4EST_BALANCE_FACE
    enum: P4EST_BALANCE_CORNER
    enum: P4EST_BALANCE_DEFAULT
    enum: P4EST_BALANCE_FULL
    enum: p4est_balance_type_t

    SC_EXTERN_C_BEGIN
    enum p4est_connect_type_t:
        P4EST_CONNECT_FACE = 21
        P4EST_CONNECT_CORNER = 22
        P4EST_CONNECT_DEFAULT = P4EST_CONNECT_CORNER
        P4EST_CONNECT_FULL = P4EST_CONNECT_CORNER 
    enum p4est_connectivity_encode_t:
        P4EST_CONN_ENCODE_NONE = SC_IO_ENCODE_NONE
        P4EST_CONN_ENCODE_LAST 
    int p4est_connect_type_int (p4est_connect_type_t btype)
    char *p4est_connect_type_string (p4est_connect_type_t btype)
    cdef struct p4est_connectivity:
        p4est_topidx_t num_vertices
        p4est_topidx_t num_trees
        p4est_topidx_t num_corners
        double *vertices
        p4est_topidx_t *tree_to_vertex
        int8_t *tree_to_attr
        p4est_topidx_t *tree_to_tree
        int8_t *tree_to_face
        p4est_topidx_t *tree_to_corner
        p4est_topidx_t *ctt_offset
        p4est_topidx_t *corner_to_tree
        int8_t *corner_to_corner
    ctypedef p4est_connectivity p4est_connectivity_t
    size_t p4est_connectivity_memory_used (p4est_connectivity_t * conn)
    ctypedef struct p4est_corner_transform_t:
        p4est_topidx_t ntree
        int8_t ncorner
    ctypedef struct p4est_corner_info_t:
        p4est_topidx_t icorner
        sc_array_t corner_transforms
    int p4est_face_corners[4][2]
    int p4est_face_dual[4]
    int p4est_corner_faces[4][2]
    int p4est_corner_face_corners[4][4]
    int p4est_child_corner_faces[4][4]
    p4est_connectivity_t *p4est_connectivity_new (p4est_topidx_t num_vertices, p4est_topidx_t num_trees, p4est_topidx_t num_corners, p4est_topidx_t num_ctt)
    p4est_connectivity_t *p4est_connectivity_new_copy (p4est_topidx_t num_vertices, p4est_topidx_t num_trees, p4est_topidx_t num_corners, double *vertices, p4est_topidx_t * ttv, p4est_topidx_t * ttt, int8_t * ttf, p4est_topidx_t * ttc, p4est_topidx_t * coff, p4est_topidx_t * ctt, int8_t * ctc)
    void p4est_connectivity_destroy (p4est_connectivity_t * connectivity)
    void p4est_connectivity_set_attr (p4est_connectivity_t * conn, int enable_tree_attr)
    int p4est_connectivity_is_valid (p4est_connectivity_t * connectivity)
    int p4est_connectivity_is_equal (p4est_connectivity_t * conn1, p4est_connectivity_t * conn2)
    int p4est_connectivity_sink (p4est_connectivity_t * conn, sc_io_sink_t * sink)
    sc_array_t *p4est_connectivity_deflate (p4est_connectivity_t * conn, p4est_connectivity_encode_t code)
    int p4est_connectivity_save (char *filename, p4est_connectivity_t * connectivity)
    p4est_connectivity_t *p4est_connectivity_source (sc_io_source_t * source)
    p4est_connectivity_t *p4est_connectivity_inflate (sc_array_t * buffer)
    p4est_connectivity_t *p4est_connectivity_load (char *filename, size_t * bytes)
    p4est_connectivity_t *p4est_connectivity_new_unitsquare ()
    p4est_connectivity_t *p4est_connectivity_new_periodic ()
    p4est_connectivity_t *p4est_connectivity_new_rotwrap ()
    p4est_connectivity_t *p4est_connectivity_new_corner ()
    p4est_connectivity_t *p4est_connectivity_new_moebius ()
    p4est_connectivity_t *p4est_connectivity_new_star ()
    p4est_connectivity_t *p4est_connectivity_new_brick (int mi, int ni, int periodic_a, int periodic_b)
    p4est_topidx_t p4est_find_face_transform (p4est_connectivity_t * connectivity, p4est_topidx_t itree, int iface, int ftransform[])
    void p4est_find_corner_transform (p4est_connectivity_t * connectivity, p4est_topidx_t itree, int icorner, p4est_corner_info_t * ci)
    void p4est_connectivity_complete (p4est_connectivity_t * conn)
    void p4est_connectivity_permute (p4est_connectivity_t * conn, sc_array_t * perm, int is_current_to_new)
    void p4est_connectivity_reorder (MPI_Comm comm, int k, p4est_connectivity_t * conn, p4est_connect_type_t ctype)
    p4est_corner_transform_t * p4est_corner_array_index (sc_array_t * array, size_t it)
    SC_EXTERN_C_END
