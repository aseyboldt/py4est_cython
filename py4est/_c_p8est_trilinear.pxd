from _c_p8est_nodes cimport *
from _c_p8est_lnodes cimport *
from _c_sc_containers cimport *

cdef extern from "p8est_trilinear.h" nogil:
    enum: P8EST_TRILINEAR_H
    enum: TRILINEAR_MESH_TYPES_H
    enum: OCTOR_TICKT_TYPES

    ctypedef int32_t tick_t
    cdef struct point_t:
        tick_t x, y, z
    ctypedef point_t point_t
    ctypedef int16_t trilinear_mesh_pid_t
    enum trilinear_node_type_t:
        ANCHORED = 0
        DANGLING_ON_XEDGE = -1
        DANGLING_ON_YEDGE = -2
        DANGLING_ON_ZEDGE = -3
        DANGLING_ON_XFACE = -4
        DANGLING_ON_YFACE = -5
        DANGLING_ON_ZFACE = -6 
    cdef struct trilinear_elem_t:
        int32_t local_node_id[8]
        tick_t lx, ly, lz
        tick_t size
        void *data
    ctypedef trilinear_elem_t trilinear_elem_t
    cdef struct int32link_t:
        int32_t id
        int32link_t *next
    ctypedef int32link_t int32link_t
    cdef struct trilinear_anode_t:
        point_t point
        int64_t fvnid
        int32link_t *share
    ctypedef trilinear_anode_t trilinear_anode_t
    cdef struct trilinear_dnode_t:
        point_t point
        int32_t type
        int32_t local_anode_id[4]
    ctypedef trilinear_dnode_t trilinear_dnode_t
    cdef union trilinear_node_t:
        point_t point
        trilinear_anode_t anchored
        trilinear_dnode_t dangling
    ctypedef trilinear_node_t trilinear_node_t
    enum trilinear_boundary_enum_t:
        TRILINEAR_BOUNDARY_NONE = 0
        TRILINEAR_BOUNDARY_IS_LEFT = 0x0001
        TRILINEAR_BOUNDARY_IS_RIGHT = 0x0002
        TRILINEAR_BOUNDARY_IS_FRONT = 0x0004
        TRILINEAR_BOUNDARY_IS_BACK = 0x0008
        TRILINEAR_BOUNDARY_IS_BOTTOM = 0x0010
        TRILINEAR_BOUNDARY_IS_TOP = 0x0020
        TRILINEAR_BOUNDARY_IS_EDGE = 0x0040
        TRILINEAR_BOUNDARY_IS_CORNER = 0x0080
        TRILINEAR_BOUNDARY_IS_ORIGIN = 0x0100
        TRILINEAR_BOUNDARY_IS_3EDGE = 0x0200
        TRILINEAR_BOUNDARY_IS_3CORNER = 0x0400
        TRILINEAR_BOUNDARY_IS_PRDCX = 0x0800
        TRILINEAR_BOUNDARY_IS_PRDCY = 0x1000
        TRILINEAR_BOUNDARY_IS_PRDCZ = 0x2000
        TRILINEAR_BOUNDARY_IS_XBC = (TRILINEAR_BOUNDARY_IS_LEFT | TRILINEAR_BOUNDARY_IS_RIGHT)
        TRILINEAR_BOUNDARY_IS_YBC = (TRILINEAR_BOUNDARY_IS_FRONT | TRILINEAR_BOUNDARY_IS_BACK)
        TRILINEAR_BOUNDARY_IS_ZBC = (TRILINEAR_BOUNDARY_IS_BOTTOM | TRILINEAR_BOUNDARY_IS_TOP)
        TRILINEAR_BOUNDARY_IS_FACE = (TRILINEAR_BOUNDARY_IS_XBC | TRILINEAR_BOUNDARY_IS_YBC | TRILINEAR_BOUNDARY_IS_ZBC) 
    ctypedef uint16_t trilinear_boundary_flag_t
    cdef struct trilinear_element_info2:
        int8_t nanchored, ndangling
        int8_t interior_only, interior_anchors_only
        int8_t corner[8]
        int8_t Qisdirect[8]
        int32_t Qindices[8]
        int64_t Qfvnids[8]
        trilinear_boundary_flag_t Qboundary[8]
        int8_t dQcolumn[8][4]
    ctypedef trilinear_element_info2 trilinear_element_info2_t
    cdef struct trilinear_mesh_extra:
        int32_t shared_elem_num
        int32_t *shared_elem_ids
        trilinear_element_info2_t *info2
    ctypedef trilinear_mesh_extra trilinear_mesh_extra_t
    cdef struct trilinear_mesh_t:
        int64_t total_elem_num
        int64_t total_node_num
        int64_t total_anode_num
        int64_t total_dnode_num
        int32_t local_elem_num
        int32_t local_node_num
        int32_t local_anode_num
        int32_t local_onode_num
        int32_t local_dnode_num
        int32_t local_owned_offset
        trilinear_elem_t *elem_table
        trilinear_node_t *node_table
        int64_t *fvnid_count_table
        int64_t *fvnid_interval_table
        int64_t *all_fvnid_start
        trilinear_node_t *anode_table
        trilinear_node_t *onode_table
        trilinear_node_t *dnode_table
        int64_t global_fvnid_num
        int64_t global_fvnid_start
        int64_t global_fvnid_end
        tick_t bounds[3][2]
        tick_t sizes[3], minsize, maxsize
        double ticksize
        MPI_Comm mpicomm
        int32_t mpisize, mpirank
        int32_t recsize
        int8_t gid
        trilinear_mesh_pid_t *elem_pids
        trilinear_mesh_pid_t *node_pids
        void (*destructor) (trilinear_mesh_t *)
        trilinear_mesh_extra_t *extra_info
        sc_mempool_t *sharer_pool
    ctypedef trilinear_mesh_t trilinear_mesh_t
    cdef struct octor_neighor_t:
        int32_t face_neighbor_eid[6][4]
    ctypedef octor_neighor_t octor_neighbor_t
    cdef struct phantom_elem_t:
        tick_t lx, ly, lz
        tick_t size
        int32_t owner_procid
        int32_t reid
    ctypedef phantom_elem_t phantom_elem_t
    cdef struct octor_neighborhood_t:
        int32_t phantom_elem_num
        phantom_elem_t *phantom_elem_table
        octor_neighbor_t *local_elem_neighbor_table
    ctypedef octor_neighborhood_t octor_neighborhood_t
    SC_EXTERN_C_BEGIN
    trilinear_mesh_t *p8est_trilinear_mesh_new_from_nodes (p8est_t * p8est, p8est_nodes_t * nodes)
    trilinear_mesh_t *p8est_trilinear_mesh_new_from_lnodes (p8est_t * p8est, p8est_lnodes_t * lnodes)
    void p8est_trilinear_mesh_destroy (trilinear_mesh_t * mesh)
    SC_EXTERN_C_END
