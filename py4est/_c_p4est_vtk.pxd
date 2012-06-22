from _c_p4est_geometry cimport *

cdef extern from "p4est_vtk.h" nogil:
    enum: P4EST_VTK_H

    SC_EXTERN_C_BEGIN
    void p4est_vtk_write_file (p4est_t * p4est, p4est_geometry_t * geom, char *filename)
    void p4est_vtk_write_all (p4est_t * p4est, p4est_geometry_t * geom, double scale, int write_tree, int write_rank, int wrap_rank, int num_scalars, int num_vectors, char *filename, ...)
    int p4est_vtk_write_header (p4est_t * p4est, p4est_geometry_t * geom, double scale, int write_tree, int write_rank, int wrap_rank, char *point_scalars, char *point_vectors, char *filename)
    int p4est_vtk_write_point_scalar (p4est_t * p4est, p4est_geometry_t * geom, char *filename, char *scalar_name, double *values)
    int p4est_vtk_write_point_vector (p4est_t * p4est, p4est_geometry_t * geom, char *filename, char *vector_name, double *values)
    int p4est_vtk_write_footer (p4est_t * p4est, char *filename)
    SC_EXTERN_C_END
