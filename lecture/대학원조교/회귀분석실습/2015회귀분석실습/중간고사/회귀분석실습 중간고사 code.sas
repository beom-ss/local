
/*1번*/
data test;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\중간고사\test.txt" dlm='/' firstobs=2;
	input student section test1 test2 test3 test4;
run;

/*1-1*/
data test;
	set test;
	if section=1 then do;
			test5=test1-10;
			test6=test2-14;
			end;
	else do;
			test5=test1+3;
			test6=test2+5;
			end;
run;

/*1-2*/
data test;
	set test(where=(section=1)); 
	/*if section=1;*/
	array test{6} test1-test6;
	total=0;
	do i=1 to 6;
		total=total+test{i};
	end;
	drop i;
run;




/*2번*/
data preg;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\중간고사\preg.txt" firstobs=2;
	input NAME $ PREG_NUM DATE;
run;
data expo;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\중간고사\expo.txt" firstobs=2;
	input NAME $ DATE EXPOSLVL $;
run;

/*2-1&2*/
proc sort data=preg; by name; run;
proc sort data=expo; by name; run;

data bothid;
	merge preg(rename=(date=PREG_DATE)) expo(rename=(date=EXPO_DATE));
	by name;
	if preg_date^=. & expo_date^=. then output;
/*	if preg_date=. | expo_date=. then delete;*/
/*	if preg_date & expo_date;*/
/*	if preg_date & expo_date=1;*/
run;





/*3번*/
proc import datafile="D:\대학원 자료\회귀분석실습\2015회귀분석실습\중간고사\timerec.xlsx" out=timerec dbms=xlsx replace;
	getnames=yes;
run;

/*3-1*/
data timerec;
	set timerec;
	label employee='고용인'
			phase='분석단계'
			hours='시간';
run;

/*3-2*/
data emp1 emp2;
	set timerec;
	if employee="Chen" then output emp1;
	else output emp2;
	drop employee;
run;

/*3-3*/
proc sort data=emp1; by phase; run;
data emp1_1;
	set emp1;
	by phase;
	retain hoursum 0;
	hoursum=hoursum+hours;
	if last.phase then do;
			output;
			hoursum=0;
			end;
	drop hours;
run;

/*
proc sort data=emp1; by phase; run;
data emp1_1;
	set emp1;
	by phase;
	retain hoursum 0;
	hoursum=hoursum+hours;
	if last.phase=1;
	drop hours;
run;
*/


/*4번*/
data grunfeld;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\중간고사\grunfeld.txt";
	input sort$ invest stock value @@;
run;
proc means data=grunfeld;
	class sort;
	var invest stock value;
run;

/*
proc sort data=grunfeld;
	by sort;
run;
proc means data=grunfeld;
	by sort;
	var invest stock value;
run;
*/


/*5번*/
data pdf;
	do x=1 to 20;
	pdf=pdf("normal",x,10,2);
	output;
	end;
run;
symbol i=spline v=none;
proc gplot data=pdf;
	plot pdf*x;
run;



