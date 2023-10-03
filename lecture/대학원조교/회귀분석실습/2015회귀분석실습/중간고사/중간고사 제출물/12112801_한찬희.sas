/*1번*/
data test;
infile "d:\test.txt" dlm='/' firstobs=2;
input student section test1 test2 test3 test4;
run;
/*(1)*/
data test1;
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
/*(2)*/
data test2;
set test1;
if section=1;
array x{6} test1-test6;
total=0;
do i=1 to 6;
total=total+x{i};
end;
drop i;
run;

/*2번*/
data preg;
infile "d:\preg.txt" firstobs=2;
input name$ preg_num date;
run;
data expo;
infile "d:\expo.txt" firstobs=2;
input name$date exposlvl$;
run;
/*(1)*/
proc sort data=preg;
by name;
run;
proc sort data=expo;
by name;
run;
data bothid;
merge preg(rename=(date=PREG_DATE)) expo(rename=(date=EXPO_DATE));
by name;
run;

/*(2)*/
data bothid2;
set bothid;
if PREG_DATE=. then delete;
if EXPO_DATE=. then delete;
run; 

/*3번*/
proc import datafile="d:\timerec.xlsx" out=timerec dbms=xlsx replace;
getnames=yes;
run;
/*(1)*/
data timerec1;
set timerec;
label employee='고용인' phase='분석단계' hours='시간';
run;
/*(2)*/
data emp1 emp2;
set timerec;
if employee='Stewart' then output emp2;
else output emp1;
drop employee;
run;
/*(3)*/
data one;
set emp1;
retain hoursum 0;
hoursum=hoursum+hours;
if hoursum<44 then delete;
drop hours;
run;

/*4번*/
data grunfeld;
infile "d:\grunfeld.txt";
input sort$ invest stock value @@;
run;
proc means data=grunfeld;
var invest stock value;
class sort;
run;

/*5번*/
data image;
do x=1 to 20;
normal=pdf("normal",x,10,2);
output;
end;
run;

proc gplot data=image;
symbol i=spline v=none;
plot normal*x;
run;
