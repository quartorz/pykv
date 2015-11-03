cdef extern from 'wrappers.hpp' namespace 'wrappers':
    cdef cppclass kv_interval:
        kv_interval()
        kv_interval(double inf, double sup)
        kv_interval(double x)
        kv_interval(string &x)

        kv_interval operator-()

        kv_interval operator+(const kv_interval &)
        kv_interval operator-(const kv_interval &)
        kv_interval operator*(const kv_interval &)
        kv_interval operator/(const kv_interval &)

        kv_interval operator+(double)
        kv_interval operator-(double)
        kv_interval operator*(double)
        kv_interval operator/(double)

        # not yet supported at Cython 0.23.4
        # kv_interval operator+=(const kv_interval &)
        # kv_interval operator-=(const kv_interval &)
        # kv_interval operator*=(const kv_interval &)
        # kv_interval operator/=(const kv_interval &)

        # not yet supported at Cython 0.23.4
        # kv_interval operator+=(double)
        # kv_interval operator-=(double)
        # kv_interval operator*=(double)
        # kv_interval operator/=(double)

        double &lower()
        double &upper()

    void set_lower(kv_interval &, double)
    void set_upper(kv_interval &, double)


cdef extern from '<kv/interval.hpp>':
    kv_interval abs(const kv_interval &)
    double kv_width'width'(const kv_interval &)
    double kv_rad'rad'(const kv_interval &)
    double kv_mid'mid'(const kv_interval &)
    double kv_median'median'(const kv_interval &)
    double kv_norm'norm'(const kv_interval &)
    double kv_mag'mag'(const kv_interval &)
    bool kv_in'in'(const double &, const kv_interval &)
    bool kv_zero_in'zero_in'(const kv_interval &)
    bool kv_subset'subset'(const kv_interval &, const kv_interval &)
    bool kv_proper_subset'proper_subset'(const kv_interval &, const kv_interval &)
    bool kv_overlap'overlap'(const kv_interval &, const kv_interval &)
    kv_interval kv_intersect'intersect'(const kv_interval &, const kv_interval &)


ctypedef kv_interval interval_t


cdef class interval(object):
    cdef interval_t *thisptr


    def __init__(self, *args):
        if len(args) == 0:
            self.thisptr = new interval_t()
        elif len(args) == 1:
            if isinstance(args[0], str):
                self.thisptr = new interval_t(<string>args[0].encode('utf-8'))
            elif isinstance(args[0], bytes):
                self.thisptr = new interval_t(<string>args[0])
            else:
                self.thisptr = new interval_t(<double>args[0])
        elif len(args) == 2:
            self.thisptr = new interval_t(<double>args[0], <double>args[1])


    def __dealloc__(self):
        del self.thisptr


    def __repr__(self):
        return 'pykv.interval({0}, {1})'.format(self.inf, self.sup)


    def __str__(self):
        return '[{0}, {1}]'.format(self.inf, self.sup)


    def __neg__(self):
        self.thisptr[0] = -deref(self.thisptr)


    def __add__(self, other not None):
        cdef interval_t result

        if isinstance(other, interval):
            result = deref((<interval>self).thisptr) + \
                     deref((<interval>other).thisptr)
        else:
            result = deref((<interval>self).thisptr) + <double>other

        return interval(result.lower(), result.upper())


    def __sub__(self, other not None):
        cdef interval_t result

        if isinstance(other, interval):
            result = deref((<interval>self).thisptr) - \
                     deref((<interval>other).thisptr)
        else:
            result = deref((<interval>self).thisptr) - <double>other

        return interval(result.lower(), result.upper())


    def __mul__(self, other not None):
        cdef interval_t result

        if isinstance(other, interval):
            result = deref((<interval>self).thisptr) * \
                     deref((<interval>other).thisptr)
        else:
            result = deref((<interval>self).thisptr) * <double>other

        return interval(result.lower(), result.upper())


    def __div__(self, other not None):
        cdef interval_t result

        if isinstance(other, interval):
            result = deref((<interval>self).thisptr) / \
                     deref((<interval>other).thisptr)
        else:
            result = deref((<interval>self).thisptr) / <double>other

        return interval(result.lower(), result.upper())


    def __iadd__(self, other not None):
        if isinstance(other, interval):
            self.thisptr[0] = deref(self.thisptr) + \
                              deref((<interval>other).thisptr)
        else:
            self.thisptr[0] = deref(self.thisptr) + <double>other


    def __isub__(self, other not None):
        if isinstance(other, interval):
            self.thisptr[0] = deref(self.thisptr) - \
                              deref((<interval>other).thisptr)
        else:
            self.thisptr[0] = deref(self.thisptr) - <double>other


    def __imul__(self, other not None):
        if isinstance(other, interval):
            self.thisptr[0] = deref(self.thisptr) * \
                              deref((<interval>other).thisptr)
        else:
            self.thisptr[0] = deref(self.thisptr) * <double>other


    def __idiv__(self, other not None):
        if isinstance(other, interval):
            self.thisptr[0] = deref(self.thisptr) / \
                              deref((<interval>other).thisptr)
        else:
            self.thisptr[0] = deref(self.thisptr) / <double>other


    def __abs__(self):
        cdef interval_t result = abs(deref(self.thisptr))
        return interval(result.lower(), result.upper())


    property inf:
        def __get__(self):
            return self.thisptr.lower()
        def __set__(self, x not None):
            set_lower(deref(self.thisptr), <double>x)


    property sup:
        def __get__(self):
            return self.thisptr.upper()
        def __set__(self, x not None):
            set_upper(deref(self.thisptr), <double>x)


    property width:
        def __get__(self):
            return width(self)


def width(interval i not None):
    return kv_width(deref(i.thisptr))


def rad(interval i not None):
    return kv_rad(deref(i.thisptr))


def mid(interval i not None):
    return kv_mid(deref(i.thisptr))


def median(interval i not None):
    return kv_median(deref(i.thisptr))


def norm(interval i not None):
    return kv_norm(deref(i.thisptr))


def mag(interval i not None):
    return kv_mag(deref(i.thisptr))


def _in(double a, interval i not None):
    return kv_in(a, deref(i.thisptr))


def zero_in(interval i not None):
    return kv_zero_in(deref(i.thisptr))


def subset(interval x not None, interval y not None):
    return kv_subset(deref(x.thisptr), deref(y.thisptr))


def overlap(interval x not None, interval y not None):
    return kv_overlap(deref(x.thisptr), deref(y.thisptr))


def intersect(interval x not None, interval y not None):
    cdef interval_t result = kv_intersect(deref(x.thisptr), deref(y.thisptr))
    return interval(result.lower(), result.upper())
