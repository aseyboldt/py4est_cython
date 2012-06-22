from _c_sc_containers cimport *

cdef extern from "sc_avl.h" nogil:
    enum: _AVL_H
    enum: AVL_COUNT
    enum: AVL_DEPTH

    SC_EXTERN_C_BEGIN
    ctypedef int (*avl_compare_t)(void *, void *)
    ctypedef void (*avl_freeitem_t)(void *)
    ctypedef void (*avl_foreach_t)(void *, void *)
    cdef struct avl_node_t:
        avl_node_t *next
        avl_node_t *prev
        avl_node_t *parent
        avl_node_t *left
        avl_node_t *right
        void *item
        unsigned int count
        unsigned char depth
    ctypedef avl_node_t avl_node_t
    cdef struct avl_tree_t:
        avl_node_t *head
        avl_node_t *tail
        avl_node_t *top
        avl_compare_t cmp
        avl_freeitem_t freeitem
    ctypedef avl_tree_t avl_tree_t
    avl_tree_t *avl_init_tree(avl_tree_t *avltree, avl_compare_t, avl_freeitem_t)
    avl_tree_t *avl_alloc_tree(avl_compare_t, avl_freeitem_t)
    void avl_free_tree(avl_tree_t *)
    void avl_clear_tree(avl_tree_t *)
    void avl_free_nodes(avl_tree_t *)
    avl_node_t *avl_init_node(avl_node_t *avlnode, void *item)
    avl_node_t *avl_insert(avl_tree_t *, void *item)
    avl_node_t *avl_insert_node(avl_tree_t *, avl_node_t *)
    avl_node_t *avl_insert_top(avl_tree_t *, avl_node_t *avlnode)
    avl_node_t *avl_insert_before(avl_tree_t *, avl_node_t *old, avl_node_t *nw)
    avl_node_t *avl_insert_after(avl_tree_t *, avl_node_t *old, avl_node_t *nw)
    void avl_unlink_node(avl_tree_t *, avl_node_t *)
    void *avl_delete_node(avl_tree_t *, avl_node_t *)
    void *avl_delete(avl_tree_t *, void *item)
    avl_node_t *avl_fixup_node(avl_tree_t *, avl_node_t *nw)
    int avl_search_closest(avl_tree_t *, void *item, avl_node_t **avlnode)
    avl_node_t *avl_search(avl_tree_t *, void *item)
    void avl_foreach(avl_tree_t *, avl_foreach_t, void *)
    unsigned int avl_count(avl_tree_t *)
    avl_node_t *avl_at(avl_tree_t *, unsigned int)
    unsigned int avl_index(avl_node_t *)
    void avl_to_array (avl_tree_t *, sc_array_t *)
    SC_EXTERN_C_END
