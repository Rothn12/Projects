#include <iostream>
#include "shape.h"
using namespace std;

//Default constructor 
Shape::Shape(){
	color = 0;
}

//Parameterized constructor
Shape::Shape(unsigned int color){
	this->color = color;
}

Shape::Shape(const Shape& from){
	this->color = from.color;
}

//Destructor
Shape::~Shape(){}

Shape& Shape::operator=(const Shape& rhs){
	this->color = rhs.color;
	return *this;
}