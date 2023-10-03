data test;
infile "C:\Users\a25\Desktop\새 폴더/test.txt" firstobs=2;
input student 1-9 section 11  test1 13-14 test2 16-17 test3 19-20 test4 22-23;
run;

data question1_1;
set test;

if section='1' then do;
test5=test1-10;
test6=test2-14;
end;

if section='2' then do;
test5=test1+3;
test6=test2+5;
end;
run;
 
 data question1_2(drop=i);
 set question1_1;
 array sum{6} test1-test6;
 total=0;
 do i=1 to 6;
 if section='1' then total=total+sum{i};
 end;
 run;
data preg;
infile "C:\Users\a25\Desktop\새 폴더\preg.txt" firstobs=2;
input name$ preg_num date;
run;

data expo;
infile "C:\Users\a25\Desktop\새 폴더\expo.txt" firstobs=2;
input name$ date exposlvl$;
run;

data preg1;
set preg(rename=(date=PREG_DATE));
run;

data expo1;
set expo(rename=(date=EXPO_DATE));
run;

data bothid;
merge preg1 expo1;
run;

proc import datafile="C:\Users\a25\Desktop\새 폴더\timerec.xlsx" dbms=xlsx out=timerec replace;
getnames=yes;

run;

data question3_1;
set timerec;
label employee='고용인';
label phase='분석단계';
label hours='시간';
run;
proc print data=question3_1 label;
run;
data question3_2(drop=employee);
set timerec;
if employee='Chen' then output emp1;
if employee='Stewart' then output emp2;
run;

data question4;
infile "C:\Users\a25\Desktop\새 폴더\grunfeld.txt";
input sort$ invest stock value;
run;

proc means data=question4;
var invest stock value;
class sort;
run;

data question5;
do x=1 to 20;
func_pdf=pdf('normal',x,10,2);
output;
end;

proc gplot data=question5;
symbol i=spline v=none;
plot func_pdf*x;
run;
