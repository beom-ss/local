data test;
infile "D:\test.txt" dlm= '/' firstobs=2 ;
input  student section test1 test2 test3 test4;
run;

data test_1;
set test;
if section=1 then
 test5=test1-10;
 test6= test2-14;
 if section=2 then 
test5=test1+3;
test6=test2+5;

if section= 1; 
array test{6} test1-test6;
total=0;
do i=1 to 6;
total= total+test{i};
end;
run;



data preg;
infile "D:\preg.txt" firstobs=2;
input  name$  preg_num  date;
run;

data expo;
infile "D:\expo.txt" firstobs=2;
input  name$ date exposlvl$ ;
run;

proc sort  data= preg(rename=(DATE= PREG_DATE)); by name; run;
proc sort data= expo(rename=(DATE=EXPO_DATE));  by name; run;

data bothid;
merge preg expo;
by name;
run;

proc import datafile="D:\timerec.xlsx" out= timerec dbms=xlsx replace;
getnames=yes;
run;


data timerec_1;
set timerec;
label employee= '고용인'
        phase= '분석단계'
		hours='시간';

		run;


data emp1;
set timerec;
if employee= Chen;
run;

data emp2;
set timerec;
if employee= Stewart;
drop employee;
run;

data emp1_1;
set emp1;
retain hoursum=0;
hoursum= hour+


data grunfeld;
infile "D:\grunfeld.txt"  ;
input  sort$ invest stock value ;
run;

proc means data=grunfeld;
by sort;
run;

data pdf ;
do x=1 to 20;
pdf=pdf("normal",10,2);
run;

proc gplot data= pdf;
symbol i=spline v=none;
run;
 














