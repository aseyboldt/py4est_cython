from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

import mpi4py

setup(
    name='py4est',
    packages=['py4est'],
    package_dir = {'': 'src'},
    cmdclass = {'build_ext': build_ext},
    ext_modules = [Extension("py4est._py4est", 
                             ["src/py4est_cython.pyx"],
                             include_dirs=[mpi4py.get_include(),
                                           '/usr/include',
                                           '/usr/local/include',
                                           '/home/adr/Programme/p4est/p4est/local/include',
                                           'src',
                                           '/usr/include/mpi'],
                             libraries=['p4est', 'sc'],
                             library_dirs=['/home/adr/Programme/p4est/p4est/local/lib'])]

)
        
