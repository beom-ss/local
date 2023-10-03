data test;
	infile "D:\test.txt" firstobs=2 dlm='/';
	input student section test1 test2 test3 test4;
run;

data ans11;
set test;
input test5 test6;
if section1=1 then do
test5=test1-10;
test6=test2-14;
end;
else do
	test5=test1+3;
	test6=test2+5;
end;
run;

data ans12;
set test;
if section^=1 then delete;
array to{6} test1 test2 test3 test4 test5 test6;
total=0;
do x=1 to 6;
	total=total+to{x};
end;
drop x;
run;






data preg;
	infile "D:\preg.txt" expandtabs firstobs=2;
	input name$ preg_num date;
run;

data expo;
	infile "D:\expo.txt"  expandtabs firstobs=2;
	input name$ date exposlvl$;
run;

data bothid;
merge preg(rename=(date=preg_date)) expo(rename=(date=expo_date));
run;







proc import datafile="D:\timerec.xlsx" out=timerec dbms=xlsx replace;
getnames=yes;
run;

data ans31;
set timerec;
label 
	employee='고용인'
	phase='분석단계'
	hours='시간';
run;

data emp1 emp2;
set timerec;
if employee^='Stewart' then output emp1;
else output emp2;
run;






data grunfeld;
	infile "D:\grunfeld.txt" expandtabs ;
	input a$ b c d e$ f g h i;
run;

proc sort data=grunfeld;






data ans5;
do x=1 to 20;
nor=pdf("normal",x, 10, 2);
output;
end;
run;

proc gplot data=ans5;
symbol i=spline v=nine;
plot nor*x;
run;
