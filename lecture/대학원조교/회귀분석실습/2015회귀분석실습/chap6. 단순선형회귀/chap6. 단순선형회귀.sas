/*page 4*/
data corr;
	input y x @@;
cards;
1 -7 46 -2 41 3
14 -6 49 -1 34 4
25 -5 50 0 25 5
34 -4 49 1 14 6
41 -3 46 2 1 7
;
proc corr data=corr noprob plots=scatter;
	var x y;
run;



/*page 5*/
data quartet;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap6. 단순선형회귀\quartet.txt" expandtabs;
	input y1 x1 y2 x2 y3 x3 y4 x4;
run;

proc corr data=quartet noprob plots=matrix;
	var x1 x2 x3 x4;
	with y1 y2 y3 y4;
run;

/*page 6*/
symbol i=none v=dot h=1.5;
proc gplot data=quartet;
	plot y1*x1;
	plot y2*x2;
	plot y3*x3;
	plot y4*x4;
run;



/*page 7*/

data repair;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap6. 단순선형회귀\repair.txt";
	input y x;
	label y="Minutes" x="Units";
run;

proc means data=repair mean noprint;
	var y x;
	output out=repair2 mean=ybar xbar;
run;

data repair;
	set repair;
	id=1;
run;
data repair2;
	set repair2(drop=_TYPE_ _FREQ_);
	id=1;
	label ybar=ybar xbar=xbar;
run;
data repair3(drop=id);
	merge repair repair2;
	by id;
run;

data repair3;
	set repair3;
	format ybar bias_y bias_y2 bias_xy 8.2;
	bias_y=y-ybar;
	bias_x=x-xbar;
	bias_y2=(y-ybar)**2;
	bias_x2=(x-xbar)**2;
	bias_xy=(y-ybar)*(x-xbar);
run;

proc print data=repair3;
	var y x ybar xbar bias_y bias_x bias_y2 bias_x2 bias_xy;
	sum y x ybar xbar bias_y bias_x bias_y2 bias_x2 bias_xy;
run;



/*page 8*/

proc means data=repair3 noprint;
	var ybar xbar bias_y2 bias_x2 bias_xy;
	output out=repair4 sum=ybar_sum xbar_sum Syy Sxx Sxy;
run;
data repair4;
	set repair4;
	format ybar  8.2 xbar 3. beta1 beta0 8.3;
	ybar=ybar_sum/_FREQ_;
	xbar=xbar_sum/_FREQ_;

	beta1=Sxy/Sxx;
	beta0=ybar-beta1*xbar;

	id=1;
	drop ybar_sum xbar_sum _TYPE_ _FREQ_;
run;

data repair5;
	merge repair repair4(keep=beta1 beta0 id);
	by id;
	format yhat e 8.2;
	yhat=beta0+beta1*x;
	e=y-yhat;
	drop id beta1 beta0;
run;

proc print data=repair5;
run;


/*page 18*/
proc reg data=repair;
	model y=x;
run;

/*page 19*/
proc reg data=repair;
	model y=x /p;
run;

proc reg data=repair;
	model y=x /r;
run;

/*page 20*/
proc reg data=repair;
	model y=x;
	test x=12;
run;


/*page 21*/
proc reg data=repair;
	model y=x /CLM CLI;
run;




