
/*1*/
data test;
infile "d:/test.txt" dlm='/' firstobs=2;
input student section test1 test2 test3 test4;
run;

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

data test2;
set test1(where=(section=1));
array test{6} test1 test2 test3 test4 test5 test6;
total=0;
do i=1 to 6;
total=total+test{i};
end;
run;


/*2*/
data preg;
infile "d:/preg.txt" firstobs=2;
input name$ preg_num date;
run;

data expo;
infile "d:/expo.txt" firstobs=2;
input name$ date exposlvl$;
run;

data bothid;
merge preg(rename=(name=preg_date)) expo(rename=(name=expo_date));
run;

data bothid1;
merge preg(rename=(name=preg_date) missing) expo(rename=(name=expo_date) missing);
run;


/*3*/
proc import datafile="d:/timerec.xlsx" out=timerec dbms=xlsx replace;
getnames=yes;
run;

data timerec;
set timerec;
label employee='고용인'
		phase='분석단계'
		hours='시간';
run;

data emp1 emp2;
set timerec;
if employee="Stewart"  then output emp2;
else output emp1;
run;

data sum;
set emp1;
retain hoursum 0;
hoursum=hoursum+hours;
drop hours;
run;



/*4*/
data grunfeld;
infile "d:/grunfeld.txt" expandtabs;
input sort$ invest stock value @@;
run;

proc sort data=grunfeld;
by sort;
run;

proc means data=grunfeld;
var invest stock value;
by sort;
run;



/*5*/
data a;
do x=1 to 20; output;
pdf=pdf('normal',x,10,2);
end; 
run;

proc gplot data=a;
plot pdf*x;
symbol i=spline v=none;
run;


