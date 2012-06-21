from _c_p4est cimport *

cdef extern from "p4est_points.h" nogil:
    enum: P4EST_POINTS_H

    SC_EXTERN_C_BEGIN
    p4est_t *p4est_new_points (MPI_Comm mpicomm, p4est_connectivity_t * connectivity, int maxlevel, p4est_quadrant_t * points, p4est_locidx_t num_points, p4est_locidx_t max_points, size_t data_size, p4est_init_t init_fn, void *user_pointer)
    SC_EXTERN_C_END
