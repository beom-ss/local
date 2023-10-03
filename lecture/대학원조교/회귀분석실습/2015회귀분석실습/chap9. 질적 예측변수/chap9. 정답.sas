/*데이터 입력*/
data class;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap9. 질적 예측변수\class_data.txt" expandtabs firstobs=2 ;
	input Age Height Weight Sex ;
run;

/*1*/
/*산점도*/
goption reset=all;
symbol v=dot i=r;
proc gplot data=class;
	plot  Weight*Height;
run;

/*그룹별 산점도*/
goption reset=all;
symbol v=dot i=r;
proc gplot data=class;
	plot Weight*Height=Sex;
run;

/*2*/
/*기본 회귀모형 적합*/
proc reg data=class plots=none;
	model Weight=Height Sex;
	output out=class_out student=ri;
run;

/*3*/
/*잔차 탐색*/
goption reset=all;
symbol v=dot  h=1;
proc gplot data=class_out;
	plot ri*Height=Sex;            /*성별에 따라 군집되어 있는 것을 확인*/
	plot ri*Sex;                       /*남자와 여자인 경우 오차의 분산에 차이가 있음을 확인 ->이는 7장에서 다루도록 함*/
run;

/*4*/
/*interaction term을 고려한 모형 적합 및 검토*/
data class1;
	set class;
	HS=Sex*Height;
run;
proc reg data=class1 plots=none;
	model Weight = Height Sex HS;
run;
/* 유의하지 않은 HS를 제거 */

proc reg data=class1 plots=none;
	model Weight=Height Sex;
run;

/*5*/
proc reg data=class1 plots=none;
	model Weight=Age Height Sex;
	test Age=0;
	output out=class1_out student=ri;
run;
/*Age는 유의하지 않다. 즉 몸무게에 영향을 미치지 않는다*/

