#ifndef triangle_h
#define triangle_h

#include <iostream> 
#include "gcontext.h"
#include "line.h"
#include "matrix.h"
#include "shape.h"
#include "viewcontext.h"
class Triangle: public Shape{
public:
	Triangle();
	Triangle(unsigned int color, double x0, double y0, double x1, double y1, double x2, double y2);
	Triangle(unsigned int color, double x0, double y0, double z0, double x1, double y1, double z1, double x2, double y2, double z2);
	Triangle(const Triangle& from);
	~Triangle();
	void draw(GraphicsContext* gc, ViewContext* VC)const;
	void draw(GraphicsContext* gc, ViewContext* VC, double f, double zv)const;
	void draw(GraphicsContext* gc, ViewContext* VC, double f, double zv, Matrix composite)const;
	void draw_mat(GraphicsContext* gc, ViewContext* VC, Matrix composite)const;
	void out(std::ostream& os)const;
	void out(std::ostream& os, Matrix composite)const;
	Triangle* clone()const;
private:
	Triangle& operator=(const Triangle& rhs);
	int color;
	Matrix points0 = Matrix(4,1);
	Matrix points1 = Matrix(4,1);
	Matrix points2 = Matrix(4,1);

};
#endif