#ifndef image_h
#define image_h

#include <iostream> 
#include "gcontext.h"
#include "line.h"
#include "shape.h"
#include "triangle.h"
#include "viewcontext.h"
#include "matrix.h"
#include <vector>
class Image{
public:
	Image();
	Image(const Image& from);
	~Image();
	void draw(GraphicsContext* gc, ViewContext* VC)const;
	void draw(GraphicsContext* gc, ViewContext* VC, double f, double zv)const;
	void draw(GraphicsContext* gc, ViewContext* VC, double f, double zv, Matrix composite)const;
	void draw_mat(GraphicsContext* gc, ViewContext* VC, Matrix composite)const;
	void out(std::ostream& os)const;
	void out(std::ostream& os, Matrix composite)const;
	void in(std::istream& in);
	Image& operator=(const Image& rhs);
	void erase();
	void add(Shape* shape);
private:
	std::vector<Shape*> ShapeList;

};
#endif