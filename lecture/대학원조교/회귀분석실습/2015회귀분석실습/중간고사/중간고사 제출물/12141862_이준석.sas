data test;
infile "D:\test.txt"  dlm="/"  missover;
input student section test1 test2 test3 test4;
run;

data one;
set test;
if section = 1 then do;
test1= test1 - 10 ;
test2= teset2 - 14;
end;
else do;
test5=test1+3;
test6=test2+5;
end;
run;

data two;
set one;
array(6) array(i) test1 test2 test3 tes4 test5 test6;
if section = 1 then  do i = 1 to 6;
array=0;
sum=array+array(i);
end;
run;

data preg(rename= date =preg_date);
infile "D:\preg.txt" missover firstobs=2;
input name$ preg_num date;
run;

data expo(rename= date= expo_date);
infile "D:\expo.txt" missover firstobs=2;
input name$ date exposlvl$;
run;
proc sort data=preg;
by name;
run;
proc sort data=expo;
by name;
run;

data bothid;
merge preg expo;
by name;
run;
data three;
set bothid;
if preg_date>1 & expo_date>1 then output;
else delete;
  run;

proc import datafile = " D:\timerec.xlsx" out=timerec dbms=xlsx replace;
getnames=yes;
run; 

data four;
set timerec;
label employee="고용인"
        phase="분석단계"
		hours="시간";
		run;

data emp1 emp2;
set timerec;
if  employee="chen" then output emp1;
else output emp2;
drop employee;
run;

data five;
set emp1;
retain hoursum;
do i = 1 to 7 ;
hour=0;
hoursum=hour+hour(i);
drop hour;





data grunfeld;
infile "D:\grunfeld.txt" missover;
input sort$ invest stock value;
run;

proc means data=grunfeld ;
 var invest;
 var stock;
 var value;
class sort;
run;
 
data pdf;
normal=pdf("normal",10,2);
run;

proc gplot data=pdf;
x =1 to 20;
symbol i =spline v= none;
plot normal*x;
run;


