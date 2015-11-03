cdef extern from '<boost/numeric/ublas/vector.hpp>' \
        namespace 'boost::numeric::ublas':
    cdef cppclass vector[T]:
        vector(unsigned size)
        T &operator()(unsigned)
        unsigned size()
        bool empty()
        void erase_element(unsigned)
        void clear()
        void swap(vector &)


cdef extern from '<boost/numeric/ublas/matrix.hpp>' \
        namespace 'boost::numeric::ublas':
    cdef cppclass matrix[T]:
        matrix(unsigned, unsigned)
        T &operator()(unsigned, unsigned)
        unsigned size1()
        unsigned size2()
        void swap(matrix &)
        void erase_element(unsigned, unsigned)
