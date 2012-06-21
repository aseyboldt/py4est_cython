from _c_p4est_connectivity cimport *

cdef extern from "p4est.h" nogil:
    enum: P4EST_H
    enum: P4EST_MAXLEVEL
    enum: P4EST_QMAXLEVEL
    enum: P4EST_ROOT_LEN

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
    cdef union p4est_quadrant_data:
        void *user_data
        int user_int
        p4est_topidx_t which_tree
        _struct_piggy1 piggy1
        _struct_piggy2 piggy2
        _struct_piggy3 piggy3
    cdef struct p4est_quadrant:
        p4est_qcoord_t x, y
        int8_t level, pad8
        int16_t pad16
        p4est_quadrant_data p
    ctypedef p4est_quadrant p4est_quadrant_t
    cdef struct p4est_tree:
        sc_array_t quadrants
        p4est_quadrant_t first_desc, last_desc
        p4est_locidx_t quadrants_offset
        p4est_locidx_t quadrants_per_level[P4EST_MAXLEVEL + 1]
        int8_t maxlevel
    ctypedef p4est_tree p4est_tree_t
    cdef struct p4est_inspect:
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
    ctypedef p4est_inspect p4est_inspect_t
    cdef struct p4est:
        MPI_Comm mpicomm
        int mpisize, mpirank
        size_t data_size
        void *user_pointer
        p4est_topidx_t first_local_tree
        p4est_topidx_t last_local_tree
        p4est_locidx_t local_num_quadrants
        p4est_gloidx_t global_num_quadrants
        p4est_gloidx_t *global_first_quadrant
        p4est_quadrant_t *global_first_position
        p4est_connectivity_t *connectivity
        sc_array_t *trees
        sc_mempool_t *user_data_pool
        sc_mempool_t *quadrant_pool
        p4est_inspect_t *inspect
    ctypedef p4est p4est_t
    size_t p4est_memory_used (p4est_t * p4est)
    ctypedef void (*p4est_init_t) (p4est_t * p4est, p4est_topidx_t which_tree, p4est_quadrant_t * quadrant)
    ctypedef int (*p4est_refine_t) (p4est_t * p4est, p4est_topidx_t which_tree, p4est_quadrant_t * quadrant)
    ctypedef int (*p4est_coarsen_t) (p4est_t * p4est, p4est_topidx_t which_tree, p4est_quadrant_t * quadrants[])
    ctypedef int (*p4est_weight_t) (p4est_t * p4est, p4est_topidx_t which_tree, p4est_quadrant_t * quadrant)
    void *P4EST_DATA_UNINITIALIZED
    int p4est_num_ranges
    void p4est_qcoord_to_vertex (p4est_connectivity_t * connectivity, p4est_topidx_t treeid, p4est_qcoord_t x, p4est_qcoord_t y, double vxyz[3])
    p4est_t *p4est_new (MPI_Comm mpicomm, p4est_connectivity_t * connectivity, size_t data_size, p4est_init_t init_fn, void *user_pointer)
    void p4est_destroy (p4est_t * p4est)
    p4est_t *p4est_copy (p4est_t * input, int copy_data)
    void p4est_reset_data (p4est_t * p4est, size_t data_size, p4est_init_t init_fn, void *user_pointer)
    void p4est_refine (p4est_t * p4est, int refine_recursive, p4est_refine_t refine_fn, p4est_init_t init_fn)
    void p4est_coarsen (p4est_t * p4est, int coarsen_recursive, p4est_coarsen_t coarsen_fn, p4est_init_t init_fn)
    void p4est_balance (p4est_t * p4est, p4est_connect_type_t btype, p4est_init_t init_fn)
    void p4est_partition (p4est_t * p4est, p4est_weight_t weight_fn)
    unsigned p4est_checksum (p4est_t * p4est)
    void p4est_save (char *filename, p4est_t * p4est, int save_data)
    p4est_t *p4est_load (char *filename, MPI_Comm mpicomm, size_t data_size, int load_data, void *user_pointer, p4est_connectivity_t ** connectivity)
    p4est_tree_t * p4est_tree_array_index (sc_array_t * array, p4est_topidx_t it)
    p4est_quadrant_t * p4est_quadrant_array_index (sc_array_t * array, size_t it)
    p4est_quadrant_t * p4est_quadrant_array_push (sc_array_t * array)
    p4est_quadrant_t * p4est_quadrant_mempool_alloc (sc_mempool_t * mempool)
    p4est_quadrant_t * p4est_quadrant_list_pop (sc_list_t * list)
    SC_EXTERN_C_END
