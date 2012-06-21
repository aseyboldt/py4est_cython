from _c_sc cimport *
from _c_lua cimport *
from _c_lualib cimport *
from _c_lauxlib cimport *
from lua5.1._c_lua cimport *
from lua5.1._c_lualib cimport *
from lua5.1._c_lauxlib cimport *

cdef extern from "sc_lua.h" nogil:
    enum: SC_LUA_H
    enum: LUA_USE_LINUX

    SC_EXTERN_C_BEGIN
    SC_EXTERN_C_END
