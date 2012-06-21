from _c_p8est_connectivity cimport *

cdef extern from "p8est.h" nogil:
    enum: P8EST_H
    enum: P8EST_MAXLEVEL
    enum: P8EST_QMAXLEVEL
    enum: P8EST_ROOT_LEN

    SC_EXTERN_C_BEGIN
    cdef struct _struct_piggy1:
        p4est_topidx_t which_tree
        int owner_rank
    cdef struct _struct_piggy2:
        p4est_topidx_t which_tree
        p4est_topidx_t from_tree
    cdef struct _struct_piggy3:
        p4est_topidx_t which_tree
        p4est_locidx_t local_num
    cdef union p8est_quadrant_data:
        void *user_data
        int user_int
        p4est_topidx_t which_tree
        _struct_piggy1 piggy1
        _struct_piggy2 piggy2
        _struct_piggy3 piggy3
    cdef struct p8est_quadrant:
        p4est_qcoord_t x, y, z
        int8_t level, pad8
        int16_t pad16
        p8est_quadrant_data p
    ctypedef p8est_quadrant p8est_quadrant_t
    cdef struct p8est_tree:
        sc_array_t quadrants
        p8est_quadrant_t first_desc, last_desc
        p4est_locidx_t quadrants_offset
        p4est_locidx_t quadrants_per_level[P8EST_MAXLEVEL + 1]
        int8_t maxlevel
    ctypedef p8est_tree p8est_tree_t
    cdef struct p8est_inspect:
        int use_balance_subtree_new
        int use_overlap_new
        int use_borders
        int use_balance_ranges
        int use_balance_ranges_notify
        int use_balance_verify
        int balance_max_ranges
        size_t balance_A_count_in
        size_t balance_A_count_out
        size_t balance_comm_sent
        size_t balance_comm_nzpeers
        size_t balance_B_count_in
        size_t balance_B_count_out
        size_t balance_zero_sends[2], balance_zero_receives[2]
        double balance_A
        double balance_comm
        double balance_B
        double balance_ranges
        double balance_notify
        double balance_notify_allgather
        int use_B
    ctypedef p8est_inspect p8est_inspect_t
    cdef struct p8est:
        MPI_Comm mpicomm
        int mpisize, mpirank
        size_t data_size
        void *user_pointer
        p4est_topidx_t first_local_tree
        p4est_topidx_t last_local_tree
        p4est_locidx_t local_num_quadrants
        p4est_gloidx_t global_num_quadrants
        p4est_gloidx_t *global_first_quadrant
        p8est_quadrant_t *global_first_position
        p8est_connectivity_t *connectivity
        sc_array_t *trees
        sc_mempool_t *user_data_pool
        sc_mempool_t *quadrant_pool
        p8est_inspect_t *inspect
    ctypedef p8est p8est_t
    size_t p8est_memory_used (p8est_t * p8est)
    ctypedef void (*p8est_init_t) (p8est_t * p8est, p4est_topidx_t which_tree, p8est_quadrant_t * quadrant)
    ctypedef int (*p8est_refine_t) (p8est_t * p8est, p4est_topidx_t which_tree, p8est_quadrant_t * quadrant)
    ctypedef int (*p8est_coarsen_t) (p8est_t * p8est, p4est_topidx_t which_tree, p8est_quadrant_t * quadrants[])
    ctypedef int (*p8est_weight_t) (p8est_t * p8est, p4est_topidx_t which_tree, p8est_quadrant_t * quadrant)
    void *P8EST_DATA_UNINITIALIZED
    int p8est_num_ranges
    void p8est_qcoord_to_vertex (p8est_connectivity_t * connectivity, p4est_topidx_t treeid, p4est_qcoord_t x, p4est_qcoord_t y, p4est_qcoord_t z, double vxyz[3])
    p8est_t *p8est_new (MPI_Comm mpicomm, p8est_connectivity_t * connectivity, size_t data_size, p8est_init_t init_fn, void *user_pointer)
    void p8est_destroy (p8est_t * p8est)
    p8est_t *p8est_copy (p8est_t * input, int copy_data)
    void p8est_reset_data (p8est_t * p8est, size_t data_size, p8est_init_t init_fn, void *user_pointer)
    void p8est_refine (p8est_t * p8est, int refine_recursive, p8est_refine_t refine_fn, p8est_init_t init_fn)
    void p8est_coarsen (p8est_t * p8est, int coarsen_recursive, p8est_coarsen_t coarsen_fn, p8est_init_t init_fn)
    void p8est_balance (p8est_t * p8est, p8est_connect_type_t btype, p8est_init_t init_fn)
    void p8est_partition (p8est_t * p8est, p8est_weight_t weight_fn)
    unsigned p8est_checksum (p8est_t * p8est)
    void p8est_save (char *filename, p8est_t * p8est, int save_data)
    p8est_t *p8est_load (char *filename, MPI_Comm mpicomm, size_t data_size, int load_data, void *user_pointer, p8est_connectivity_t ** connectivity)
    p8est_tree_t * p8est_tree_array_index (sc_array_t * array, p4est_topidx_t it)
    p8est_quadrant_t * p8est_quadrant_array_index (sc_array_t * array, size_t it)
    p8est_quadrant_t * p8est_quadrant_array_push (sc_array_t * array)
    p8est_quadrant_t * p8est_quadrant_mempool_alloc (sc_mempool_t * mempool)
    p8est_quadrant_t * p8est_quadrant_list_pop (sc_list_t * list)
    SC_EXTERN_C_END
