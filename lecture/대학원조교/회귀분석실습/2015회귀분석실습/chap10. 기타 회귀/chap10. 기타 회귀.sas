/*6장*/
/*2 page*/
data bacteria;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap10. 기타 회귀\bacteria.txt" expandtabs;
	input t n;
run;
/*기본 모델 적합*/
proc reg data=bacteria plots=none;
	model n=t;
	output out=bacteria_out student=ri;
run;

/*3 page*/
/*n과 t가 직선보다는 약간의 비선형성이 있는 것으로 판단*/
/*잔차를 살펴본 결과 추세가 존재함을 확인*/
symbol v=dot h=1;
proc gplot data=bacteria_out;
	plot n*t;
	plot ri*t;
run;
goption reset=all;


/*4 page*/
/*로그변환*/
data bacteria2;
	set bacteria;
	lnn=log(n);
run;
/*로그변환 적합*/
proc reg data=bacteria2 plots=none;
	model lnn=t;
	output out=bacteria2_out student=ri;
run;

/*5 page*/
/*log(n)과 t사이의 관계가 선형을 이룸*/
/*변환 후 잔차 확인->잔차가 잘 퍼져있음*/
symbol v=dot h=1;
proc gplot data=bacteria2_out;
	plot lnn*t;
	plot ri*t;
run;
goption reset=all;


/*6 page*/
data industrial;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap10. 기타 회귀\industrial.txt" expandtabs firstobs=2;
	input row X Y;
run;
/*기본회귀적합*/
proc reg data=industrial plots=none;
	model Y=X;
	output out=industrial_out student=ri;
run;

/*7 page*/
/*이분산성이 존재함을 파악*/
symbol v=dot h=1;
proc gplot data=industrial_out;
	plot y*x;
	plot ri*x;
run;
goption reset=all;

/*8 page*/
/*가중치를 주기위한 변수 생성*/
data industrial2;
	set industrial;
	Y_X=Y/X;
	one_X=1/X;
	X2=X**2;
	one_X2=1/X2;
run;
/*역수를 통한 모델링 적합*/
proc reg data=industrial2 plots=none;
	model Y_X=one_X;
	output out=industrial2_out student=ri;
run;

/*9 page*/
/*이전에 비해 이분산성이 해소된 것을 확인*/
symbol v=dot h=1;
proc gplot data=industrial2_out;
	plot ri*one_X;
run;
goption reset=all;

/*10 page*/
/*weighted reg를 통해서도 구현 가능*/
proc reg data=industrial2 plots=none;
	weight one_X2;
	model Y=X;
run;
quit;

/*11 page*/
/*이분산성을 해소하는 방법으로 제곱항과 log변환을 고려*/
data industrial3;
	set industrial;
	lnY=log(Y);
	X2=X**2;
run;
/*일반 log 변환 적합*/
proc reg data=industrial3 plots=none;
	model lnY=X;
	output out=industrial3_out student=ri;
run;

/*12 page*/
/*log변환 후에도 이분산성이 존재하는 것을 확인*/
symbol v=dot h=1;
proc gplot data=industrial3_out;
	plot lnY*X;
	plot ri*X;
run;

/*13 page*/
/*제곱항 추가*/
proc reg data=industrial3 plots=none;
	model lnY=X X2;
	output out=industrial4_out p=pred student=ri;
run;

/*14-15 page*/
/*제곱항 추가 후 이분산성이 해소된 것을 확인*/
symbol v=dot h=1;
proc gplot data=industrial4_out;
	plot ri*pred;
	plot ri*X;
	plot ri*X2;
run;




/*7장*/

/*16 page*/
data education;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap10. 기타 회귀\education.txt" expandtabs firstobs=2;
	input State$ Y X1 X2 X3 Region;
	id=_n_;
run;
/*일반 모형 적합*/
proc reg data=education plots=none;
	model Y=X1 X2 X3;
	output out=education_out r=ei p=pred student=ri 
						cookd=cookd DFFITS=DFFITS h=hi;
run;
/*그때의 plot을 살펴본 결과 이분산성 존재*/
symbol v=dot h=1;
proc gplot data=education_out;
	plot ri*pred / haxis=190 to 490 by 50;
	plot ri*Region;
run;
/*X1에 대해 특히 이분산성이 심하게 나타남*/
proc gplot data=education_out;
	plot ri*X1;
	plot ri*X2;
	plot ri*X3;
run;
/*특이값 존재*/
proc gplot data=education_out;
	plot cookd*id;
	plot DFFITS*id;
	plot hi*id;
run;


/*특이값 제거 후 회귀분석*/
data education2;
	set education;
	if state='AK' then delete;
run;

proc reg data=education2 plots=none;
	model Y=X1 X2 X3;
	output out=education2_out r=ei p=pred student=ri
							cookd=cookd DFFITS=DFFITS h=hi;
run;
/*특이값 제거 후에도 등분산성을 만족하지 않음*/
proc gplot data=education2_out;
	plot ri*pred;
	plot ri*Region;
run;
/* 특이값 제거 전과 비교
proc gplot data=education2_out;
	plot ri*X1;
	plot ri*X2;
	plot ri*X3;

	plot cookd*id / vaxis=0 to 3 by 1;
	plot DFFITS*id / vaxis=-1 to 4 by 1;
	plot hi*id / vaxis=0 to 0.46 by 0.02;
run;
*/

/*가중최소제곱을 위한 가중값 계산*/
data edu_weight;
	set education2_out;
	ei2=ei**2;
run;
proc means data=edu_weight noprint;
	by region;
	var ei2;
	output out=edu_weight2 sum=ei2_sum;
run;
data edu_weight2;
	set edu_weight2;
	sigma2=ei2_sum/(_FREQ_-1);
	rename _FREQ_=n;
run;
proc means data=edu_weight noprint;
	var ei2;
	output out=edu_weight3 sum=ei2_sum_all;
run;
data edu_weight3;
	set edu_weight3;
	ei2_stand=ei2_sum_all/_FREQ_;
	drop _FREQ_;
run;
data edu_weight4;
	merge edu_weight2 edu_weight3;
	by _TYPE_;
	cj2=sigma2/ei2_stand;
	keep Region n sigma2 cj2;
run;
proc print data=edu_weight4;
run;

/* sql문을 이용한 가중최소제곱의 가중값 계산
proc sql;
	create table test as
	select region, count(region) as n, sum(ei**2) as ei2, sum(ei**2)/(count(region)-1) as sigma2, 
				(select sum(ei**2)/count(region) from education2_out) as ei2_stand
	from education2_out
	group by region;

	create table test2 as
	select region, n, sigma2, sigma2/ei2_stand as cj2
	from test;
quit;
*/

/*가중치를 이용하여 weighted regression을 수행*/
data education3;
	merge education2 edu_weight4(keep=region cj2);
	by region;
	one_cj2=1/cj2;
run;

proc reg data=education3 plots=none;
	weight one_cj2;
	model Y=X1 X2 X3;
	output out=education3_out p=pred student=ri;
run;
/*가중치회귀를 적합시킨 후 등분산성을 만족하는 것을 확인*/
symbol v=dot h=1;
proc gplot data=education3_out;
	plot ri*pred;
	plot ri*Region;
run;



/*9장*/
data import;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap10. 기타 회귀\import.txt" expandtabs firstobs=2;
	input YEAR IMPORT DOPROD STOCK CONSUM;
	id=_N_;
run;

/*다중공선성이 있는경우 회귀분석에서 발생하는 문제 파악*/
/*Rsquare는 매우 높으나 t값이 작음->다중공선성 의심*/
proc reg data=import plots=none;
	model IMPORT=DOPROD STOCK CONSUM / vif;
	output out=import_out student=ri;
run;

/*잔차플롯이 패턴을 나타내고있음->설명이 제대로 되지 않음*/
symbol i=join v=dot h=1;
proc gplot data=import_out;
	plot ri*id / href=12;
run;

/*성질이 비슷한 59년도까지의 데이터를 가지고 다시한번 모델링*/
proc reg data=import plots=none;
	where year<=59;
	model IMPORT=DOPROD STOCK CONSUM / vif;
	output out=import2_out student=ri;
run;
/*잔차의 패턴이 없어진 것을 확인*/
symbol i=join v=dot h=1;
proc gplot data=import2_out;
	plot ri*id;
run;

/*CONSUM과 DOPROD 사이의 관계 확인*/
/*상당히 밀접한 관계가 있음을 확인->다중공선성 존재*/
proc reg data=import plots=none;
	where year<=59;
	model CONSUM=DOPROD;
run;

/*공분산 행렬과 상관계수 행렬 구하기*/
proc corr data=import cov noprob outp=import_corr;
	where year<=59;
	var DOPROD STOCK CONSUM;
run;

/*중심화와 척도화 ->표준화방법*/
proc standard data=import mean=0 std=1 out=import_stand;
	where year<=59;
	var IMPORT DOPROD STOCK CONSUM;
run;
/*데이터 비교*/
proc print data=import;
	where year<=59;
	var IMPORT DOPROD STOCK CONSUM;
run;
proc print data=import_stand;
	var IMPORT DOPROD STOCK CONSUM;
run;

/*표준화시킨 데이터를 통한 Principal components*/
proc princomp data=import_stand out=import_pc;
	var DOPROD STOCK CONSUM;
run;
proc print data=import_pc;
	var prin1-prin3;
run;



/*10장*/
/*표준화시킨 후 적합*/
proc reg data=import_stand plots=none;
	model IMPORT=DOPROD STOCK CONSUM;
run;
/*PC값을 통한 적합*/
proc reg data=import_pc plots=none;
	model IMPORT=Prin1 Prin2 Prin3;
run;


/*11장*/
data supervisor;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap10. 기타 회귀\supervisor.txt" expandtabs firstobs=2;
	input Y X1-X6;
run;
/*selection방법에 따른 모델 비교*/
proc reg data=supervisor plots=none;
	model Y=X1-X6 / selection=forward;
	model Y=X1-X6 / selection=backward;
	model Y=X1-X6 / selection=stepwise;
run;

/*CP값을 통한 selection*/
proc reg data=supervisor plots=none outest=supervisor_est;
	model Y=X1-X6 / selection=CP RMSE CP AIC BIC ;
run;
quit;


/*12장*/
data financial;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap10. 기타 회귀\financial.txt" expandtabs firstobs=2;
	input Y X1 X2 X3;
	id=_n_;
run;

/*로지스틱 회귀 적합*/
proc logistic data=financial;
	model Y(event='1')=X1 X2 X3;
	output out=financial_out resdev=resdev dfbetas=dfbetas difchisq=difchisq h=hi p=pred;
run;

/*로지스틱 회귀의 index plot*/
symbol i=none v=dot h=1;
proc gplot data=financial_out;
	plot resdev*id;
	plot dfbetas*id;
	plot difchisq*id;
run;

/*로지스틱 회귀의 selection*/
proc logistic data=financial;
	model Y(event='1')=X1 X2 X3 / selection=stepwise;
proc logistic data=financial;
	model Y(event='1')=X1 X2 X3 / selection=backward;
proc logistic data=financial;
	model Y(event='1')=X1 X2 X3 / selection=forward;
run;
