data test;
infile "D:\test.txt" dlm=" / "  firstobs=2;
input student section test1 test2 test3 test4;
if section=1 then do;
test1=test1-10;
test2=test2-14;
end;
else do;
test5=test1+3;
test6=test2+5;
end; 
run; 

data sum;
set test;
array a{6} test1--test6;
if section=1 then do;
total=a{1}+a{2}+a{3}+a{4};
end;
run;

data preg;
infile "D:\preg.txt"  firstobs=2  ;
input name$ preg_num date;
run;

data expo;
infile "D:\expo.txt"  firstobs=2 ;
input name$ date exposlvl$;
run;


proc sort data=preg; by name; run;
proc sort data=expo; by name; run;
data bothid;
merge preg(rename=(date=PREG_DATE))
		   expo(rename=(date=EXPO_DATE));
by name;
run;

proc import datafile="D:\timerec.xlsx" dbms=xlsx out=timerec;
label employee='고용인'
	     phase='분석단계'
		 hours='시간';
run;

data emp1 emp2;
set timerec;
if employee = "Chen" then output emp1;
else if employee = "Stewart" then output emp2;
drop employee;
run;

data emp1 emp2;
set timerec;
if employee = "Stewart" then output emp2;
else output emp1;
drop employee;
run;

proc sort data= emp1 out=emp1;
by phase;
run;
data hours1;
set emp1;
hoursum=0;
if phase="Analysis" then do;
retain hoursum;
hoursum=hoursum + hours;
output;
end;
hoursum=0;
if phase="Coding" then do;
retain hoursum;
hoursum=hoursum + hours;
output;
end;
hoursum=0;
if phase="Testing" then do;
retain hoursum;
hoursum=hoursum + hours;
output;
end;
run;


data grunfeld;
infile "D:\grunfeld.txt" firstobs=1 ;
input sort$ invest stock value@@;
run;
proc means data=grunfeld;
class sort;
var invest stock value;
run;




data pdf;
do i=1 to 20;
pdf=pdf("normal",i,10,2);
output;
end;
run;
proc gplot data=pdf;
plot pdf*i;
symbol i=spline v=none;
run;
