from _c_p4est cimport *

cdef extern from "p4est_communication.h" nogil:
    enum: P4EST_COMMUNICATION_H

    SC_EXTERN_C_BEGIN
    enum p4est_comm_tag_t:
        P4EST_COMM_COUNT_PERTREE = 1
        P4EST_COMM_BALANCE_FIRST_COUNT
        P4EST_COMM_BALANCE_FIRST_LOAD
        P4EST_COMM_BALANCE_SECOND_COUNT
        P4EST_COMM_BALANCE_SECOND_LOAD
        P4EST_COMM_PARTITION_GIVEN
        P4EST_COMM_PARTITION_WEIGHTED_LOW
        P4EST_COMM_PARTITION_WEIGHTED_HIGH
        P4EST_COMM_PARTITION_CORRECTION
        P4EST_COMM_GHOST_COUNT
        P4EST_COMM_GHOST_LOAD
        P4EST_COMM_NODES_QUERY
        P4EST_COMM_NODES_REPLY
        P4EST_COMM_SAVE
        P4EST_COMM_LNODES_TEST
        P4EST_COMM_LNODES_PASS
        P4EST_COMM_LNODES_OWNED
        P4EST_COMM_LNODES_ALL 
    void p4est_comm_count_quadrants (p4est_t * p4est)
    void p4est_comm_global_partition (p4est_t * p4est, p4est_quadrant_t * first_quad)
    void p4est_comm_count_pertree (p4est_t * p4est, p4est_gloidx_t * pertree)
    int p4est_comm_find_owner (p4est_t * p4est, p4est_locidx_t which_tree, p4est_quadrant_t * q, int guess)
    void p4est_comm_tree_info (p4est_t * p4est, p4est_locidx_t which_tree, int full_tree[], int tree_contact[], p4est_quadrant_t ** firstq, p4est_quadrant_t ** nextq)
    int p4est_comm_neighborhood_owned (p4est_t * p4est, p4est_locidx_t which_tree, int full_tree[], int tree_contact[], p4est_quadrant_t * q)
    int p4est_comm_sync_flag (p4est_t * p4est, int flag, MPI_Op operation)
    unsigned p4est_comm_checksum (p4est_t * p4est, unsigned local_crc, size_t local_bytes)
    SC_EXTERN_C_END
