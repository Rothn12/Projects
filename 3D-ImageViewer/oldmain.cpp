Shape *S2 = new Line(100, 100, 100, 200, 200);
 	Shape *S3 = new Triangle(0xFFFFFF, 200, 200, 150, 300, 150, 600);
 	//Shape *S6 = new Triangle(0xFF00FF, 0, 0, 400, 300, 800, 0);
 	//Shape *S7 = new Triangle(0xFFFFFF, 0, 0, 400, 300, 0, 600);
 	//Shape *S8 = new Triangle(0x00FFFF, 800, 0, 400, 300, 800, 600);
 	//Shape *S9 = new Triangle(0xFFFF00, 0, 600, 400, 300, 800, 600);

 	for(int i = 0; i < 13; i++){
 		Shape *S7 = new Triangle(0xFFFFFF, 0, 0, 400, 300, 0, i*50);
 		S7->draw(gc);
 		delete S7;
 	}

 	for(int i = 0; i < 13; i++){
 		Shape *S8 = new Triangle(0x00FFFF, 800, 0, 400, 300, 800, i*50);
 		S8->draw(gc);
 		delete S8;
 	}

 	for(int i = 0; i < 17; i++){
 		Shape *S9 = new Triangle(0xFFFF00, 0, 600, 400, 300, i*50, 600);
 		S9->draw(gc);
 		delete S9;
 	}

 	//for(int i = 0; i < 17; i++){
 		Shape *S6 = new Triangle(0xFF00FF, 0, 0, 400, 300, 800, 0);
 		S6->draw(gc);
 		delete S6;
 	//}

 	// for(int i = 0; i < 7; i++){
 	// 	Shape *S10 = new Line(0x22FFFF, i*100, 0, 800, i*100);
 	// 	S10->draw(gc);
 	// }

 	// for(int i = 0; i < 7; i++){
 	// 	int add = 0;
 	// 	if(i == 6){
 	// 		add = 200;
 	// 	}
 	// 	Shape *S10 = new Line(0xFF22FF, i*100+add, 600, 0, i*100);
 	// 	S10->draw(gc);
 	// }

 	

 	// for(int i = 0; i < 6; i++){
 	// 	Shape *S10 = new Line(0xFF2222, i*100, 600, 800, i*100);
 	// 	S10->draw(gc);
 	// }

 	// for(int i = 0; i < 6; i++){
 	// 	Shape *S10 = new Line(0xFFFF22, 0, i*100, i*100, 0);
 	// 	S10->draw(gc);
 	// }

 	Shape *S4(S3);
 	Shape *S5(S2);

 	Shape *S11 = S3->clone();

 	cout<<"S2"<<endl;
 	S2->out(std::cout);
 	cout<<"S3"<<endl;
 	S3->out(std::cout);
 	cout<<"S4"<<endl;
 	S4->out(std::cout);
 	cout<<"S5"<<endl;
 	S5->out(std::cout);
 	cout<<"S11"<<endl;
 	S11->out(std::cout);

 	//S2->draw(gc);
 	//S3->draw(gc);
 	//S6->draw(gc);
 	//S7->draw(gc);
 	//S8->draw(gc);
 	//S9->draw(gc);
 	delete S2;
 	delete S3;
 	delete S11;