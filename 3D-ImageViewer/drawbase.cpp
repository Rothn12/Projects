#include "drawbase.h"
#include "gcontext.h"
#include "viewcontext.h"
#include <iostream>
#include "matrix.h"
#include "math.h"
#include <fstream>
using namespace std;

DrawingBase::DrawingBase(){
	color = 0;
	VC = new ViewContext();
	command = 0;
	currentChange = Matrix::identity(4);
	PrevChange = Matrix::identity(4);
	rotateMat = Matrix::identity(4);
	rotU = 0;
	rotR = 0;
	first = 1;
	rightLast = 0;
	prevRot = -1;
	zv = -10;
	f = 100;
	ang = 15*(3.14159265359/180);
}

DrawingBase::DrawingBase(Image image, GraphicsContext* gc){
	cout<<"Welcome to the drawing program"<<endl;
	cout<<"Press r to enter rotate mode"<< endl;
	cout<<"Press f to enter FOV"<<endl;
	cout<<"Press Delete to reset"<<endl;
	color = 0;
	VC = new ViewContext(gc);
	this->image = image;
	command = 0;
	//Used to save current state for paint
	currentChange = Matrix::identity(4);
	currentChange = VC->model_to_device(currentChange);
	//Used to show current trasnlation
	//That wasnt translated to device
	PrevChange = Matrix::identity(4);
	rotateMat = Matrix::identity(4);
	rotU = 0;
	rotR = 0;
	first = 1;
	rightLast = 0;
	prevRot = -1;
	zv = -10;
	f = 100;
	ang = 15*(3.14159265359/180);
	image.draw(gc, VC, f, zv);
}

DrawingBase::~DrawingBase(){
	delete VC;
}

void DrawingBase::keyDown(GraphicsContext* gc, unsigned int keycode){
	string input;
	switch(keycode){
		case 114: //'r'
			cout<<endl<<"Rotate mode"<<endl<<endl;
			cout<<"Use the arrow keys to rotate"<<endl;
			cout<<"Left and right are z rotation, up and down are y rotation"<<endl;
			command = 1;
			break;
		case 102: //'f'
			cout<<"Plese enter a new f value. The current one is "<<f<<endl;
			cin>>f;
			gc->clear();
			image.draw(gc, VC, f, zv, currentChange);
			break;
		case 65535: //'delete'
			rotU = 0;
			rotR = 0;
			first = 1;
			gc->clear();
			image.draw(gc, VC, f, zv);
			break;
		case 65362: //'UP'
			if(command == 1){
				//Translate up
				rotU++;
				PrevChange = VC->rotateX(rotateMat, ang, rotU);
				PrevChange = VC->rotateY(PrevChange, ang, rotR);
				currentChange = VC->model_to_device(PrevChange);
				gc->clear();
				image.draw(gc, VC, f, zv, currentChange);
			} 
			break;
		case 65361: //'left'
			if(command == 1){
				//Translation left
				rotR--;
				undo = PrevChange;
				PrevChange = VC->rotateX(rotateMat, ang, rotU);
				PrevChange = VC->rotateY(PrevChange, ang, rotR);
				currentChange = VC->model_to_device(PrevChange);
				gc->clear();
				image.draw(gc, VC, f, zv, currentChange);
			} 	
			break;	
		case 65364: //'down'
			if(command == 1){
				//Translation down
				rotU--;
				undo = PrevChange;
				PrevChange = VC->rotateX(rotateMat, ang, rotU);
				PrevChange = VC->rotateY(PrevChange, ang, rotR);
				currentChange = VC->model_to_device(PrevChange);
				gc->clear();
				image.draw(gc, VC, f, zv, currentChange);
			} 
			break;
		case 65363: //'right'
			if(command == 1){
				//Translate right
				rotR++;
				PrevChange = VC->rotateX(rotateMat, ang, rotU);
				PrevChange = VC->rotateY(PrevChange, ang, rotR);
				currentChange = VC->model_to_device(PrevChange);
				gc->clear();
				image.draw(gc, VC, f, zv, currentChange);
			} 
			break;
	}
	
}

void DrawingBase::paint(GraphicsContext* gc){
	gc->clear();
	image.draw(gc, VC, f, zv);
}


void DrawingBase::keyUp(GraphicsContext* gc, unsigned int keycode){}
void DrawingBase::mouseButtonDown(GraphicsContext* gc, unsigned int button, int x, int y){}
void DrawingBase::mouseButtonUp(GraphicsContext* gc, unsigned int button, int x, int y){}
void DrawingBase::mouseMove(GraphicsContext* gc, int x, int y){}