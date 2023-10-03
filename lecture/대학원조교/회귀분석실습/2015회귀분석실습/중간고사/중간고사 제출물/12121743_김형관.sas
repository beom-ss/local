/* 1 */
data test;
infile "D:\test.txt" dlm=' / '  firstobs=2;
input student section test1 test2 test3 test4;
run;

data test_1;
set test;
if section = 1 then do;
test5=test1-10;
test6=test2-14;
end;
else if section = 2 then do;
test5=test1+3;
test6=test2+5;
end;
run;

data test_2;
set test_1(where=(section=1));
array arr{6}test1-test6;
total=0;
do i=1 to 6;
total=total+arr{i};
end;
run;

/* 2*/
data preg;
infile "D:\preg.txt" firstobs=2;
input name$ preg_num date;
run;

data expo;
infile "D:\expo.txt" firstobs=2;
input name$ date exposlvl$;
run;

proc sort data=preg; by name; run;
proc sort data=expo; by name; run;
data bothid;
merge preg(rename=(date=RPEG_DATE)) expo(rename=(date=EXPO_DATE));
by name;
run;
data bothid_1;
set bothid;
if RPEG_DATE=' '  EXPO_DATE= ' ' then delete;
run;


/* 3 */
proc import datafile="D:\timerec.xlsx" out=timerec dbms=xlsx replace;
getnames=yes;
run;

data timerec_1;
set timerec;
label employee="고용인"
		phase="분석단계"
		hours="시간"
		;
run;

data emp1 emp2;
set timerec;
if employee = "Stewart" then output emp2;
else output emp1;
drop employee;
run;

data hour;
set emp1;
retain hoursum first.hours;
		Hour=hoursum + hours;
drop Hour;
run;





/* 4 */
data grunfeld;
infile "D:\grunfeld.txt";
input sort$ invest stock value @@;
run;

proc means data=grunfeld;
 by sort;
 run;

 /* 5 */
 data plot;
do x=1 to 20;
 	pdf=pdf("normal",x,10,2);
	output;
	end;
	run;

proc gplot data=plot;
	symbol i=spline v=none;
	plot pdf*x;
	run;





















