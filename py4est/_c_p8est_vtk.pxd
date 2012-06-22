from _c_p8est_geometry cimport *

cdef extern from "p8est_vtk.h" nogil:
    enum: P8EST_VTK_H

    SC_EXTERN_C_BEGIN
    void p8est_vtk_write_file (p8est_t * p8est, p8est_geometry_t * geom, char *filename)
    void p8est_vtk_write_all (p8est_t * p8est, p8est_geometry_t * geom, double scale, int write_tree, int write_rank, int wrap_rank, int num_scalars, int num_vectors, char *filename, ...)
    int p8est_vtk_write_header (p8est_t * p8est, p8est_geometry_t * geom, double scale, int write_tree, int write_rank, int wrap_rank, char *point_scalars, char *point_vectors, char *filename)
    int p8est_vtk_write_point_scalar (p8est_t * p8est, p8est_geometry_t * geom, char *filename, char *scalar_name, double *values)
    int p8est_vtk_write_point_vector (p8est_t * p8est, p8est_geometry_t * geom, char *filename, char *vector_name, double *values)
    int p8est_vtk_write_footer (p8est_t * p8est, char *filename)
    SC_EXTERN_C_END
