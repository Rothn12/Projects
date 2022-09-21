#ifndef line_h
#define line_h

#include <iostream> 
#include "gcontext.h"
#include "matrix.h"
#include "shape.h"
#include "viewcontext.h"
class Line: public Shape{
public:
	Line();
	Line(unsigned int color, double x0, double y0, double x1, double y1);
	Line(const Line& from);
	~Line();
	void draw(GraphicsContext* gc, ViewContext* VC)const;
	void draw(GraphicsContext* gc, ViewContext* VC, double f, double zv)const;
	void draw(GraphicsContext* gc, ViewContext* VC, double f, double zv, Matrix composite)const;
	void draw_mat(GraphicsContext* gc, ViewContext* VC, Matrix composite)const;
	void out(std::ostream& os)const;
	void out(std::ostream& os, Matrix composite)const;
	Line* clone()const;
private:
	Line& operator=(const Line& rhs);
	int color;
	Matrix points0 = Matrix(4,1);
	Matrix points1 = Matrix(4,1);

};
#endif