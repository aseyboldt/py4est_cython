from _c_sc cimport *

cdef extern from "sc_functions.h" nogil:
    enum: SC_FUNCTIONS_H

    SC_EXTERN_C_BEGIN
    ctypedef double (*sc_function1_t) (double x, void *data)
    ctypedef double (*sc_function3_t) (double x, double y, double z, void *data)
    cdef struct sc_function3_meta:
        sc_function3_t f1
        sc_function3_t f2
        double parameter2
        sc_function3_t f3
        void *data
    ctypedef sc_function3_meta sc_function3_meta_t
    double sc_function1_invert (sc_function1_t func, void *data, double x_low, double x_high, double y, double rtol)
    void sc_srand (unsigned int seed)
    double sc_rand_uniform ()
    double sc_rand_normal ()
    double sc_zero3 (double x, double y, double z, void *data)
    double sc_one3 (double x, double y, double z, void *data)
    double sc_two3 (double x, double y, double z, void *data)
    double sc_ten3 (double x, double y, double z, void *data)
    double sc_constant3 (double x, double y, double z, void *data)
    double sc_x3 (double x, double y, double z, void *data)
    double sc_y3 (double x, double y, double z, void *data)
    double sc_z3 (double x, double y, double z, void *data)
    double sc_sum3 (double x, double y, double z, void *data)
    double sc_product3 (double x, double y, double z, void *data)
    double sc_tensor3 (double x, double y, double z, void *data)
    SC_EXTERN_C_END
