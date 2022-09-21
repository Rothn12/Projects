#ifndef matrix_h
#define matrix_h
 
#include <iostream> 
#include "row.h"
class Matrix
{
	public:
		// No default (no argument) constructor.  It doesn't really make
		// sense to have one as we cannot rely on a size.  This may trip
		// us up later, but it will lead to a better implementation.
		// matrix();
 
		// Constructor - create Matrix and clear cells.  If rows or
		// cols is < 1, throw an exception
		Matrix(unsigned int rows, unsigned int cols);
 
		// Copy constructor - make a new Matrix just like rhs
		Matrix(const Matrix& from);
 
		// Destructor.  Free allocated memory
		~Matrix();
 
		// Assignment operator - make this just like rhs.  Must function
        	// correctly even if rhs is a different size than this.
		Matrix& operator=(const Matrix& rhs);
 
		// Named Constructor - produce a square identity matrix of the
		// requested size.  Since we do not know how the object produced will
		// be used, we pretty much have to return by value.  A size of 0 
		// would not make sense and should throw an exception.
		static Matrix identity(unsigned int size);
 
		// Matrix addition - lhs and rhs must be same size otherwise
		// an exception shall be thrown
		Matrix operator+(const Matrix& rhs) const;
 
		// Matrix multiplication - lhs and rhs must be compatible 
		// otherwise an exception shall be thrown
		Matrix operator*(const Matrix& rhs) const;
 
		// Scalar multiplication.  Note, this function will support
		// someMatrixObject * 5.0, but not 5.0 * someMatrixObject.
		Matrix operator*(const double scale) const;

		// Transpose of a Matrix - should always work, hence no exception
		Matrix operator~() const;
 
		// Clear Matrix to all members 0.0
		void clear();
  
		// Access Operators - throw an exception if index out of range
		Row& operator[](unsigned int row);
 
		// const version of above - throws an exception if indices are out of
		// range
		const Row& operator[](unsigned int row) const;
 
		// I/O - for convenience - this is intended to be called by the global
		// << operator declared below.
		void out(std::ostream& os) const;
		
	private:
		// An array of Row pointers size "rows" that each point to a double array
		// of size "cols"
		Row** the_matrix;
		unsigned int rows;
		unsigned int cols;

		/** routines **/

		// add any "helper" routine here, such as routines to support
		// matrix inversion

};

/** Some Related Global Functions **/
 
// Overloaded global << with std::ostream as lhs, Matrix as rhs.  This method
// should generate output compatible with an ostream which is commonly used
// with console (cout) and files.  Something like:
// [[ r0c0, r0c1, r0c2 ]
//  [ r1c0, r1c1, r1c2 ]
//  [ r0c0, r0c1, r0c2 ]]
// would be appropriate.
//
// Since this is a global function, it does not have access to the private
// data of a Matrix object.  So, it will need to use the public interface of
// Matrix to do its job.  The method Matrix::out was added to Matrix
// specifically for this purpose.  The other option would have been to make
// it a "friend"
std::ostream& operator<<(std::ostream& os, const Matrix& rhs);
 
// We would normally have a corresponding >> operator, but
// will defer that exercise that until a later assignment.


// Scalar multiplication with a global function.  Note, this function will
// support 5.0 * someMatrixObject, but not someMatrixObject * 5.0
Matrix operator*(const double scale, const Matrix& rhs);

#endif
// Based on lab by Dr. Darrin Rothe ((c) 2015 Dr. Darrin Rothe)
