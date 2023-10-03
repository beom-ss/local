
/*1번*/
data test;
infile "d:/test.txt" dlm='/' dsd firstobs=2;
input student section test1 test2 test3 test4;
run;

data one;
set test;
if section=1 then do;
test5 = test1- 10;
test6 = test2- 14;
output;
end;
else do;
test5 = test1+3;
test6 = test2+5;
output;
end;
run;

data two;
set one(where=(section=1));
array x{6} test1-test6;
total=0;
do i=1 to 6;
total=total+x{i};
end;
run;



/*2번*/
data preg;
infile "d:/preg.txt" expandtabs firstobs=2;
input name$ preg_num date;
run;

data expo;
infile "d:/expo.txt" expandtabs firstobs=2;
input name$ date exposlvl$;
run;

proc sort data=preg; by name; run;
proc sort data=expo; by name; run;

data bothid; 
merge preg(rename=(date=preg_date)) expo(rename=(date=expo_date));
by name;
run;

data bothid1; 
merge preg(rename=(date=preg_date))expo(rename=(date=expo_date));
if preg_date = '.' then delete;
else if expo_date='.' then delete;
by name;
run;



/*3번*/
proc import datafile="d:/timerec.xlsx" out=timerec dbms=xlsx replace;
getnames=yes;
run;

data label;
set timerec(keep= employee phase hours);
label employee = '교용인'
		phase ='분석단계'
		hours = '시간';
	run;



data emp1 emp2;
set timerec;
if employee = "Chen" then output emp1;
else output emp2;
drop employee;
run;

data emp1 emp2;
set timerec;
if employee = "Stewart" then output emp2;
else output emp1;
drop employee;
run;


proc sort data=emp1; by phase; run;

data sum;
set emp1;
retain hoursum 0;
hoursum = hoursum + hours;
output;
if last.phase = 0 then delete;
drop hours;
run;




/*4번*/
data grunfeld;
infile "d:/grunfeld.txt" expandtabs;
input sort$  invest  stock  value;
run;


proc means data=grunfeld;
	class sort;
	var invest stock value;
	run;




/*5번*/
data pdf;
	do x=1 to 20;
	pdf=pdf('normal',x,10,2);
	output;
	end;
	run;

proc gplot data=pdf;
	symbol i=spline v=none;
	plot pdf*x;
run;
