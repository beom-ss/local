
/*1*/
data htwt;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\기말고사\htwt.txt" expandtabs firstobs=2;
	input sex$ age height weight;
run;

data htwt;
	set htwt;
	if sex='M' then sex_n=1;
	else sex_n=0;
run;

/*1-1*/
proc reg data=htwt plots=none;
	model weight=sex_n age height;
run;
/*weight_hat= -58.38247 - 0.15423 sex + 1.07856 age + 0.55514 height*/

/*1-2*/
*
H0 : beta1 = 0 vs H1 : beta1 ^= 0
FM : beta0 + beta1*sex + beta2*age + beta3*height
RM : (beta0 + beta1) + beta2*age + beta3*height
;
proc reg data=htwt plots=none;
	model weight=sex_n age height;
	test sex_n=0;
run;
*
검정 결과 p-value가 0.8322 로 유의하지 않은 것으로 나타남.
즉, 성별이 몸무게에 영향을 준다고 할 수 없다.
;


/*1-3*/
data newdat;
	input sex_n age height;
	cards;
1 16 160
;
run;

data htwt2;
	set htwt newdat;
run;

proc reg data=htwt2 plots=none;
	model weight=sex_n age height / clm cli;
run;
*
expected value의 C.I. : (46.6706 48.7225)
predicted value의 C.I : (37.0258 58.3673)
;

/*2*/
data acetyl;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\기말고사\acetyl.txt" expandtabs;
	input temp ratio time conv @@;
run;

/*2-1*/
proc corr data=acetyl plots=matrix noprob;
	var temp ratio time;
run;
*
		  temp 		ratio			 time 
temp 1.00000 0.22363 -0.95820 
ratio 0.22363 1.00000 -0.24023 
time -0.95820 -0.24023 1.00000 
;
proc reg data=acetyl plots=none;
	model conv=temp ratio time / vif;
run;
*
var     vif
temp 12.22505
ratio 1.06184
time 12.32496
temp와 time 사이에 다중공선성이 존재함
;

/*2-2*/
data acetyl;
	set acetyl;
	temp_ratio=temp*ratio;
	index=_N_;
run;

proc reg data=acetyl plots=none;
	model conv=temp ratio;
run;
/*conv_hat = -130.68986 + 0.13396 temp + 0.35106 ratio*/


proc reg data=acetyl plots=none;
	model conv=temp ratio temp_ratio;
	output out=acetyl_out student=ri;
	test temp_ratio=0;
run;
quit;
*
H0 : beta3 = 0 vs H1 : beta3 ^= 0
FM : beta0 + beta1*temp + beta2*ratio + beta3*temp_ratio
RM : beta0 + beta1*temp + beta2*ratio

conv_hat = -238.40165 + 0.22300 temp + 9.61689 ratio - 0.00761 temp_ratio
;

/*2-3*/
symbol i=sm60 v=dot h=1;
proc gplot data=acetyl_out;
	plot ri*index;
run;
goption reset=all;

/*이차곡선의 형태가 보인다*/




/*3*/
data fitness;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\기말고사\fitness.txt" dlm=',' firstobs=2;
	input Age Weight Oxygen RunTime RestPulse RunPulse MaxPulse Index;
run;

/*3-1 & 3-2*/
proc reg data=fitness plots=none; 
   model Oxygen=Age Weight RunTime RunPulse RestPulse MaxPulse;
   output out=fitness_out  p=yhat Residual=ei Student=ri Cookd=cooki DFFITS=df_fit h=hii ;
run;
quit;
/*Oxygen = 88.16262 - 0.14831 Age - 0.07776 Weight - 2.24833 RunTime - 0.65798 RunPulse - 0.07645 RestPulse + 0.64446 MaxPulse*/


proc gplot data=fitness_out;
	symbol i=none v=dot h=1;
	plot cooki*index;
	plot df_fit*index;
	plot hii*index;
run;

proc print data=fitness_out;
	where index=16 or index=28;
	var cooki df_fit hii;
run;
*
index	cooki	df_fit 		hii 
16 3.59966 5.96341 0.75253 : outlier, high leverage point
28 0.10528 0.85247 0.53262  : high leverage point
;


/*3-3*/
proc reg data=fitness plots=none; 
	where index^=16;
	model Oxygen=Age Weight RunTime RunPulse RestPulse MaxPulse;
run;
/*16번째 관측치를 제거하였을 때 변수의 계수가 상당히 크게 바뀌는 것을 확인할 수 있었다. -> influential point*/

proc reg data=fitness plots=none; 
	where index^=28;
	model Oxygen=Age Weight RunTime RunPulse RestPulse MaxPulse;
run;
/*28번째 관측치를 제거하였을 때 변수의 계수는 크게 변하지 않았다. -> influential point가 아니다.*/


/*3-4*/
proc reg data=fitness plots=none; 
	model Oxygen=Age Weight RunTime RunPulse RestPulse MaxPulse / selection=forward SLENTRY=0.05;
run;
	model Oxygen=Age Weight RunTime RunPulse RestPulse MaxPulse / selection=backward SLENTRY=0.05;
run;
	model Oxygen=Age Weight RunTime RunPulse RestPulse MaxPulse / selection=stepwise SLENTRY=0.05;
run;
quit;
*
forward : Oxygen_hat = 81.92858 - 1.98497 RunTime - 0.24326 RestPulse
backward : Oxygen_hat = 78.46959 - 2.83821 RunTime - 0.61666 RunPulse + 0.59768 MaxPulse
stepwise : Oxygen_hat = 81.92858 - 1.98497 RunTime - 0.24326 RestPulse
;













