data test;
	infile "D:\test.txt" dlm='/' firstobs=2;
	input student section test1 test2 test3 test4;
run;

/*1번문제*/

data Q1_1;
	set test;
	test5=0;
	test6=0;
	if section=1 then test5=test1-10;
	else if section=2 then test5=test1+3;
	if section=1 then test6=test2-14;
	else if section=2 then test6=test2+5;
run;

data Q1_2;
	set test(where=(section=1));
	array test{4} test1 test2 test3 test4;
	total=0;
	do i = 1 to 4;
	total = total+test{i};
	drop i;
	end;
run;

/*2번문제*/

data preg;
	infile "D:\preg.txt" expandtabs firstobs=2;
	input name$ preg_num date;
run;

data expo;
	infile "D:\expo.txt" expandtabs firstobs=2;
	input name$ date exposlvl$;
run;
proc sort data=preg;
by name;
run;
proc sort data=expo;
by name;
run;
data bothid(where=(PREG_DATE & EXPO_DATE>0));
merge preg(rename=(date=PREG_DATE))
	  expo(rename=(date=EXPO_DATE));
run;

/* 5번문제*/

data Q5;
	do x = 1 to 20;
pdf = pdf('normal',x,10,2);
	output;
	end;
run;

proc gplot data=Q5;
	symbol i=spline v=none;
plot pdf*x;
run;

/*4번문제*/

data grunfeld;
	infile "D:\grunfeld.txt" expandtabs;
	input sort$ invest stock value @@;
run;

proc means data=grunfeld;
	var invest stock value;
	class sort;
run;

/*3번문제*/

proc import datafile="D:\timerec.xlsx" out=timerec dbms=xlsx replace;
	getnames=yes;
run;

data emp1 emp2;
	set timerec;
	label employee='고용인'
			phase='분석단계'
			hours='시간';
if employee="Chen" then output emp1;
else if employee="Stewart" then output emp2;
drop employee;
run;

data emp1 emp2;
	set timerec;
	label employee='고용인'
			phase='분석단계'
			hours='시간';
if employee="Stewart" then output emp2;
else output emp1;
drop employee;
run;

data Q3_3;
	set emp1;
retain hoursum=0
hoursum=hoursum+hours;
run;

	
