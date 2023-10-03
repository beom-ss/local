
/**************************************************************************************/
data quartet;
	infile"D:\Anscombe's_Data.txt" expandtabs firstobs=2 ;
	input y1 x1 y2 x2 y3 x3 y4 x4;
run;

proc plot data=quartet vpercent=50 hpercent=50 ;       
	plot y1*x1 ; 	plot y2*x2 ; 	plot y3*x3 ; 	plot y4*x4 ;    
run;quit;
symbol1	color=red		interpol=none	value=dot    ;      
symbol2	color=blue 	interpol=rl			value=none ;      
proc gplot data=quartet ;
	plot y1*x1=1 y1*x1=2 / overlay ;  
	plot y2*x2=1 y1*x1=2 / overlay ;   
	plot y3*x3=1 y1*x1=2 / overlay ;  
	plot y4*x4=1 y1*x1=2 / overlay ; 
run;quit;

data hamilton ;
	infile"D:\hamilton's_Data.txt" expandtabs firstobs=2 ;
	input y	x1	x2 ;
run;

proc insight data=hamilton;
run;

proc univariate data=hamilton normal plot ;
	var y x1 x2 ;
	histogram;
run;

proc sgscatter data=hamilton ;
  matrix y x1 x2 ;
run;

proc g3d data=hamilton ;
	scatter x1 * x2 = y /
	shape="balloon" ;
run;

proc g3grid data=hamilton out=a;
  grid x1 * x2 = y / 
    axis1=30 to 80 by 5
    axis2=30 to 80 by 5 ;
run;
proc g3d data=a ;
  plot x1 * x2 = y ;
run;

proc g3grid data=hamilton out=b;
  grid x1 * x2 = y / 
  axis1=30 to 80 by 1
  axis2=30 to 80 by 1 ;
run;
proc g3d data=b ;
  plot x1 * x2 = y ;
run;

proc g3d data=b ;
  plot x1 * x2 = y /
  rotate=45 tilt=80 ;
run;
proc g3d data=b ;
  plot x1 * x2 = y /
  rotate=30 tilt=20 ;
run;
proc g3d data=b ;
  plot x1 * x2 = y /
  rotate=45 tilt=60 ;
run;

proc plot data=hamilton vpercent=50 hpercent=50 ;
	plot y*x1;	plot y*x2 ; 	
run;
proc reg data=hamilton ;
	model y = x1 ;
	plot y * x1;
run;
proc reg data=hamilton ;
	model y = x2 ;
    plot y * x2;
run;
proc reg data=hamilton ;
	model y = x1 x2 ;
run;

proc g3grid data=hamilton out=b;
  grid x1 * x2 = y / 
  axis1=30 to 80 by 1
  axis2=30 to 80 by 1 ;
run;
proc g3d data=b ;
  plot x1 * x2 = y ;
run;
proc insight data=hamilton;
run;


/**************************************************************************************/

