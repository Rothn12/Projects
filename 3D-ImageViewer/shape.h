#ifndef shape_h
#define shape_h

#include <iostream> 
#include "gcontext.h"
#include "viewcontext.h"
class Shape{
public:
	int color;
	Shape();
	Shape(unsigned int color);
	Shape(const Shape& from);
	virtual ~Shape();
	virtual void draw(GraphicsContext* gc, ViewContext* VC)const = 0;
	virtual void draw(GraphicsContext* gc, ViewContext* VC, double f, double zv)const = 0;
	virtual void draw(GraphicsContext* gc, ViewContext* VC, double f, double zv, Matrix composite)const = 0;
	virtual void draw_mat(GraphicsContext* gc, ViewContext* VC, Matrix composite)const = 0;
	virtual void out(std::ostream& os)const = 0;
	virtual void out(std::ostream& os, Matrix composite)const = 0;
	virtual Shape* clone()const = 0;

private:
	virtual Shape& operator=(const Shape& from);

};
#endif