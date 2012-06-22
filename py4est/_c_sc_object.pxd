from _c_sc cimport *
from _c_sc_containers cimport *
from _c_sc_keyvalue cimport *

cdef extern from "sc_object.h" nogil:
    enum: SC_OBJECT_H

    SC_EXTERN_C_BEGIN
    ctypedef void (*sc_object_method_t) ()
    cdef struct sc_object_entry:
        sc_object_method_t key
        sc_object_method_t oinmi
        void *odata
    ctypedef sc_object_entry sc_object_entry_t
    cdef struct sc_object:
        int num_refs
        sc_hash_t *table
        sc_array_t delegates
        void *data
    ctypedef sc_object sc_object_t
    cdef struct sc_object_entry_match:
        sc_object_t *match
        sc_object_entry_t *entry
    ctypedef sc_object_entry_match sc_object_entry_match_t
    cdef struct sc_object_search_context:
        sc_hash_t *visited
        sc_object_method_t lookup
        sc_array_t *found
        int skip_top
        int accept_self
        int accept_delegate
        int allow_oinmi
        int allow_odata
        int (*call_fn) (sc_object_t *, sc_object_entry_t *, void *)
        void *user_data
        sc_object_t *last_match
    ctypedef sc_object_search_context sc_object_search_context_t
    char *sc_object_type
    void sc_object_ref (sc_object_t * o)
    void sc_object_unref (sc_object_t * o)
    sc_object_t *sc_object_dup (sc_object_t * o)
    void sc_object_delegate_push (sc_object_t * o, sc_object_t * d)
    void sc_object_delegate_pop (sc_object_t * o)
    void sc_object_delegate_pop_all (sc_object_t * o)
    sc_object_t *sc_object_delegate_index (sc_object_t * o, size_t iz)
    sc_object_entry_t *sc_object_entry_lookup (sc_object_t * o, sc_object_method_t ifm)
    void sc_object_entry_search_init (sc_object_search_context_t * rc, sc_object_method_t ifm, int allow_oinmi, int allow_odata, sc_array_t * found)
    int sc_object_entry_search (sc_object_t * o, sc_object_search_context_t * rc)
    int sc_object_method_register (sc_object_t * o, sc_object_method_t ifm, sc_object_method_t oinmi)
    void sc_object_method_unregister (sc_object_t * o, sc_object_method_t ifm)
    sc_object_method_t sc_object_method_lookup (sc_object_t * o, sc_object_method_t ifm)
    sc_object_method_t sc_object_method_search (sc_object_t * o, sc_object_method_t ifm, int skip_top, sc_object_t ** m)
    void *sc_object_data_register (sc_object_t * o, sc_object_method_t ifm, size_t s)
    void *sc_object_data_lookup (sc_object_t * o, sc_object_method_t ifm)
    void *sc_object_data_search (sc_object_t * o, sc_object_method_t ifm, int skip_top, sc_object_t ** m)
    sc_object_t *sc_object_alloc ()
    sc_object_t *sc_object_klass_new ()
    sc_object_t *sc_object_new_from_klass (sc_object_t * d, sc_keyvalue_t * args)
    sc_object_t *sc_object_new_from_klassf (sc_object_t * d, ...)
    sc_object_t *sc_object_new_from_klassv (sc_object_t * d, va_list ap)
    int sc_object_is_type (sc_object_t * o, char *type)
    sc_object_t *sc_object_copy (sc_object_t * o)
    void sc_object_initialize (sc_object_t * o, sc_keyvalue_t * args)
    void sc_object_finalize (sc_object_t * o)
    void sc_object_write (sc_object_t * o, FILE * out)
    SC_EXTERN_C_END
