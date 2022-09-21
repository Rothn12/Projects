#include "gcontext.h"
#include "viewcontext.h"
#include <iostream>
#include <cmath>
using namespace std;


	ViewContext::ViewContext(){
		Matrix translateMatrix = Matrix::identity(4);
		translateMatrix[0][3]=400;
		translateMatrix[1][3]=300;
		compositeMatrix = Matrix::identity(4);
		compositeMatrix[1][1]=-1;
		compositeMatrix = translateMatrix*compositeMatrix;
	}
	ViewContext::ViewContext(GraphicsContext* gc){
		Matrix translateMatrix = Matrix::identity(4);
		translateMatrix[0][3]=(gc->getWindowWidth())/2;
		translateMatrix[1][3]=(gc->getWindowHeight())/2;
		compositeMatrix = Matrix::identity(4);
		compositeMatrix[1][1]=-1;
		compositeMatrix = translateMatrix*compositeMatrix;
	}
	ViewContext::ViewContext(int width, int height){
		Matrix translateMatrix = Matrix::identity(4);
		translateMatrix[0][3]=width/2;
		translateMatrix[1][3]=height/2;
		compositeMatrix = Matrix::identity(4);
		compositeMatrix[1][1]=-1;
		compositeMatrix = translateMatrix*compositeMatrix;
	}
	ViewContext::~ViewContext(){

	}
	Matrix ViewContext::model_to_device(Matrix m1){
		return compositeMatrix*m1;
	}

	Matrix ViewContext::rotateY(Matrix rotate, double ang, int numRotate){
		//Rotation matrix for rotating around y
		Matrix rotateBy = Matrix::identity(4);
		rotateBy[0][0]=cos(ang*numRotate);
		rotateBy[0][2]=sin(ang*numRotate);
		rotateBy[2][0]=-sin(ang*numRotate);
		rotateBy[2][2]=cos(ang*numRotate);

		return rotateBy*rotate;
	}

	Matrix ViewContext::rotateX(Matrix rotate, double ang, int numRotate){
		//Rotation matrix for rotating around x
		Matrix rotateBy = Matrix::identity(4);
		rotateBy[1][1]=cos(ang*numRotate);
		rotateBy[1][2]=sin(ang*numRotate);
		rotateBy[2][1]=-sin(ang*numRotate);
		rotateBy[2][2]=cos(ang*numRotate);

		return rotateBy*rotate;
	}

	Matrix ViewContext::rotate(Matrix rotate, int ang, int prev){
		Matrix rotateBy = Matrix::identity(4);
		
		rotate = unRotate(rotate, prev);

		if(ang == 0){
			//90 deg
			rotateBy[0][0]=0;
			rotateBy[0][1]=1;
			rotateBy[1][0]=-1;
			rotateBy[1][1]=0;
		} else if(ang == 1){
			//180 deg
			rotateBy[0][0]=-1;
			rotateBy[0][1]=0;
			rotateBy[1][0]=0;
			rotateBy[1][1]=-1;
		} else if(ang == 2){
			//270 deg
			rotateBy[0][0]=0;
			rotateBy[0][1]=-1;
			rotateBy[1][0]=1;
			rotateBy[1][1]=0;
		} else {
			//No rotate
			rotateBy[0][0]=1;
			rotateBy[0][1]=0;
			rotateBy[1][0]=0;
			rotateBy[1][1]=1;
		}

		return rotateBy*rotate;
	}

	Matrix ViewContext::scale(Matrix scale, int first, int polarity){
		if(first == 1){
			if(polarity == 1){
				//Scale up
				scale[0][0]=1.0625;
				scale[1][1]=1.0625;
			} else {
				//Scale down
				scale[0][0]=0.9375;
				scale[1][1]=0.9375;
			}
			
		} else {
			if(polarity == 1){
				scale[0][0]=scale[0][0]+0.0625;
				scale[1][1]=scale[1][1]+0.0625;
			} else {
				if(scale[0][0]>0.0625){
					scale[0][0]=scale[0][0]-0.0625;
					scale[1][1]=scale[1][1]-0.0625;
				}
			}
		}
		return scale;
	}
	Matrix ViewContext::translate(Matrix translate, int first, int polarity, int xOy){
		if(first == 1){
			if(xOy == 0){
				translate[0][3]=polarity*5;
			} else {
				translate[1][3]=polarity*5;
			}
		} else {
			if(xOy == 0){
				translate[0][3]=translate[0][3]+polarity*5;
			} else {
				translate[1][3]=translate[1][3]+polarity*5;
			}
		}
		return translate;
	}
	Matrix ViewContext::reset(Matrix m1){
		return model_to_device(m1);
	}
	Matrix ViewContext::applyMatrix(Matrix m1, Matrix comp){
		return comp*m1;
	}
	
	Matrix ViewContext::unRotate(Matrix rotate, int prev){
		Matrix rotateBy = Matrix::identity(4);
		if(prev != -1){
			if(prev == 0){
				//90 deg
				rotateBy[0][0]=0;
				rotateBy[0][1]=-1;
				rotateBy[1][0]=1;
				rotateBy[1][1]=0;
			} else if(prev == 1){
				//180 deg
				rotateBy[0][0]=-1;
				rotateBy[0][1]=0;
				rotateBy[1][0]=0;
				rotateBy[1][1]=-1;
			} else if(prev == 2){
				//270 deg
				rotateBy[0][0]=0;
				rotateBy[0][1]=1;
				rotateBy[1][0]=-1;
				rotateBy[1][1]=0;
			} 
		}

		return rotateBy*rotate;
	}
