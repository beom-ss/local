infile "C:/Users/a63/Desktop/test"
run;
data test11;
set test;
if section='1' then test5=test1-'10' test6=test2-'14';
if section='2' then test5=test1+'3' test6=test2+'5';
output;
run;
data test12;
set test;
keep section='1';
output;
run;
array test12 arr{6} sum(test1-test6);
run;

infile "C:/Users/a63/Desktop/preg";
run;
infile "C:/Users/a63/Desktop/expo";
run;
data test21;
set preg expo;
rename(preg=preg_date expo=expo_date);
merge(preg_date expo_date);
run;
proc import datafile="C:/Users/a63/Desktop/timerec" out=timerec dbms=xlsx replace;
run;
data timerec1;
set timerec;
label employee ='고용인';
label phase= '분석단계';
label hours= '시간';
run;

infile "C:/Users/a63/Desktop/grunfeld";
run;
proc means grunfeld;
var invest stock value;
class sort;
output;
run;
proc print;
Normal=Normal(10,x,2);
do x=1==20;
end;
output;
run;
proc gplot test5;
symbol i=spline v=none;
run;


