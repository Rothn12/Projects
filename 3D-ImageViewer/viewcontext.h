#ifndef VIEWCONTEXT_H
#define VIEWCONTEXT_H

#include "matrix.h"
#include "gcontext.h"

class ViewContext
{
	public:
		ViewContext();
		ViewContext(GraphicsContext* gc);
		ViewContext(int width, int height);
		~ViewContext();
		Matrix model_to_device(Matrix m1);
		Matrix rotateY(Matrix rotate, double ang, int numRotate);
		Matrix rotateX(Matrix rotate, double ang, int numRotate);
		Matrix rotate(Matrix rotate, int ang, int prev);
		Matrix unRotate(Matrix rotate, int prev);
		Matrix scale(Matrix scale, int first, int polarity);
		Matrix translate(Matrix translate, int first, int polarity, int xOy);
		Matrix reset(Matrix m1);
		Matrix applyMatrix(Matrix m1, Matrix comp);
	private: 
		Matrix compositeMatrix = Matrix(4,4);
};

#endif