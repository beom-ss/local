/*page 3*/
data ancombe;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap8. 회귀진단\Anscombe's_Quartet.txt" expandtabs firstobs=2;
	input Y1 X1 Y2 X2 Y3 X3 Y4 X4;
run;

symbol i=rl v=dot h=0.7;
proc gplot data=ancombe;
	plot y1*x1;
	plot y2*x2;
	plot y3*x3;
	plot y4*x4;
run;

/*page 4*/
data hamilton;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap8. 회귀진단\hamilton's_data.txt" expandtabs firstobs=2;
	input y x1 x2;
run;

proc sgplot data=hamilton;
	histogram x1;
run;

proc sgplot data=hamilton;
	dot x1;
run;

proc sgplot data=hamilton;
	vbox x1;
run;

/*page 5*/
proc sgscatter data=hamilton;
	matrix y x1 x2;
run;
proc corr data=hamilton nocorr plots=matrix;
	var y x1 x2;
run;

/*page 6*/
proc g3grid data=hamilton out=grid;
	grid x1*x2=y / axis1=30 to 80 by 1
							axis2=30 to 80 by 1;
run;
proc g3d data=grid;
	plot x1*x2=y;
run;

/*page 7*/
proc g3d data=grid;
	plot x1*x2=y / rotate=45;
run;
proc g3d data=grid;
	plot x1*x2=y / rotate=45 tilt=20;
run;

/*page 8*/
proc g3d data=hamilton;
	scatter x1*x2=y;
run;

/*page 9*/
proc g3d data=hamilton;
	scatter x1*x2=y / rotate=45;
run;

proc g3d data=hamilton;
	scatter x1*x2=y / rotate=45 tilt=20;
run;

/*page 10*/
proc univariate data=hamilton noprint;
	qqplot y / normal(mu=est sigma=est) square;
run;

proc reg data=hamilton plots=(ResidualPlot);
	model y=x1;
run;

/*page 11*/
proc univariate data=hamilton normal plot;
	var y;
run;

/*page 12*/
data river;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap8. 회귀진단\NewYork_River.txt" dlm='09'x firstobs=2;
	length river $15;
	input river$ x1-x4 y;
	label x1="Agr" x2="Forest" x3="Rsdntial" x4="ComIndl" x5="Nitrogen";
run;

proc reg data=river;
	model y=x1-x4;
	ods output ParameterEstimates=est1(rename=(tValue=none));
run;
proc reg data=river;
	where river^="Neversink";
	model y=x1-x4;
	ods output ParameterEstimates=est2(rename=(tValue=Neversink));
run;
proc reg data=river;
	where river^="Hackensack";
	model y=x1-x4;
	ods output ParameterEstimates=est3(rename=(tValue=Hackensack));
run;
data est;
	merge est1(keep=Variable none) est2(keep=Variable Neversink) est3(keep=Variable Hackensack);
	by Variable;
	label none= Neversink= Hackensack=;
run;

proc print data=est;
run;


/*page 13*/
proc gplot data=river;
	symbol i=rl v=dot;
	plot y*x4;
run;

proc reg data=river ;
	model y = x4  /influence;
	output out=out Student=ri h=hii;
quit;
data out1;
	set out;
	format ri hii 5.2;
	keep ri hii;
run;

proc print data=out1(obs=10); 
run;
proc print data=out1(firstobs=11); 
run;


/*page 14*/
data out1;
	set out1;
	id=_N_;
run;
proc gplot data=out1;
	symbol i=none v=dot;
	plot ri*id;
	plot hii*id;
run;


/*page 15*/
proc reg data=river noprint;
	model y = x4  /influence ;
	output out=influence p=yhat Residual=ei Student=ri Cookd=cooki Rstudent=ti h=hii COVRATIO=cov DFFITS=df_fit PRESS=press ;
quit;

data influence;
	set influence;
	id=_N_;
run;
proc gplot data=influence;
	symbol i=none v=dot h=1;
	plot cooki*id;
	plot df_fit*id;
	plot hii*id;
run;

/*page 16*/
proc print data=influence(obs=10);
	var cooki df_fit hii;
run;
proc print data=influence(firstobs=11);
	var cooki df_fit hii;
run;

/*page 17*/
proc reg data=river plots=none;
	model y=x4;
run;
data influence2;
	set influence;
	di = (ei/sqrt(2.59540)) ;					/*di=ei/sqrt(sse)*/
    potential_function = hii/(1-hii) ;
	residual_function = ((1+1)/(1-hii))*((di**2)/(1-di**2)) ;
	hadi = potential_function + residual_function ;
run;

proc gplot data=influence2;
	symbol i=none v=dot h=1;
	plot  hadi*id;
  	plot  potential_function*residual_function;
run;

