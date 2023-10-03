/*page 2*/
data supervisor;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap7. 다중선형회귀\supervisor.txt" firstobs=2;
	input y x1-x6;
run;

proc corr data=supervisor;
	var y x1-x6;
run;

proc corr data=supervisor plots=matrix;
	var x1-x6;
	with y;
run;

/*page 3*/
proc gplot data=supervisor;
	symbol i=rl v=dot h=0.7;
	plot y*x1;
	plot y*x2;
	plot y*x3;
	plot y*x4;
	plot y*x5;
	plot y*x6;
run;

/*page 4*/
proc reg data=supervisor;
	model y=x1-x6;
run;


/*page 5*/
proc reg data=supervisor plots=none;
	model y=x1 x2;
run;

proc reg data=supervisor plots=none;
	model y=x1; 
	output out=partial_1 r=e_y_x1;
run;

proc reg data=supervisor plots=none;
	model x2=x1; 
	output out=partial_2 r=e_x2_x1;
run;

/*page 6*/
data partial;
	merge partial_1 partial_2;
	label e_y_x1= e_x2_x1=;
	format e_y_x1 e_x2_x1 10.4;
run;

proc print data=partial(firstobs=16);
	var e_y_x1 e_x2_x1;
run;

proc reg data=partial plots=none;
	model e_y_x1=e_x2_x1;
run;
quit;


/*page 7*/
proc reg data=supervisor noprint;
	model y=x1-x6;
	output out=yhat p=yhat;
run;
quit;
proc means data=supervisor noprint;
	var y;
	output out=ybar mean=ybar;
run;
data yhat;
	set yhat;
	id=1;
run;
data ybar;
	set ybar(keep=ybar);
	id=1;
run;
data rsq;
	merge yhat ybar;
	format yhat ybar 6.2;
	by id;
	drop id;
run;

proc print data=rsq;
	var y yhat ybar;
run;

/*page 8*/
data rsq1;
	set rsq;
	SSE=(y-yhat)**2;
	SST=(y-ybar)**2;
run;

proc means data=rsq1 noprint;
	var SSE SST;
	output out=rsq2(keep=SSE SST) mean=SSE SST;
run;

data rsq3;
	set rsq2;
	format SSE SST Rsq adj_Rsq 8.4;
	Rsq=1-SSE/SST;
	adj_Rsq=1-(SSE/(30-6-1))/(SST/(30-1));
run;

proc print data=rsq3;
	var Rsq adj_Rsq;
run;
/*비교*/
proc reg data=supervisor plots=none;
	model y=x1-x6;
run;


/*page 9*/
data tvalue;
	input beta1_est beta1_se;
	alpha=0.05;
	df=30-6-1;
	t=tinv(1-alpha/2, df);

	beta1_u=beta1_est+t*beta1_se;
	beta1_l=beta1_est-t*beta1_se;

	cards;
0.61319 0.16098
;
run;

proc print data=tvalue;
run;


/*page 10*/
proc reg data=supervisor plots=none;
	model y=x1-x6 / clm cli;
run;

/*page 11*/
data add;
	input x1-x6;
	cards;
67 53 56 65 75 43
;
run;

data supervisor1;
	set add supervisor;
run;

proc print data=supervisor1;
run;

proc reg data=supervisor1 plots=none;
	model y=x1-x6 / clm cli;
run;


/*page 13*/
proc reg data=supervisor1 plots=none;
	model y=x1-x6;
	test x1=x2=x3=x4=x5=x6=0;
run;

/*page 14*/
proc reg data=supervisor1 plots=none;
	model y=x1-x6;
	test x2=x4=x5=x6=0;
run;

/*page 15*/
proc reg data=supervisor1 plots=none;
	model y=x1 x3;
	test x1=x3;
run;

/*page 16*/
proc reg data=supervisor1 plots=none;
	model y=x1-x6;
	test x1=x3, x2=x4=x5=x6=0;
run;

/*page 17*/
proc reg data=supervisor1 plots=none;
	model y=x1 x3;
	test x1+x3=1;
run;

/*page 18*/
proc reg data=supervisor1 plots=none;
	model y=x1 x3;
	test x1+x3=0.5;
run;



