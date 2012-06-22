from _c_sc cimport *

cdef extern from "sc_c99_functions.h" nogil:
    enum: SC_C99_FUNCTIONS_H
    enum: UINT32_MAX
    enum: restrict

    int fsync (int fd)
    int fileno (FILE * stream)
    FILE *fopen (char *path, char *mode)
    FILE *fdopen (int fd, char *mode)
    int mkstemp (char *template)
    intmax_t imaxabs (intmax_t)
    long long int strtoll (char *nptr, char **endptr, int base)
    intmax_t imaxabs (intmax_t a)
