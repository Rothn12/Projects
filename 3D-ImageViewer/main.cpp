/**********************************************************
 * CS3210 -
 *   Lab7
 *   Author: Nathan Roth
 *          
 *   Purpose: To test my 3D transformations. This will
 *            make a graphics context and a basic starting
 *            shape. I then pass these into my drawing 
 *            base then pass that into runloop.
 **********************************************************
 * Example cli use:
 *      make
 *      ./main
 *      make clean
 *********************************************************/
#include "x11context.h"
#include <unistd.h>
#include <iostream>
#include <fstream>
#include "shape.h"
#include "line.h"
#include "triangle.h"
#include "image.h"
#include "viewcontext.h"
#include "drawbase.h"
using namespace std;
 
int main(void)
{
	GraphicsContext* gc = new X11Context(801,601,GraphicsContext::BLACK);

    Image I;
    ifstream myfile ("brianascii.stl");
    I.in(myfile);
    //I.out(cout);

    DrawingBase db(I, gc);

    gc->runLoop(&db);

    delete gc;

	return 0;
}