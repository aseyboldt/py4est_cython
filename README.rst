This is an unfinished and unofficial python wrapper for
the p4est libray (https://github.com/cburstedde/p4est)
another one can be found at https://github.com/cburstedde/py4est
(I should probably think of another name...)

build
=====

::
  
   ./bentomaker configure
   ./bentomaker build

Right now it assumes (and does not check) that p4est and sc have
been build with mpi and without blas. Something along the line of

::

   ./configure --without-blas --enable-mpi --enable-shared
   
before building py4est you might have to set LD_LIBRARY_PATH and
INCLUDES appropriately

It depends on mpi4py and cython.


Tests
=====

Just run nosetests in the root directory

