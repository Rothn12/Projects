/* This is an abstract base class representing a generic graphics
 * context.  Most implementation specifics will need to be provided by
 * a concrete implementation.  See header file for specifics. */

#define _USE_MATH_DEFINES	// for M_PI
#include <cmath>	// for trig functions
#include "gcontext.h"	

/*
 * Destructor - does nothing
 */
GraphicsContext::~GraphicsContext()
{
	// nothing to do
	// here to insure subclasses handle destruction properly
}

/*
 * drawLine(int x0, int y0, int x1, int y1)
 *      Parameters:
                x0 - initial x coordinate
                y0 - initial y coordinate
                x1 - final x coordinate
                y1 - final y coordinate
        Purpose:
                This function will draw a line between the two 
                given coordinates using the Bresenham algorthim
                found here
                https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
 */
void GraphicsContext::drawLine(int x0, int y0, int x1, int y1){
    int swap = 0;
    //Change in x/y
    int delta_x = x1-x0;
    int delta_y = y1-y0;

    if(abs(delta_y) > abs(delta_x)){
        //Swapping Xs and Ys
        swap = 1;
        int tempx = x0;
        x0 = y0;
        y0 = tempx;
        tempx = x1;
        x1 = y1;
        y1 = tempx;
        tempx = delta_x;
        delta_x = delta_y;
        delta_y = tempx;
    } 

    int xadd = 1;
    //If delta_x is 0, x does not increse
    if(delta_x == 0){
        xadd = 0;
    //If delta_x is negative, x decreases
    } else if(delta_x < 0){
        xadd = -1;
        //This must be a positive value to get a slope
        //If it is left negative, then the Di value
        //will become more and more negative
        delta_x = -1*delta_x;
    }

    int yadd = 1;
    //If delta_x is 0, x does not increse
    if(delta_y ==0){
        yadd = 0;
    //If delta_x is negative, x decreases
    } else if(delta_y < 0){
        yadd = -1;
        //This must be a positive value to get a slope
        //If it is left negative, then the Di value
        //will become more and more negative
        delta_y = -1*delta_y;
    }

    int x = x0;
    int y = y0;

    //Initial values for the Di calculations
    int D0 = 2*delta_y - delta_x;
    int Di = D0;

    //Plotting the first point
    if(swap == 0){
        setPixel(x0, y0);
    } else {
        setPixel(y0, x0);
    }


    for(int i = 1; i < abs(delta_x); i++){
        //Calculating and checking the value of Di
        //Keep the <= for the few cases that Di = 0
        if(Di <= 0){
            Di = Di+2*delta_y;
            y = y;
        } else if(Di > 0){
            Di = Di+2*delta_y-2*delta_x;
            y = y+yadd;
        }
        x = x+xadd;
        //Plotting
        if(swap == 0){
            setPixel(x, y);
        } else {
            setPixel(y, x);
        }
    }

    //Plotting the final values
    if(swap == 0){
        setPixel(x1, y1);
    } else {
        setPixel(y1, x1);
    }
}
void GraphicsContext::drawCircle(int x0, int y0, unsigned int radius){}


void GraphicsContext::endLoop()
{
	run = false;
}