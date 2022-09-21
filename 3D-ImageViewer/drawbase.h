#ifndef DRAWBASE_H
#define DRAWBASE_H

#include "viewcontext.h"
#include "image.h"
#include "matrix.h"
#include <iostream>
#include <string>
// forward reference
class GraphicsContext;

class DrawingBase
{
	public:
		//CREATE CONSTRUCOR THAT PRINTS OUT WHAT EACH KEY DOES
		//Paint function will just call draw
		DrawingBase();
		DrawingBase(Image image, GraphicsContext* gc);
		DrawingBase(Image image, int width, int height);
		virtual ~DrawingBase();
		virtual void paint(GraphicsContext* gc);
		virtual void keyDown(GraphicsContext* gc, unsigned int keycode);
		virtual void keyUp(GraphicsContext* gc, unsigned int keycode);
		virtual void mouseButtonDown(GraphicsContext* gc, 
								unsigned int button, int x, int y);
		virtual void mouseButtonUp(GraphicsContext* gc,
								unsigned int button, int x, int y);
		virtual void mouseMove(GraphicsContext* gc, int x, int y);
	private: 
		double f;
		double zv;
		unsigned int color;
		ViewContext* VC;
		Image image;
		int command;
		Matrix currentChange = Matrix(4,4);
		Matrix PrevChange = Matrix(4,4);
		Matrix rotateMat = Matrix(4,4);
		double ang;
		int rotU;
		int rotR;
		int first;
		int rightLast;
		int prevRot;
		Matrix undo = Matrix(4,4);
		void save();
		void load(const std::string& fileName, GraphicsContext* gc);
};
#endif