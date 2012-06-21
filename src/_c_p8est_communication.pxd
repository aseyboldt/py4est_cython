from _c_p8est cimport *

cdef extern from "p8est_communication.h" nogil:
    enum: P8EST_COMMUNICATION_H

    SC_EXTERN_C_BEGIN
    enum p8est_comm_tag_t:
        P8EST_COMM_COUNT_PERTREE = 1
        P8EST_COMM_BALANCE_FIRST_COUNT
        P8EST_COMM_BALANCE_FIRST_LOAD
        P8EST_COMM_BALANCE_SECOND_COUNT
        P8EST_COMM_BALANCE_SECOND_LOAD
        P8EST_COMM_PARTITION_GIVEN
        P8EST_COMM_PARTITION_WEIGHTED_LOW
        P8EST_COMM_PARTITION_WEIGHTED_HIGH
        P8EST_COMM_PARTITION_CORRECTION
        P8EST_COMM_GHOST_COUNT
        P8EST_COMM_GHOST_LOAD
        P8EST_COMM_NODES_QUERY
        P8EST_COMM_NODES_REPLY
        P8EST_COMM_SAVE
        P8EST_COMM_LNODES_TEST
        P8EST_COMM_LNODES_PASS
        P8EST_COMM_LNODES_OWNED
        P8EST_COMM_LNODES_ALL 
    void p8est_comm_count_quadrants (p8est_t * p8est)
    void p8est_comm_global_partition (p8est_t * p8est, p8est_quadrant_t * first_quad)
    void p8est_comm_count_pertree (p8est_t * p8est, p4est_gloidx_t * pertree)
    int p8est_comm_find_owner (p8est_t * p8est, p4est_locidx_t which_tree, p8est_quadrant_t * q, int guess)
    void p8est_comm_tree_info (p8est_t * p8est, p4est_locidx_t which_tree, int full_tree[], int tree_contact[], p8est_quadrant_t ** firstq, p8est_quadrant_t ** nextq)
    int p8est_comm_neighborhood_owned (p8est_t * p8est, p4est_locidx_t which_tree, int full_tree[], int tree_contact[], p8est_quadrant_t * q)
    int p8est_comm_sync_flag (p8est_t * p8est, int flag, MPI_Op operation)
    unsigned p8est_comm_checksum (p8est_t * p8est, unsigned local_crc, size_t local_bytes)
    SC_EXTERN_C_END
