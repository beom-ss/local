data test;
infile "C:\Users\a14\Desktop\test.txt" dlm='/' firstobs=2;
input student section test1 test2 test3 test4;
run;

data one_one;
set test;
if section=1 then do;
	test5 = test1-10;
	test6 = test2 - 14;
end;
else do;
	test5 = test1+3;
	test6 = test2+5;
end;
run;

data one_two;
set one_one(where=(section=1));
array a{6} test1-test6;
sum = 0;
do i = 1 to 6;
sum=sum + a{i};
end;
drop i;
run;

data preg;
infile "C:\Users\a14\Desktop\preg.txt" firstobs=2;
input name$ preg_num date;
run;

data expo;
infile "C:\Users\a14\Desktop\expo.txt" firstobs=2;
input name$ date exposlvl$;
run;

data bothid;
merge preg(rename=(date=PREG_DATE) firstobs=1 obs=5) expo(rename=(date=EXPO_DATE) firstobs=1 obs=5);
run;


proc import datafile = "C:\Users\a14\Desktop\timerec.xlsx" out=timerec dbms=xlsx replace;
getnames = yes;
run;

data three_one;
set timerec;
label employee="고용인"
		phase="분석단계"
		hours="시간";
run;

data emp1 emp2;
set timerec;
if employee='Chen' then output emp1;
else output emp2;
drop employee;
run;

data emp1 emp2;
set timerec;
if employee='Stewart' then output emp2;
else output emp1;
drop employee;
run;

proc sort data = emp1;
by phase;
run;

data three_three;
set emp1;
if first.phase=1 then hoursum = 0;
retain hoursum 0;
hoursum = hoursum + hours;
drop hours;
by phase;
if last.phase=1;
run;

data grunfeld;
infile "C:\Users\a14\Desktop\grunfeld.txt";
input sort$ invest stock value @@;
run;

proc means data=grunfeld;
var invest stock value;
class sort;
run;

data five;
do x=1 to 20;
normal_pdf = pdf('normal',x,10,2);
output;
end;
run;

proc gplot data = five;
symbol i = spline v=none;
plot normal_pdf*x;
run;


	
