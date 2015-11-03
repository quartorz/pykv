#!python
# -*- coding; utf-8 -*-
# distutils: language = c++
# cython: boundscheck = False

from libcpp.string cimport string
from cython.operator cimport dereference as deref

include 'interval.pxi'
