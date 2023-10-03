data test;
	infile"D:\test.txt" dlm='/' dsd missover firstobs=2;
	input student section test1 test2 test3 test4;
run;

data test1;
	set test;
	if section=1 then test5=test1-10;
	if section=1 then test6=test2-14;
	if section=2 then test5=test1+3;
    if section=2 then test6=test2+5;
	run;
data test2;
	set test1(where=(section=1));
	array x{6} test1-test6;
	sum = 0;
	do i=1 to 6;
	sum = x{i}+sum;
	end;
	run;
data preg(rename=(date=preg_date));
	infile"d:\preg.txt" expandtabs firstobs=2;
	input name$ preg_num date;
	run;
data expo(rename=(date=expo_date));
	infile"d:\expo.txt" expandtabs firstobs=2;
	input name$ date exposlvl$;
	run;
proc sort data=preg;
by name;
run;
proc sort data=expo;
by name;
run;
data bothid(where=(preg_date*expo_date^=.)) ;
set preg expo;
   merge preg expo;
   by name;
   run;
proc import datafile="d:\timerec.xlsx" dbms=xlsx out=timerec;
getnames=yes;
run;
data timerec1;
set timerec;
	label employee='고용인'
			phase='분석단계'
			hours='시간';
	run;
data emp1 emp2;
set timerec;
if employee='Stewart' then set emp2 ;
else set emp1;
run;

data grunfeld;
	infile"d:\grunfeld.txt" expandtabs;
	input sort$ invest stock value sort1$ invest1 stock1 value1;
	run;

proc means data=grunfeld;
run;

data pdf;
	pdf=pdf('normdist',10,2);
	run;
proc gplot data=pdf;
	x=1 to 20;
	symbol i=spline v=none c=red;
	run;
