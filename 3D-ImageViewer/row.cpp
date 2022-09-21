#include<iostream>
#include<exception>
#include "row.h"
using namespace std;

// parameterized constructor
Row::Row(unsigned int length){
	//Basic initalization
	this->length = length;
	this->row_data = new double[this->length];
	clear();
}

// copy constructor
Row::Row(const Row& from){
	//First, initalizes the array
	this->row_data = new double[from.length];
	//Then set the values
	for(int i = 0; i < from.length; i++){
		this->row_data[i] = from.row_data[i];
	}
	this->length = from.length;
}

// destructor
Row::~Row(){
	delete[] row_data;
}

// access operator (const)
double Row::operator[](unsigned int column) const{
	//Catching if it is positive, or if it is too big
	if(column < 0 || column+1 > this->length){
		throw out_of_range("Column is invalid");
	}
	//finish
	double result;

	result = this->row_data[column];
	
	return result;
}

// access operator (non-const)
double& Row::operator[](unsigned int column){
	//Catching if it is positive, or if it is too big
	if(column < 0 || column+1 > this->length){
		throw overflow_error("Column is invalid");
	}

	return this->row_data[column];
}

// assignment operator
Row& Row::operator= (const Row& rhs){
	//Check if the rhs is this
	if(this != &rhs){
		if(this->length != rhs.length){
			delete[] this->row_data;
			this->length = rhs.length;
			this->row_data = new double[this->length];
		}
		for (int i = 0; i < length; ++i){
			this->row_data[i] = rhs.row_data[i];
		}
	}
	return *this;
}

// clear row data
void Row::clear(){
	for(int i = 0; i < length; i++){
		this->row_data[i] = 0;
	}
}