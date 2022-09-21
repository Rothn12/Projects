#include <iostream>
#include "triangle.h"
using namespace std;

Triangle::Triangle(){
	color = 0;
	for(int i = 0; i<3; i++){
		points0[i][0] = 0;
		points1[i][0] = 0;
		points2[i][0] = 0;
	}
	points0[3][0] = 1.0;
	points1[3][0] = 1.0;
	points2[3][0] = 1.0;
}

Triangle::Triangle(unsigned int color, double x0, double y0, double x1, double y1, double x2, double y2){
	this->color = color;
	points0[0][0] = x0;
	points0[1][0] = y0;
	points0[2][0] = 0;
	points0[3][0] = 1.0;
	points1[0][0] = x1;
	points1[1][0] = y1;
	points1[2][0] = 0;
	points1[3][0] = 1.0;
	points2[0][0] = x2;
	points2[1][0] = y2;
	points2[2][0] = 0;
	points2[3][0] = 1.0;
}

Triangle::Triangle(unsigned int color, double x0, double y0, double z0, double x1, double y1, double z1, double x2, double y2, double z2){
	this->color = color;
	points0[0][0] = x0;
	points0[1][0] = y0;
	points0[2][0] = z0;
	points0[3][0] = 1.0;
	points1[0][0] = x1;
	points1[1][0] = y1;
	points1[2][0] = z1;
	points1[3][0] = 1.0;
	points2[0][0] = x2;
	points2[1][0] = y2;
	points2[2][0] = z2;
	points2[3][0] = 1.0;
}

Triangle::Triangle(const Triangle& from){
	this->color = from.color;
	this->points0[0][0] = from.points0[0][0];
	this->points0[1][0] = from.points0[1][0];
	this->points0[2][0] = from.points0[2][0];
	this->points0[3][0] = 1.0;
	this->points1[0][0] = from.points1[0][0];
	this->points1[1][0] = from.points1[1][0];
	this->points1[2][0] = from.points1[2][0];
	this->points1[3][0] = 1.0;
	this->points2[0][0] = from.points2[0][0];
	this->points2[1][0] = from.points2[1][0];
	this->points2[2][0] = from.points2[2][0];
	this->points2[3][0] = 1.0;
}

Triangle::~Triangle(){
}

void Triangle::draw(GraphicsContext *gc, ViewContext* VC)const{
	gc->setColor(color);
	Matrix temp0 = VC->model_to_device(points0);
	Matrix temp1 = VC->model_to_device(points1);
	Matrix temp2 = VC->model_to_device(points2);
	gc->drawLine(temp0[0][0], temp0[1][0], temp1[0][0], temp1[1][0]);
	gc->drawLine(temp1[0][0], temp1[1][0], temp2[0][0], temp2[1][0]);
	gc->drawLine(temp2[0][0], temp2[1][0], temp0[0][0], temp0[1][0]);
}

void Triangle::draw_mat(GraphicsContext *gc, ViewContext* VC, Matrix composite)const{
	gc->setColor(color);
	Matrix temp0 = VC->applyMatrix(points0, composite);
	Matrix temp1 = VC->applyMatrix(points1, composite);
	Matrix temp2 = VC->applyMatrix(points2, composite);
	gc->drawLine(temp0[0][0], temp0[1][0], temp1[0][0], temp1[1][0]);
	gc->drawLine(temp1[0][0], temp1[1][0], temp2[0][0], temp2[1][0]);
	gc->drawLine(temp2[0][0], temp2[1][0], temp0[0][0], temp0[1][0]);

}

void Triangle::draw(GraphicsContext* gc, ViewContext*VC, double f, double zv)const{
	gc->setColor(color);
	Matrix temp0 = points0;
	temp0[0][0]=(temp0[0][0]*f)/(temp0[2][0]-zv+f);
	temp0[1][0]=(temp0[1][0]*f)/(temp0[2][0]-zv+f);
	Matrix temp1 = points1;
	temp1[0][0]=(temp1[0][0]*f)/(temp1[2][0]-zv+f);
	temp1[1][0]=(temp1[1][0]*f)/(temp1[2][0]-zv+f);
	Matrix temp2 = points2;
	temp2[0][0]=(temp2[0][0]*f)/(temp2[2][0]-zv+f);
	temp2[1][0]=(temp2[1][0]*f)/(temp2[2][0]-zv+f);
	temp0 = VC->model_to_device(temp0);
	temp1 = VC->model_to_device(temp1);
	temp2 = VC->model_to_device(temp2);
	gc->drawLine(temp0[0][0], temp0[1][0], temp1[0][0], temp1[1][0]);
	gc->drawLine(temp1[0][0], temp1[1][0], temp2[0][0], temp2[1][0]);
	gc->drawLine(temp2[0][0], temp2[1][0], temp0[0][0], temp0[1][0]);
}

void Triangle::draw(GraphicsContext* gc, ViewContext*VC, double f, double zv, Matrix composite)const{
	bool u1;
	bool d1;
	bool r1;
	bool l1;
	bool u2;
	bool d2;
	bool r2;
	bool l2;
	gc->setColor(color);
	Matrix temp0 = points0;
	temp0[0][0]=(temp0[0][0]*f)/(temp0[2][0]-zv+f);
	temp0[1][0]=(temp0[1][0]*f)/(temp0[2][0]-zv+f);
	Matrix temp1 = points1;
	temp1[0][0]=(temp1[0][0]*f)/(temp1[2][0]-zv+f);
	temp1[1][0]=(temp1[1][0]*f)/(temp1[2][0]-zv+f);
	Matrix temp2 = points2;
	temp2[0][0]=(temp2[0][0]*f)/(temp2[2][0]-zv+f);
	temp2[1][0]=(temp2[1][0]*f)/(temp2[2][0]-zv+f);

	temp0 = VC->applyMatrix(temp0, composite);
	temp1 = VC->applyMatrix(temp1, composite);
	temp2 = VC->applyMatrix(temp2, composite);

	u1 = temp0[1][0] > gc->getWindowHeight();
	d1 = temp0[1][0] < 0; 
	r1 = temp0[0][0] > gc->getWindowWidth();
	l1 = temp0[0][0] < 0;
	u2 = temp1[1][0] > gc->getWindowHeight();
	d2 = temp1[1][0] < 0; 
	r2 = temp1[0][0] > gc->getWindowWidth();
	l2 = temp1[0][0] < 0;

	u1 = u1 and u2;
	d1 = d1 and d2;
	r1 = r1 and r2;
	l1 = l1 and l2;

	if((!u1)&&(!d1)&&(!r1)&&(!l1)){
		gc->drawLine(temp0[0][0], temp0[1][0], temp1[0][0], temp1[1][0]);
	}

	u1 = temp1[1][0] > gc->getWindowHeight();
	d1 = temp1[1][0] < 0; 
	r1 = temp1[0][0] > gc->getWindowWidth();
	l1 = temp1[0][0] < 0;
	u2 = temp2[1][0] > gc->getWindowHeight();
	d2 = temp2[1][0] < 0; 
	r2 = temp2[0][0] > gc->getWindowWidth();
	l2 = temp2[0][0] < 0;

	u1 = u1 and u2;
	d1 = d1 and d2;
	r1 = r1 and r2;
	l1 = l1 and l2;

	if((!u1)&&(!d1)&&(!r1)&&(!l1)){
		gc->drawLine(temp1[0][0], temp1[1][0], temp2[0][0], temp2[1][0]);
	}

	u1 = temp2[1][0] > gc->getWindowHeight();
	d1 = temp2[1][0] < 0; 
	r1 = temp2[0][0] > gc->getWindowWidth();
	l1 = temp2[0][0] < 0;
	u2 = temp0[1][0] > gc->getWindowHeight();
	d2 = temp0[1][0] < 0; 
	r2 = temp0[0][0] > gc->getWindowWidth();
	l2 = temp0[0][0] < 0;

	u1 = u1 and u2;
	d1 = d1 and d2;
	r1 = r1 and r2;
	l1 = l1 and l2;

	if((!u1)&&(!d1)&&(!r1)&&(!l1)){
		gc->drawLine(temp2[0][0], temp2[1][0], temp0[0][0], temp0[1][0]);
	}
}

void Triangle::out(std::ostream& os)const{
	os<<"  outer loop"<<endl;
	os<<"  vertex "<<points0[0][0]<<" "<<points0[1][0]<<" "<<points0[2][0]<<endl;
	os<<"  vertex "<<points1[0][0]<<" "<<points1[1][0]<<" "<<points1[2][0]<<endl;
	os<<"  vertex "<<points2[0][0]<<" "<<points2[1][0]<<" "<<points2[2][0]<<endl;
	os<<"  endloop"<<endl;
}

void Triangle::out(std::ostream& os, Matrix composite)const{
	Matrix temp0 = composite*points0;
	Matrix temp1 = composite*points1;
	Matrix temp2 = composite*points2;
	os<<"  outer loop"<<endl;
	os<<"  vertex "<<temp0[0][0]<<" "<<temp0[1][0]<<" "<<temp0[2][0]<<endl;
	os<<"  vertex "<<temp1[0][0]<<" "<<temp1[1][0]<<" "<<temp1[2][0]<<endl;
	os<<"  vertex "<<temp2[0][0]<<" "<<temp2[1][0]<<" "<<temp2[2][0]<<endl;
	os<<"  endloop"<<endl;
}

Triangle* Triangle::clone()const{
	return new Triangle(color, points0[0][0], points0[1][0], points0[2][0], points1[0][0], points1[1][0], points1[2][0], points2[0][0], points2[1][0], points2[2][0]);
}

Triangle& Triangle::operator=(const Triangle& rhs){
	this->color = rhs.color;
	this->points0[0][0] = rhs.points0[0][0];
	this->points0[1][0] = rhs.points0[1][0];
	this->points0[2][0] = rhs.points0[2][0];;
	this->points0[3][0] = 1.0;
	this->points1[0][0] = rhs.points1[0][0];
	this->points1[1][0] = rhs.points1[1][0];
	this->points1[2][0] = rhs.points1[2][0];;
	this->points1[3][0] = 1.0;
	this->points2[0][0] = rhs.points2[0][0];
	this->points2[1][0] = rhs.points2[1][0];
	this->points2[2][0] = rhs.points2[2][0];;
	this->points2[3][0] = 1.0;
	return *this;
}