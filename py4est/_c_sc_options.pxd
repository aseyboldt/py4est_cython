from _c_sc_containers cimport *

cdef extern from "sc_options.h" nogil:
    enum: SC_OPTIONS_H

    SC_EXTERN_C_BEGIN
    enum sc_option_type_t:
        SC_OPTION_SWITCH
        SC_OPTION_INT
        SC_OPTION_DOUBLE
        SC_OPTION_STRING
        SC_OPTION_INIFILE
        SC_OPTION_CALLBACK 
    ctypedef struct sc_option_item_t:
        sc_option_type_t opt_type
        int opt_char
        char *opt_name
        void *opt_var
        void (*opt_fn) ()
        int has_arg
        int called
        char *help_string
        char *string_value
        void *user_data
    ctypedef struct sc_options_t:
        char program_path[BUFSIZ]
        char *program_name
        sc_array_t *option_items
        int args_alloced
        int first_arg
        int argc
        char **argv
        sc_array_t *subopt_names
    ctypedef int (*sc_options_callback_t) (sc_options_t * opt, char *optarg, void *data)
    sc_options_t *sc_options_new (char *program_path)
    void sc_options_destroy (sc_options_t * opt)
    void sc_options_add_switch (sc_options_t * opt, int opt_char, char *opt_name, int *variable, char *help_string)
    void sc_options_add_int (sc_options_t * opt, int opt_char, char *opt_name, int *variable, int init_value, char *help_string)
    void sc_options_add_double (sc_options_t * opt, int opt_char, char *opt_name, double *variable, double init_value, char *help_string)
    void sc_options_add_string (sc_options_t * opt, int opt_char, char *opt_name, char **variable, char *init_value, char *help_string)
    void sc_options_add_inifile (sc_options_t * opt, int opt_char, char *opt_name, char *help_string)
    void sc_options_add_callback (sc_options_t * opt, int opt_char, char *opt_name, int has_arg, sc_options_callback_t fn, void *data, char *help_string)
    void sc_options_add_suboptions (sc_options_t * opt, sc_options_t * subopt, char *prefix)
    void sc_options_print_usage (int package_id, int log_priority, sc_options_t * opt, char *arg_usage)
    void sc_options_print_summary (int package_id, int log_priority, sc_options_t * opt)
    int sc_options_load (int package_id, int err_priority, sc_options_t * opt, char *inifile)
    int sc_options_save (int package_id, int err_priority, sc_options_t * opt, char *inifile)
    int sc_options_parse (int package_id, int err_priority, sc_options_t * opt, int argc, char **argv)
    int sc_options_load_args (int package_id, int err_priority, sc_options_t * opt, char *inifile)
    SC_EXTERN_C_END
