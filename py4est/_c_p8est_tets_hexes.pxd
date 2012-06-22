from _c_p8est_connectivity cimport *

cdef extern from "p8est_tets_hexes.h" nogil:
    enum: P8EST_TETS_HEXES_H

    cdef struct p8est_tets:
        sc_array_t *nodes
        sc_array_t *tets
        sc_array_t *tet_attributes
    ctypedef p8est_tets p8est_tets_t
    sc_array_t *p8est_tets_read_node (char *nodefile)
    sc_array_t *p8est_tets_read_ele (char *elefile, p4est_topidx_t num_nodes, sc_array_t ** attributes)
    p8est_tets_t *p8est_tets_read (char *tetgenbasename)
    void p8est_tets_destroy (p8est_tets_t * ptg)
    p4est_topidx_t p8est_tets_make_righthanded (p8est_tets_t * ptg)
    p8est_connectivity_t *p8est_connectivity_new_tets (p8est_tets_t * ptg)
