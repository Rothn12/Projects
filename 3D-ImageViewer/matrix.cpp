#include "matrix.h"
#include "row.h"
#include<iomanip>
using namespace std;

// constructor
Matrix::Matrix(unsigned int rows, unsigned int cols){
	if(rows < 1 || cols < 1){ 
		throw(out_of_range("rows and cols must be greater than 0"));
	}
	this->rows = rows;
	this->cols = cols;
	this->the_matrix = new Row*[rows];
	for(int i = 0; i < rows; i++){
		this->the_matrix[i]=new Row(cols);
	}
	clear();
 }
 
// Copy constructor
Matrix::Matrix(const Matrix& from){
	this->rows = from.rows;
	this->cols = from.cols;
	this->the_matrix = new Row*[this->rows];
	for(int i = 0; i < this->rows; i++){
		this->the_matrix[i] = new Row(this->cols);
	}
	for(int i = 0; i < from.rows; i++){
		for(int j = 0; j < from.cols; j++){
			(*this)[i][j]=(*(from.the_matrix[i]))[j];
		}
	}
}

// Destructor
Matrix::~Matrix(){
	for(int i = 0; i < rows; i++){
		delete the_matrix[i];
	}
	delete[] the_matrix;
 }
 
// Assignment operator
Matrix& Matrix::operator=(const Matrix& rhs){
	if(this != &rhs){
		for(int i = 0; i < rows; i++){
			delete the_matrix[i];
		}
		delete[] the_matrix;
		the_matrix = new Row*[rhs.rows];
		this->rows = rhs.rows;
		this->cols = rhs.cols;
		for(int i = 0; i < rhs.rows; i++){
			the_matrix[i] = new Row(rhs.cols);
		}
		for(int i = 0; i < rhs.rows; i++){
			for(int j = 0; j < rhs.cols; j++){
				(*this)[i][j]=(*(rhs.the_matrix[i]))[j];
			}
		}
	}

	return *this;
}	
 
// Named Constructor 
Matrix Matrix::identity(unsigned int size){
	//set diagonals to 1
	Matrix result(size, size);
	for(int i = 0; i < size; i++){
		for(int j =0; j < size; j++){
			if(i==j){
				result[i][j] = 1;
			}
		}
	}
	return result;
}	
		
// Matrix addition
Matrix Matrix::operator+(const Matrix& rhs) const{
	Matrix result(this->rows, this->cols);
	if(rhs.cols == this->cols && rhs.rows == this->rows){
		for(int i = 0; i < this->rows; i++){
			for(int j = 0; j < this->cols; j++){
				result[i][j] = (*this)[i][j]+(*(rhs.the_matrix[i]))[j];
			}
		}
	}
	return result;
}
 
// Matrix multiplication 
Matrix Matrix::operator*(const Matrix& rhs) const{
	Matrix result(this->rows, rhs.cols);
	if(rhs.rows == this->cols){
		for(int i = 0; i < this->rows; i++){
			for(int j = 0; j < rhs.cols; j++){
				double element = 0;
				for(int k = 0; k < rhs.rows; k++){
					element += (*this)[i][k]*(*(rhs.the_matrix[k]))[j];
				}
				result[i][j] = element;
			}
		}	
	}
	return result;
}
 
// Scalar multiplication
Matrix Matrix::operator*(const double scale) const{
	Matrix result(this->rows, this->cols);
	for(int i = 0; i < this->rows; i++){
		for(int j = 0; j < this->cols; j++){
			result[i][j] = (*this)[i][j]*scale;
		}
	}
	return result;
}

// Transpose of a Matrix
//Rows become cols, cols become rows. Thing at [i][j] becomes thing at [j][i]
Matrix Matrix::operator~() const{
	Matrix result(this->rows, this->cols);
	for(int i = 0; i < this->rows; i++){
		for(int j = 0; j < this->cols; j++){
			result[i][j] = (*this)[j][i];
		}
	}
	return result;
}
 
// Clear Matrix
void Matrix::clear(){
	for(int i = 0; i < this->rows; i++){
		for(int j = 0; j < this->cols; j++){
			(*this)[i][j]=0;
		}
	}
}
  
// Access Operators - non-const
Row& Matrix::operator[](unsigned int row){
	if(row < 0 || row+1 > this->rows){
		throw overflow_error("Row/Col is invalid");
	}
	return *(the_matrix[row]);
}
 
// Access Operators - const
const Row& Matrix::operator[](unsigned int row) const{
	if(row < 0 || row+1 > this->rows){
		throw overflow_error("Row/Col is invalid");
	}
	return *(the_matrix[row]);
}
 
// print to output stream
void Matrix::out(std::ostream& os) const{
	for(int i = 0; i < this->rows; i++){
		for(int j = 0; j < this->cols; j++){
			os << setprecision(4);
			os << setw(10);
			os << (*this)[i][j];
		}
		os<<endl;
	}
}

// global insertion operator
std::ostream& operator<<(std::ostream& os, const Matrix& rhs){
	rhs.out(os);
	return os;
}	

// global scalar multiplication
Matrix operator*(const double scale, const Matrix& rhs){
	return rhs*scale;
}