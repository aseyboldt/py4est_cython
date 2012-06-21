from _c_p8est cimport *

cdef extern from "p8est_extended.h" nogil:
    enum: P8EST_EXTENDED_H

    SC_EXTERN_C_BEGIN
    ctypedef int (*p8est_refine_ext_t) (p8est_t * p8est, p4est_topidx_t which_tree, p8est_quadrant_t * quadrant, p8est_quadrant_t * children[])
    p8est_t *p8est_new_ext (MPI_Comm mpicomm, p8est_connectivity_t * connectivity, p4est_locidx_t min_quadrants, int min_level, int fill_uniform, size_t data_size, p8est_init_t init_fn, void *user_pointer)
    void p8est_refine_ext (p8est_t * p8est, int refine_recursive, int maxlevel, p8est_refine_t refine_fn, p8est_refine_ext_t refine_ext_fn, p8est_init_t init_fn)
    void p8est_partition_ext (p8est_t * p8est, int partition_for_coarsening, p8est_weight_t weight_fn)
    SC_EXTERN_C_END
