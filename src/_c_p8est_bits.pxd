from _c_p8est cimport *

cdef extern from "p8est_bits.h" nogil:
    enum: P8EST_BITS_H

    SC_EXTERN_C_BEGIN
    void p8est_quadrant_print (int log_priority, p8est_quadrant_t * q)
    int p8est_quadrant_is_equal (p8est_quadrant_t * q1, p8est_quadrant_t * q2)
    int p8est_quadrant_overlaps (p8est_quadrant_t * q1, p8est_quadrant_t * q2)
    int p8est_quadrant_is_equal_piggy (p8est_quadrant_t * q1, p8est_quadrant_t * q2)
    int p8est_quadrant_compare (void *v1, void *v2)
    int p8est_quadrant_disjoint (void *v1, void *v2)
    int p8est_quadrant_compare_piggy (void *v1, void *v2)
    int p8est_quadrant_equal_fn (void *v1, void *v2, void *u)
    unsigned p8est_quadrant_hash_fn (void *v, void *u)
    int p8est_node_equal_piggy_fn (void *v1, void *v2, void *u)
    unsigned p8est_node_hash_piggy_fn (void *v, void *u)
    void p8est_node_clamp_inside (p8est_quadrant_t * n, p8est_quadrant_t * r)
    void p8est_node_unclamp (p8est_quadrant_t * n)
    void p8est_node_to_quadrant (p8est_quadrant_t * n, int level, p8est_quadrant_t * q)
    int p8est_quadrant_contains_node (p8est_quadrant_t * q, p8est_quadrant_t * n)
    int p8est_quadrant_ancestor_id (p8est_quadrant_t * q, int level)
    int p8est_quadrant_child_id (p8est_quadrant_t * q)
    int p8est_quadrant_is_inside_root (p8est_quadrant_t * q)
    int p8est_quadrant_is_inside_3x3 (p8est_quadrant_t * q)
    int p8est_quadrant_is_outside_face (p8est_quadrant_t * q)
    int p8est_quadrant_is_outside_edge (p8est_quadrant_t * q)
    int p8est_quadrant_is_outside_edge_extra (p8est_quadrant_t * q, int *edge)
    int p8est_quadrant_is_outside_corner (p8est_quadrant_t * q)
    int p8est_quadrant_is_node (p8est_quadrant_t * q, int inside)
    int p8est_quadrant_is_valid (p8est_quadrant_t * q)
    int p8est_quadrant_is_extended (p8est_quadrant_t * q)
    int p8est_quadrant_is_sibling (p8est_quadrant_t * q1, p8est_quadrant_t * q2)
    int p8est_quadrant_is_sibling_D (p8est_quadrant_t * q1, p8est_quadrant_t * q2)
    int p8est_quadrant_is_family (p8est_quadrant_t * q0, p8est_quadrant_t * q1, p8est_quadrant_t * q2, p8est_quadrant_t * q3, p8est_quadrant_t * q4, p8est_quadrant_t * q5, p8est_quadrant_t * q6, p8est_quadrant_t * q7)
    int p8est_quadrant_is_familyv (p8est_quadrant_t q[])
    int p8est_quadrant_is_familypv (p8est_quadrant_t * q[])
    int p8est_quadrant_is_parent (p8est_quadrant_t * q, p8est_quadrant_t * r)
    int p8est_quadrant_is_parent_D (p8est_quadrant_t * q, p8est_quadrant_t * r)
    int p8est_quadrant_is_ancestor (p8est_quadrant_t * q, p8est_quadrant_t * r)
    int p8est_quadrant_is_ancestor_D (p8est_quadrant_t * q, p8est_quadrant_t * r)
    int p8est_quadrant_is_next (p8est_quadrant_t * q, p8est_quadrant_t * r)
    int p8est_quadrant_is_next_D (p8est_quadrant_t * q, p8est_quadrant_t * r)
    int p8est_quadrant_overlaps_tree (p8est_tree_t * tree, p8est_quadrant_t * q)
    int p8est_quadrant_is_inside_tree (p8est_tree_t * tree, p8est_quadrant_t * q)
    void p8est_quadrant_ancestor (p8est_quadrant_t * q, int level, p8est_quadrant_t * r)
    void p8est_quadrant_parent (p8est_quadrant_t * q, p8est_quadrant_t * r)
    void p8est_quadrant_sibling (p8est_quadrant_t * q, p8est_quadrant_t * r, int sibling_id)
    void p8est_quadrant_face_neighbor (p8est_quadrant_t * q, int face, p8est_quadrant_t * r)
    p4est_locidx_t p8est_quadrant_face_neighbor_extra (p8est_quadrant_t * q, p4est_locidx_t t, int face, p8est_quadrant_t * r, p8est_connectivity_t * conn)
    void p8est_quadrant_half_face_neighbors (p8est_quadrant_t * q, int face, p8est_quadrant_t n[], p8est_quadrant_t nur[])
    void p8est_quadrant_all_face_neighbors (p8est_quadrant_t * q, int face, p8est_quadrant_t n[])
    void p8est_quadrant_edge_neighbor (p8est_quadrant_t * q, int edge, p8est_quadrant_t * r)
    void p8est_quadrant_edge_neighbor_extra (p8est_quadrant_t * q, p4est_locidx_t t, int edge, sc_array_t * quads, sc_array_t * treeids, p8est_connectivity_t * conn)
    void p8est_quadrant_corner_neighbor (p8est_quadrant_t * q, int corner, p8est_quadrant_t * r)
    void p8est_quadrant_corner_neighbor_extra (p8est_quadrant_t * q, p4est_locidx_t t, int corner, sc_array_t * quads, sc_array_t * treeids, p8est_connectivity_t * conn)
    void p8est_quadrant_corner_node (p8est_quadrant_t * q, int corner, p8est_quadrant_t * r)
    void p8est_quadrant_children (p8est_quadrant_t * q, p8est_quadrant_t * c0, p8est_quadrant_t * c1, p8est_quadrant_t * c2, p8est_quadrant_t * c3, p8est_quadrant_t * c4, p8est_quadrant_t * c5, p8est_quadrant_t * c6, p8est_quadrant_t * c7)
    void p8est_quadrant_childrenv (p8est_quadrant_t * q, p8est_quadrant_t c[])
    void p8est_quadrant_childrenpv (p8est_quadrant_t * q, p8est_quadrant_t * c[])
    void p8est_quadrant_first_descendant (p8est_quadrant_t * q, p8est_quadrant_t * fd, int level)
    void p8est_quadrant_last_descendant (p8est_quadrant_t * q, p8est_quadrant_t * ld, int level)
    void p8est_quadrant_corner_descendant (p8est_quadrant_t * q, p8est_quadrant_t * r, int c, int level)
    void p8est_nearest_common_ancestor (p8est_quadrant_t * q1, p8est_quadrant_t * q2, p8est_quadrant_t * r)
    void p8est_nearest_common_ancestor_D (p8est_quadrant_t * q1, p8est_quadrant_t * q2, p8est_quadrant_t * r)
    void p8est_quadrant_transform_face (p8est_quadrant_t * q, p8est_quadrant_t * r, int ftransform[])
    int p8est_quadrant_touches_edge (p8est_quadrant_t * q, int edge, int inside)
    void p8est_quadrant_transform_edge (p8est_quadrant_t * q, p8est_quadrant_t * r, p8est_edge_info_t * ei, p8est_edge_transform_t * et, int inside)
    void p8est_quadrant_shift_edge (p8est_quadrant_t * q, p8est_quadrant_t * r, p8est_quadrant_t * rup, p8est_quadrant_t * rdown, int edge)
    int p8est_quadrant_touches_corner (p8est_quadrant_t * q, int corner, int inside)
    void p8est_quadrant_transform_corner (p8est_quadrant_t * r, int corner, int inside)
    void p8est_quadrant_shift_corner (p8est_quadrant_t * q, p8est_quadrant_t * r, int corner)
    uint64_t p8est_quadrant_linear_id (p8est_quadrant_t * quadrant, int level)
    void p8est_quadrant_set_morton (p8est_quadrant_t * quadrant, int level, uint64_t id)
    SC_EXTERN_C_END