from _c_p8est cimport *

cdef extern from "p8est_points.h" nogil:
    enum: P8EST_POINTS_H

    SC_EXTERN_C_BEGIN
    p8est_t *p8est_new_points (MPI_Comm mpicomm, p8est_connectivity_t * connectivity, int maxlevel, p8est_quadrant_t * points, p4est_locidx_t num_points, p4est_locidx_t max_points, size_t data_size, p8est_init_t init_fn, void *user_pointer)
    SC_EXTERN_C_END
