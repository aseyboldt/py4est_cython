from _c_p8est cimport *

cdef extern from "p8est_geometry.h" nogil:
    enum: P8EST_GEOMETRY_H

    SC_EXTERN_C_BEGIN
    cdef struct p8est_geometry:
        pass
    ctypedef p8est_geometry p8est_geometry_t
    ctypedef void (*p8est_geometry_X_t) (p8est_geometry_t * geom, p4est_topidx_t which_tree, double abc[3], double xyz[3])
    ctypedef double (*p8est_geometry_D_t) (p8est_geometry_t * geom, p4est_topidx_t which_tree, double abc[3])
    ctypedef double (*p8est_geometry_J_t) (p8est_geometry_t * geom, p4est_topidx_t which_tree, double abc[3], double J[3][3])
    ctypedef int (*p8est_geometry_R_t) (p8est_geometry_t * geom, p4est_topidx_t which_tree, double txyz[3], double cabc[8][3], double abc[3], double rst[3])
    cdef struct p8est_geometry:
        char *name
        p8est_geometry_X_t X
        p8est_geometry_D_t D
        p8est_geometry_J_t J, Jit
        p8est_geometry_R_t R
    int p8est_geometry_max_newton
    double p8est_geometry_Jit (p8est_geometry_t * geom, p4est_topidx_t which_tree, double abc[3], double Jit[3][3])
    int p8est_geometry_R (p8est_geometry_t * geom, p4est_topidx_t which_tree, double txyz[3], double cabc[8][3], double abc[3], double rst[3])
    void p8est_geometry_identity_X (p8est_geometry_t * geom, p4est_topidx_t which_tree, double abc[3], double xyz[3])
    double p8est_geometry_identity_D (p8est_geometry_t * geom, p4est_topidx_t which_tree, double abc[3])
    double p8est_geometry_identity_J (p8est_geometry_t * geom, p4est_topidx_t which_tree, double abc[3], double J[3][3])
    p8est_geometry_t *p8est_geometry_new_identity ()
    p8est_geometry_t *p8est_geometry_new_shell (double R2, double R1)
    p8est_geometry_t *p8est_geometry_new_sphere (double R2, double R1, double R0)
    SC_EXTERN_C_END
