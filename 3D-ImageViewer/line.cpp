#include <iostream>
#include "line.h"
using namespace std;

Line::Line(){
	color = 0;
	for(int i = 0; i<3; i++){
		points0[i][0] = 0;
		points1[i][0] = 0;
	}
	points0[3][0] = 1.0;
	points1[3][0] = 1.0;
}

Line::Line(unsigned int color, double x0, double y0, double x1, double y1){
	this->color = color;
	points0[0][0] = x0;
	points0[1][0] = y0;
	points0[2][0] = 0;
	points0[3][0] = 1;
	points1[0][0] = x1;
	points1[1][0] = y1;
	points1[2][0] = 0;
	points1[3][0] = 1.0;
}

Line::Line(const Line& from){
	this->color = from.color;
	this->points0[0][0] = from.points0[0][0];
	this->points0[1][0] = from.points0[1][0];
	this->points0[2][0] = 0;
	this->points0[3][0] = 1;
	this->points1[0][0] = from.points1[0][0];
	this->points1[1][0] = from.points1[1][0];
	this->points1[2][0] = 0;
	this->points1[3][0] = 1.0;
}

Line::~Line(){
}

void Line::draw(GraphicsContext* gc, ViewContext* VC)const{
	gc->setColor(color);
	Matrix temp0 = VC->model_to_device(points0);
	Matrix temp1 = VC->model_to_device(points1);
	gc->drawLine(temp0[0][0], temp0[1][0], temp1[0][0], temp1[1][0]);
}

void Line::draw(GraphicsContext* gc, ViewContext* VC, double f, double zv)const{}
void Line::draw(GraphicsContext* gc, ViewContext* VC, double f, double zv, Matrix composite)const{}

void Line::draw_mat(GraphicsContext* gc, ViewContext* VC, Matrix composite)const{
	gc->setColor(color);
	Matrix temp0 = VC->applyMatrix(points0, composite);
	Matrix temp1 = VC->applyMatrix(points1, composite);
	gc->drawLine(temp0[0][0], temp0[1][0], temp1[0][0], temp1[1][0]);
}

void Line::out(ostream& os)const{
	os<<"Color: "<<color<<endl;
	os<<"Line: "<<points0[0][0]<<" "<<points0[1][0]<<" "<<points1[0][0]<<" "<<points1[1][0]<<endl;
}

void Line::out(std::ostream& os, Matrix composite)const{
	Matrix temp0 = composite*points0;
	Matrix temp1 = composite*points1;
	os<<"Color: "<<color<<endl;
	os<<"Line: "<<temp0[0][0]<<" "<<temp0[1][0]<<" "<<temp1[0][0]<<" "<<temp1[1][0]<<endl;;
}

Line* Line::clone()const{
	return new Line(color, points0[0][0], points0[1][0], points1[0][0], points1[1][0]);
}

Line& Line::operator=(const Line& rhs){
	this->color = rhs.color;
	this->points0[0][0] = rhs.points0[0][0];
	this->points0[1][0] = rhs.points0[1][0];
	this->points0[2][0] = 0;
	this->points0[3][0] = 1.0;
	this->points1[0][0] = rhs.points1[0][0];
	this->points1[1][0] = rhs.points1[1][0];
	this->points1[2][0] = 0;
	this->points1[3][0] = 1.0;
	return *this;
}