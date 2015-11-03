#!python
# -*- coding; utf-8 -*-
# distutils: language = c++
# cython: boundscheck = False


from __future__ import unicode_literals


from libcpp cimport bool
from libcpp.string cimport string
from cython.operator cimport dereference as deref
import numpy as np
cimport numpy as np


include 'ublas.pxi'

include 'ode_lohner.pxi'
