#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include "image.h"
using namespace std;

Image::Image(){
}

Image::Image(const Image& from){
	for(int i = 0; i<from.ShapeList.size(); i++){
		ShapeList.push_back((from.ShapeList)[i]->clone());
	}
}

Image::~Image(){
	erase();
}

Image& Image::operator=(const Image& rhs){
	erase();
	for(int i = 0; i<rhs.ShapeList.size(); i++){
		ShapeList.push_back((rhs.ShapeList)[i]->clone());
	}
	return *this;
}

void Image::add(Shape* shape){
	ShapeList.push_back(shape->clone());
}

void Image::draw(GraphicsContext* gc, ViewContext* VC)const{
	for(int i = 0; i<ShapeList.size(); i++){
		(ShapeList[i])->draw(gc, VC);
	}
}

void Image::draw(GraphicsContext* gc, ViewContext* VC, double f, double zv)const{
	for(int i = 0; i<ShapeList.size(); i++){
		(ShapeList[i])->draw(gc, VC, f, zv);
	}
}

void Image::draw(GraphicsContext* gc, ViewContext* VC, double f, double zv, Matrix composite)const{
	for(int i = 0; i<ShapeList.size(); i++){
		(ShapeList[i])->draw(gc, VC, f, zv, composite);
	}
}

void Image::draw_mat(GraphicsContext* gc, ViewContext* VC, Matrix composite)const{
	for(int i = 0; i<ShapeList.size(); i++){
		(ShapeList[i])->draw_mat(gc, VC, composite);
	}
}

void Image::out(std::ostream& os)const{
	os<<"solid name"<<endl;
	for(int i = 0; i<ShapeList.size(); i++){
		os<<" facet normal -nan -nan -nan"<<endl;
		(ShapeList[i])->out(os);
		os<<" endfacet"<<endl;
	}
	os<<"endsolid name"<<endl;
}

void Image::out(std::ostream& os, Matrix composite)const{
	for(int i = 0; i<ShapeList.size(); i++){
		(ShapeList[i])->out(os, composite);
	}
}

void Image::in(istream& in){
	erase();
	string type;
	unsigned int color = 0x00FF00;
	double x;
	double y;
	double z;
	double x0;
	double y0;
	double z0;
	double x1;
	double y1;
	double z1;
	double x2;
	double y2;
	double z2;
	int set_coords = 0;
    string line;
    string word;
    float current_number;
    bool can_loop = true;
    //read from file, one line at a time
    //Clear the name of the solid
    getline(in, line);
    while(can_loop){
        // create istringstream object to process each line
        istringstream checkEndStream(line);
        //Grabbing first word
        checkEndStream >> word;
        if((in.eof())){
            can_loop = false;
        } else {
            //Clear the facet normal
            getline(in, line);
            //Clear the outer loop
            getline(in, line);
            for(int i = 0; i < 3; i++){
                //Grab first line of values
                getline(in, line);
                istringstream inputstream(line);
                inputstream >> word;
                if((in.eof())){
                    can_loop = false;
                } else {
                    //X value
                    inputstream >> word;
                    current_number = stof(word);
                    x=current_number*30;
                    //Y value
                    inputstream >> word;
                    current_number = stof(word);
                    y=current_number*30;
                    //Z value
                    inputstream >> word;
                    current_number = stof(word);
                    z=current_number*30;
                    if(set_coords == 0){
		                x0=x;
		                y0=y;
		                z0=z;
		                set_coords = 1;
		            }else if(set_coords == 1){
		                x1=x;
		                y1=y;
		                z1=z;
		                set_coords = 2;
		            } else {
		                x2=x;
		                y2=y;
		                z2=z;
		                ShapeList.push_back(new Triangle(color, x0, y0, z0, x1, y1, z1, x2, y2, z2));
		                set_coords = 0;
		            }
		        }
            }
          
            //Clear the endloop
            getline(in, line);
            //Clear the endfacet
            getline(in, line);
            //Clear the empty line
            getline(in, line);
            
        }
    }
	//Reset file
	in.seekg(0);
}


void Image::erase(){
	for(int i = 0; i<ShapeList.size(); i++){
		delete ShapeList[i];
	}
	ShapeList.clear();
}