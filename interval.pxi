cdef extern from 'wrappers.hpp':
    cdef cppclass kv_interval:
        kv_interval()
        kv_interval(double inf, double sup)
        kv_interval(double x)
        kv_interval(string &x)

        kv_interval operator+(const kv_interval &)
        kv_interval operator-(const kv_interval &)
        kv_interval operator*(const kv_interval &)
        kv_interval operator/(const kv_interval &)

        kv_interval operator+(float)
        kv_interval operator-(float)
        kv_interval operator*(float)
        kv_interval operator/(float)


ctypedef kv_interval interval_t


cdef class interval(object):
    cdef interval_t *thisptr

    def __init__(self, *args):
        if len(args) == 0:
            self.thisptr = new interval_t()
        elif len(args) == 1:
            if isinstance(args[0], str):
                self.thisptr = new interval_t(<string>args[0].encode('utf-8'))
            else:
                self.thisptr = new interval_t(<double>args[0])
        elif len(args) == 2:
            self.thisptr = new interval_t(<double>args[0], <double>args[1])

    def __dealloc__(self):
        del self.thisptr
