from _c_p4est cimport *

cdef extern from "p4est_extended.h" nogil:
    enum: P4EST_EXTENDED_H

    ctypedef int (*p4est_refine_ext_t) (p4est_t * p4est, p4est_topidx_t which_tree, p4est_quadrant_t * quadrant, p4est_quadrant_t * children[])
    p4est_t *p4est_new_ext (MPI_Comm mpicomm, p4est_connectivity_t * connectivity, p4est_locidx_t min_quadrants, int min_level, int fill_uniform, size_t data_size, p4est_init_t init_fn, void *user_pointer)
    void p4est_refine_ext (p4est_t * p4est, int refine_recursive, int maxlevel, p4est_refine_t refine_fn, p4est_refine_ext_t refine_ext_fn, p4est_init_t init_fn)
    void p4est_partition_ext (p4est_t * p4est, int partition_for_coarsening, p4est_weight_t weight_fn)
