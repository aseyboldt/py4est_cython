from _c_sc cimport *
from _c_sc_containers cimport *

cdef extern from "sc_keyvalue.h" nogil:
    enum: SC_KEYVALUE_H

    SC_EXTERN_C_BEGIN
    enum sc_keyvalue_entry_type_t:
        SC_KEYVALUE_ENTRY_NONE = 0
        SC_KEYVALUE_ENTRY_INT
        SC_KEYVALUE_ENTRY_DOUBLE
        SC_KEYVALUE_ENTRY_STRING
        SC_KEYVALUE_ENTRY_POINTER
        
    cdef struct sc_keyvalue:
        sc_hash_t *hash
        sc_mempool_t *value_allocator
    ctypedef sc_keyvalue sc_keyvalue_t
    sc_keyvalue_t *sc_keyvalue_new ()
    sc_keyvalue_t *sc_keyvalue_newf (int dummy, ...)
    sc_keyvalue_t *sc_keyvalue_newv (va_list ap)
    void sc_keyvalue_destroy (sc_keyvalue_t * kv)
    sc_keyvalue_entry_type_t sc_keyvalue_exists (sc_keyvalue_t * kv, char *key)
    sc_keyvalue_entry_type_t sc_keyvalue_unset (sc_keyvalue_t * kv, char *key)
    int sc_keyvalue_get_int (sc_keyvalue_t * kv, char *key, int dvalue)
    double sc_keyvalue_get_double (sc_keyvalue_t * kv, char *key, double dvalue)
    char *sc_keyvalue_get_string (sc_keyvalue_t * kv, char *key, char *dvalue)
    void *sc_keyvalue_get_pointer (sc_keyvalue_t * kv, char *key, void *dvalue)
    void sc_keyvalue_set_int (sc_keyvalue_t * kv, char *key, int newvalue)
    void sc_keyvalue_set_double (sc_keyvalue_t * kv, char *key, double newvalue)
    void sc_keyvalue_set_string (sc_keyvalue_t * kv, char *key, char *newvalue)
    void sc_keyvalue_set_pointer (sc_keyvalue_t * kv, char *key, void *newvalue)
    ctypedef int (*sc_keyvalue_foreach_t) (char *key, sc_keyvalue_entry_type_t type, void *entry, void *u)
    void sc_keyvalue_foreach (sc_keyvalue_t * kv, sc_keyvalue_foreach_t fn, void *user_data)
    SC_EXTERN_C_END
