data test;
infile "C:\Users\a13\Desktop\test.txt" dlm='/' firstobs=2;
input student section test1 test2 test3 test4;
if section="1" then do;
test5=test1-10;
test6=test2-14;
end;
else do;
test5=test1+3;
test6=test2+5;
end;
run;

data test1_1;
set test(where=(section=1));
array test{6} test1 test2 test3 test4 test5 test6;
total=0;
do i=1to 6;
total=total+test{1};
end;
run;

data preg;
infile "C:\Users\a13\Desktop\preg.txt" expandtabs firstobs=2;
input name$ preg_num date;
run;

data expo;
infile "C:\Users\a13\Desktop\expo.txt" expandtabs firstobs=2;
input name$ date exposlv$;
run;
proc sort data=preg;
by name;
run;
proc sort data=expo;
by name;
run;
data bothid;
set preg(rename=(date=preg_date)) expo(rename=(date=expo_date));
by name;
merge preg expo;
run;




proc import datafile="C:\Users\a13\Desktop\timerec.xlsx" out=timerec dbms=xlsx replace;
getnames=yes;
run;

data timerec_1;
set timerec;
label employee='고용인';
label phase='분석단계';
label hours='시간';
run;

data emp1 emp2;
set timerec;
if employee="Chen" then output emp1;
else output emp2;
drop employee;
run;
data emp1 emp2;
set timerec;
if employee="Stewart" then output emp2;
else output emp1;
drop employee;
run;

data hoursum(drop=hours);
set emp1;
retain hoursum 0;
hoursum=hoursum+hours;
run;




data grunfeld;
infile "C:\Users\a13\Desktop\grunfeld.txt" expandtabs;
input sort$ invest stock value @@;
run;
proc sort data=grunfeld;
by sort;
run;

proc means data=grunfeld;
by sort;
run;

data normal;
do x=1 to 20;
nor_pdf=pdf("normal",10,2)*x;
end;
run;


proc plot data=normal;
symbol i=spline v=none;
run;











