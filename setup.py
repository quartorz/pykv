#! python

from distutils.core import setup, Extension
from Cython.Distutils import build_ext
from Cython.Build import cythonize

setup(
        name='pykv',
        version='0.0.2',
        description='wrapper library for kv',
        author='',
        ext_modules=cythonize(
            Extension(
                'pykv',
                sources=['pykv.pyx'],
                include_dirs=['./include']
                )
            ),
            language='c++'
        )
