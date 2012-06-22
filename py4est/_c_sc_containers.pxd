from libc.stdint cimport *
from _c_sc cimport *

cdef extern from "sc_containers.h" nogil:
    enum: SC_CONTAINERS_H

    ctypedef unsigned (*sc_hash_function_t) (void *v, void *u)
    ctypedef int (*sc_equal_function_t) (void *v1, void *v2, void *u)
    ctypedef int (*sc_hash_foreach_t) (void **v, void *u)
    cdef struct sc_array:
        size_t elem_size
        size_t elem_count
        ssize_t byte_alloc
        char *array
    ctypedef sc_array sc_array_t
    size_t sc_array_memory_used (sc_array_t * array, int is_dynamic)
    sc_array_t *sc_array_new (size_t elem_size)
    sc_array_t *sc_array_new_size (size_t elem_size, size_t elem_count)
    sc_array_t *sc_array_new_view (sc_array_t * array, size_t offset, size_t length)
    sc_array_t *sc_array_new_data (void *base, size_t elem_size, size_t elem_count)
    void sc_array_destroy (sc_array_t * array)
    void sc_array_init (sc_array_t * array, size_t elem_size)
    void sc_array_init_size (sc_array_t * array, size_t elem_size, size_t elem_count)
    void sc_array_init_view (sc_array_t * view, sc_array_t * array, size_t offset, size_t length)
    void sc_array_init_data (sc_array_t * view, void *base, size_t elem_size, size_t elem_count)
    void sc_array_reset (sc_array_t * array)
    void sc_array_resize (sc_array_t * array, size_t new_count)
    void sc_array_copy (sc_array_t * dest, sc_array_t * src)
    void sc_array_sort (sc_array_t * array, int (*compar) (void *, void *))
    int sc_array_is_sorted (sc_array_t * array, int (*compar) (void *, void *))
    int sc_array_is_equal (sc_array_t * array, sc_array_t * other)
    void sc_array_uniq (sc_array_t * array, int (*compar) (void *, void *))
    ssize_t sc_array_bsearch (sc_array_t * array, void *key, int (*compar) (void *, void *))
    ctypedef size_t (*sc_array_type_t) (sc_array_t * array, size_t index, void *data)
    void sc_array_split (sc_array_t * array, sc_array_t * offsets, size_t num_types, sc_array_type_t type_fn, void *data)
    int sc_array_is_permutation (sc_array_t * array)
    void sc_array_permute (sc_array_t * array, sc_array_t * newindices, int keepperm)
    unsigned sc_array_checksum (sc_array_t * array)
    size_t sc_array_pqueue_add (sc_array_t * array, void *temp, int (*compar) (void *, void *))
    size_t sc_array_pqueue_pop (sc_array_t * array, void *result, int (*compar) (void *, void *))
    void * sc_array_index (sc_array_t * array, size_t iz)
    void * sc_array_index_int (sc_array_t * array, int i)
    void * sc_array_index_long (sc_array_t * array, long l)
    void * sc_array_index_ssize_t (sc_array_t * array, ssize_t)
    void * sc_array_index_int16 (sc_array_t * array, int16_t i16)
    size_t sc_array_position (sc_array_t * array, void *element)
    void * sc_array_pop (sc_array_t * array)
    void * sc_array_push_count (sc_array_t * array, size_t add_count)
    void * sc_array_push (sc_array_t * array)
    cdef struct sc_mempool:
        #size_t elem_size
        #size_t elem_count
        #obstack obstack
        #sc_array_t freed
        pass
    ctypedef sc_mempool sc_mempool_t
    size_t sc_mempool_memory_used (sc_mempool_t * mempool)
    sc_mempool_t *sc_mempool_new (size_t elem_size)
    void sc_mempool_destroy (sc_mempool_t * mempool)
    void sc_mempool_truncate (sc_mempool_t * mempool)
    void * sc_mempool_alloc (sc_mempool_t * mempool)
    void sc_mempool_free (sc_mempool_t * mempool, void *elem)
    cdef struct sc_link:
        void *data
        sc_link *next
    ctypedef sc_link sc_link_t
    cdef struct sc_list:
        size_t elem_count
        sc_link_t *first
        sc_link_t *last
        int allocator_owned
        sc_mempool_t *allocator
    ctypedef sc_list sc_list_t
    size_t sc_list_memory_used (sc_list_t * list, int is_dynamic)
    sc_list_t *sc_list_new (sc_mempool_t * allocator)
    void sc_list_destroy (sc_list_t * list)
    void sc_list_init (sc_list_t * list, sc_mempool_t * allocator)
    void sc_list_reset (sc_list_t * list)
    void sc_list_unlink (sc_list_t * list)
    void sc_list_prepend (sc_list_t * list, void *data)
    void sc_list_append (sc_list_t * list, void *data)
    void sc_list_insert (sc_list_t * list, sc_link_t * pred, void *data)
    void *sc_list_remove (sc_list_t * list, sc_link_t * pred)
    void *sc_list_pop (sc_list_t * list)
    cdef struct sc_hash:
        size_t elem_count
        sc_array_t *slots
        void *user_data
        sc_hash_function_t hash_fn
        sc_equal_function_t equal_fn
        size_t resize_checks, resize_actions
        int allocator_owned
        sc_mempool_t *allocator
    ctypedef sc_hash sc_hash_t
    size_t sc_hash_memory_used (sc_hash_t * hash)
    sc_hash_t *sc_hash_new (sc_hash_function_t hash_fn, sc_equal_function_t equal_fn, void *user_data, sc_mempool_t * allocator)
    void sc_hash_destroy (sc_hash_t * hash)
    void sc_hash_truncate (sc_hash_t * hash)
    void sc_hash_unlink (sc_hash_t * hash)
    void sc_hash_unlink_destroy (sc_hash_t * hash)
    int sc_hash_lookup (sc_hash_t * hash, void *v, void ***found)
    int sc_hash_insert_unique (sc_hash_t * hash, void *v, void ***found)
    int sc_hash_remove (sc_hash_t * hash, void *v, void **found)
    void sc_hash_foreach (sc_hash_t * hash, sc_hash_foreach_t fn)
    void sc_hash_print_statistics (int package_id, int log_priority, sc_hash_t * hash)
    cdef struct sc_hash_array_data:
        sc_array_t *pa
        sc_hash_function_t hash_fn
        sc_equal_function_t equal_fn
        void *user_data
        void *current_item
    ctypedef sc_hash_array_data sc_hash_array_data_t
    cdef struct sc_hash_array:
        sc_array_t a
        sc_hash_array_data_t internal_data
        sc_hash_t *h
    ctypedef sc_hash_array sc_hash_array_t
    size_t sc_hash_array_memory_used (sc_hash_array_t * ha)
    sc_hash_array_t *sc_hash_array_new (size_t elem_size, sc_hash_function_t hash_fn, sc_equal_function_t equal_fn, void *user_data)
    void sc_hash_array_destroy (sc_hash_array_t * hash_array)
    int sc_hash_array_is_valid (sc_hash_array_t * hash_array)
    void sc_hash_array_truncate (sc_hash_array_t * hash_array)
    int sc_hash_array_lookup (sc_hash_array_t * hash_array, void *v, size_t * position)
    void *sc_hash_array_insert_unique (sc_hash_array_t * hash_array, void *v, size_t * position)
    void sc_hash_array_rip (sc_hash_array_t * hash_array, sc_array_t * rip)
    cdef struct sc_recycle_array:
        size_t elem_count
        sc_array_t a
        sc_array_t f
    ctypedef sc_recycle_array sc_recycle_array_t
    void sc_recycle_array_init (sc_recycle_array_t * rec_array, size_t elem_size)
    void sc_recycle_array_reset (sc_recycle_array_t * rec_array)
    void *sc_recycle_array_insert (sc_recycle_array_t * rec_array, size_t * position)
    void *sc_recycle_array_remove (sc_recycle_array_t * rec_array, size_t position)

