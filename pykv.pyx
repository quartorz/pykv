#!python
# -*- coding; utf-8 -*-
# distutils: language = c++
# cython: boundscheck = False


from __future__ import unicode_literals


from libcpp cimport bool
from libcpp.string cimport string
from cython.operator cimport dereference as deref


include 'interval.pxi'
