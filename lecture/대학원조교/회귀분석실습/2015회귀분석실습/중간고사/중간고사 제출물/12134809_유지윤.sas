
/*1번*/
/*1-1*/
data test;
infile "D:\회귀실\test.txt" dlm='/' ;
if section='1' then do ;
test1=test1-'10';
test2=test2-'14';
end;
else if section='2' then;
test5=test1+'3';
test6=test2+'5';
run;

/*1-2*/
data test2(where=(section=1));
set test;
array arr{6} test1-test6;
total=0;
do i= 1 to 6;
total=total+test{i};
end;
run;

/*2번*/
/*2-1*/

data preg;
infile "D:\회귀실\preg.txt" firstobs=2;
input name$ preg_num date;
run;
data expo;
infile "D:\회귀실\expo.txt"firstobs=2;
input name$ date exposlvl$ ;
run;
data bothid;
merge preg(rename=(date=PREG_DATE)) expo(rename=(date=EXPO_DATE));
run;


/*3번*/
/*3-1*/
proc import datafile="D:\회귀실\timerec.xlsx" out=timerec dbms=xlsx replace;
getnames=yes;
run;

data timerec1;
set timerec;
label employee='고용인'
	phase='분석단계'
	hours='시간'
	;
	run;

/*3-2*/
data emp1 emp2;
set timerec;
if employee = "Stewart" then output emp2;
else output emp1;
drop employee;
run;

/*3-3*/
data test3;
set emp1;
retain hoursum 0;




/*4번*/

data grunfeld;
infile "D:\회귀실\grunfeld.txt" ;
input sort$ invest stock value @@ ;
run;

proc means data=grunfeld;
class sort;
run;

/*5번*/


data pdf;
do x= 1 to 20 ;
x=x+1;
norpdf=pdf("normal",x,10,2);
end;
run;

proc plot data=pdf;
symbol i=spline v=none;
=pdf(norpdf)*x;
run;
