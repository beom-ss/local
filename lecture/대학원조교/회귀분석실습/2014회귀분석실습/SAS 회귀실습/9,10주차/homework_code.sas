/*데이터 읽기*/
data multireg;
	infile 'C:\Users\kuksunghee\Desktop\multireg.txt' expandtabs ;
	input y x1 x2;
run;

/*그래프 그리기 */
proc plot data=mulireg vpercent=33 hpercent=50;
	plot y=x1; plot y=x2;
run;

/* 상관관계*/
proc corr data=multireg;
	var y x1 x2;
run;

/*회귀분석 및 신뢰구간 구하기 */
proc reg data=multireg;
	model y=x1 x2/clm cli;
run;

/*회귀분석 결과를 데이터 셋으로 만들 경우*/
proc reg data=multireg outest=result;
	model y=x1 x2/clm cli;
quit;run;

/*beta들의 신뢰구간을 구하기 위해 beta의 parameta estimate, se 값 입력*/
data beta_cl;
input beta se;
cards;
2.34123 1.09673
1.61591 0.17073
0.01438 0.00361
;
run;

/* beta들의 신뢰구간 구하기*/
data cl;
set beta_cl;
up=beta+se*tinv(0.975,22);
low=beta-se*tinv(0.975,22);
run;

/* 새로운 값의 신뢰구간을 구하기 위해 값 입력*/
data test;
input x1 x2;
cards;
8 200
;
run;
/* 원래의 데이터와 합치기*/
data test2;
	set test multireg;
run;

/* proc reg 문을 이용하여 신뢰구간 구하기 */
proc reg data=test2;
	model y=x1 x2/clm cli;
run;



