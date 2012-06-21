from _c_sc cimport *
from _c_sc_containers cimport *

cdef extern from "sc_io.h" nogil:
    enum: SC_IO_H

    enum sc_io_error_t:
        SC_IO_ERROR_NONE
        SC_IO_ERROR_FATAL = -1
        SC_IO_ERROR_AGAIN = -2 
    enum sc_io_mode_t:
        SC_IO_MODE_WRITE
        SC_IO_MODE_APPEND
        SC_IO_MODE_LAST 
    enum sc_io_encode_t:
        SC_IO_ENCODE_NONE
        SC_IO_ENCODE_LAST 
    enum sc_io_type_t:
        SC_IO_TYPE_BUFFER
        SC_IO_TYPE_FILENAME
        SC_IO_TYPE_FILEFILE
        SC_IO_TYPE_LAST 
    cdef struct sc_io_sink:
        sc_io_type_t iotype
        sc_io_mode_t mode
        sc_io_encode_t encode
        sc_array_t *buffer
        size_t buffer_bytes
        FILE *file
        size_t bytes_in
        size_t bytes_out
    ctypedef sc_io_sink sc_io_sink_t
    cdef struct sc_io_source:
        sc_io_type_t iotype
        sc_io_encode_t encode
        sc_array_t *buffer
        size_t buffer_bytes
        FILE *file
        size_t bytes_in
        size_t bytes_out
    ctypedef sc_io_source sc_io_source_t
    sc_io_sink_t *sc_io_sink_new (sc_io_type_t iotype, sc_io_mode_t mode, sc_io_encode_t encode, ...)
    int sc_io_sink_destroy (sc_io_sink_t * sink)
    int sc_io_sink_write (sc_io_sink_t * sink, void *data, size_t bytes_avail)
    int sc_io_sink_complete (sc_io_sink_t * sink, size_t * bytes_in, size_t * bytes_out)
    sc_io_source_t *sc_io_source_new (sc_io_type_t iotype, sc_io_encode_t encode, ...)
    int sc_io_source_destroy (sc_io_source_t * source)
    int sc_io_source_read (sc_io_source_t * source, void *data, size_t bytes_avail, size_t * bytes_out)
    int sc_io_source_complete (sc_io_source_t * source, size_t * bytes_in, size_t * bytes_out)
    int sc_vtk_write_binary (FILE * vtkfile, char *numeric_data, size_t byte_length)
    int sc_vtk_write_compressed (FILE * vtkfile, char *numeric_data, size_t byte_length)
    void sc_fwrite (void *ptr, size_t size, size_t nmemb, FILE * file, char *errmsg)
    void sc_fread (void *ptr, size_t size, size_t nmemb, FILE * file, char *errmsg)
    void sc_mpi_write (MPI_File mpifile, void *ptr, size_t zcount, MPI_Datatype t, char *errmsg)

