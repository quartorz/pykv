#! python

from distutils.core import setup, Extension
from Cython.Distutils import build_ext
from Cython.Build import cythonize
import numpy as np

setup(
    name='pykv',
    version='0.0.4',
    description='wrapper library for kv',
    author='',
    ext_modules=[
        Extension(
            'pykv.pykv',
            sources=['pykv/pykv/__init__.pyx'],
            include_dirs=['./pykv', './include', np.get_include()],
            language='c++'
        ),
        Extension(
            'pykv.ode',
            sources=['pykv/ode/__init__.pyx'],
            include_dirs=['./pykv', './include', np.get_include()],
            language='c++'
        ),
    ],
    packages=['pykv', 'pykv.pykv', 'pykv.ode'],
    cmdclass={'build_ext': build_ext},
)
