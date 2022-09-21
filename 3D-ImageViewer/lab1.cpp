/**********************************************************
 * CS3210 -
 *   Lab1
 *   Author: Nathan Roth
 *          File reading ideas taken from Readfile
 *          example given by Dr. Varnell in canvas
 *   Purpose: This program will take in a file from a
 *      user that contains information about a 3d object.
 *      This program will then find the maximum and
 *      minimum of the x, y, and z coordinates. As well as 
 *      the number of facets.
 **********************************************************
 * Example cli use:
 *      g++ -0 lab1 lab1.cpp
 *      ./lab1 <stlfilename>
 *********************************************************/

#include<iostream>
#include<string>
#include<fstream>
#include<sstream>
#include<cfloat>

using namespace std;

class stlRead {
  private:
    int num_facets;
    float x;
    float y;
    float z;
    float x0;
    float y0;
    float z0;
    float x1;
    float y1;
    float z1;
    float x2;
    float y2;
    float z2;
    int set_coords;
  public:
    stlRead(string file){
        set_coords = 0;
        //Creating input stream
        ifstream input(file, ifstream::in);
        string line;
        string word;
        float current_number;
        bool can_loop = true;
        //read from file, one line at a time
        //Clear the name of the solid
        getline(input, line);
        while(can_loop){
            // create istringstream object to process each line
            istringstream checkEndStream(line);
            //Grabbing first word
            checkEndStream >> word;
            if((input.eof())){
                can_loop = false;
            } else {
                //Clear the facet normal
                getline(input, line);
                //Clear the outer loop
                getline(input, line);
                for(int i = 0; i < 3; i++){
                    //Grab first line of values
                    getline(input, line);
                    istringstream inputstream(line);
                    inputstream >> word;
                    if((input.eof())){
                        can_loop = false;
                    } else {
                        //X value
                        inputstream >> word;
                        current_number = stof(word);
                        x=current_number;
                        //Y value
                        inputstream >> word;
                        current_number = stof(word);
                        y=current_number;
                        //Z value
                        inputstream >> word;
                        current_number = stof(word);
                        z=current_number
                        
                    }
                }
                if(set_coords == 0){
                    x0=x;
                    y0=y;
                    z0=z;
                }else if(set_coords == 1){
                    x1=x;
                    y1=y;
                    z1=z;
                } else {
                    x2=x;
                    y2=y;
                    z2=z;
                }
                ShapeList.push_back(new Triangle(color, x0, y0, x1, y1, x2, y2));
                //Clear the endloop
                getline(input, line);
                //Clear the endfacet
                getline(input, line);
                //Clear the empty line
                getline(input, line);
                
            }
        }
    }

    int get_facets(){
        return num_facets;
    }

    float get_max_x(){
        return x_max;
    }

    float get_max_y(){
        return y_max;
    }

    float get_max_z(){
        return z_max;
    }

    float get_min_x(){
        return x_min;
    }

    float get_min_y(){
        return y_min;
    }

    float get_min_z(){
        return z_min;
    }
};



int main(int argc, char* argv[]){

    // pass in argv[1]

    stlRead reader(argv[1]);


    cout << "Number of fecets: " << reader.get_facets() << endl;
    cout << "X max: " << reader.get_max_x() << endl;
    cout << "X min: " << reader.get_min_x() << endl;
    cout << "Y max: " << reader.get_max_y() << endl;
    cout << "Y min: " << reader.get_min_y() << endl;
    cout << "Z max: " << reader.get_max_z() << endl;
    cout << "Z min: " << reader.get_min_z() << endl;

    return 0;
}