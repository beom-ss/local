data test ;
infile "D:/test.txt"  firstobs=2  dlm='/' ;
input student section test1 test2 test3 test4 ;
run ;

data test1 ;
set test ;
if section=1 then do ;
test5=test1-10 ;
test6=test2-14;
end;
else do ;
test5=test1+3;
test6=test2+5;
end;
run;

data test2 ;
set test1(where=(section=1)) ;
array test{6} test1-test6 ;
total = 0;
do i=1 to 6 ;
total= total+test{i} ;
end;
drop i ;
run ;

data preg ;
infile "D:/preg.txt" firstobs=2 ;
input name$ preg_num date ;
run ;

data expo ;
infile "D:/expo.txt" firstobs=2;
input name$ date exposlvl$ ;
run ;

proc sort data=preg ; by name ; run ;
proc sort data=expo; by name;  run;

data bothid(where=(preg_date^=. and expo_date^=.))  ;
merge preg(rename=(date=PREG_DATE)) expo(rename=(date=EXPO_DATE));
by name ;
run ;

proc import datafile="D:/timerec.xlsx"  out=timerec dbms=xlsx replace ;
getnames=yes ;
run ;

data timerec1;
set timerec ;
label employee='고용인' 
		phase='분석단계'
		hours='시간';
	run ;
data emp1 emp2 ; 
set timerec; 
if employee='Chen' then output emp1;
else output emp2;
drop employee ;
run;  



data emp1 emp2 ;
set timerec;
if employee='Stewart' then output emp2 ;
else output emp1;
drop employee ;
run ;
proc sort data=emp1 ;
by phase ;
run;

data emp3 ;
set emp1 ;
by phase ;
retain hoursum 0 ;
hoursum=hoursum+hours ;
if last.phase=1 ;
drop hours ;
run ;



data grunfeld ;
infile "D:/grunfeld.txt" ;
input sort$ invest stock value @@ ;
run ;

proc means data=grunfeld  ;
var invest stock value ;
class sort ;
run ;

data PDF ;
do x=1 to 20 ;
normal=pdf("normal",x,10,2) ;
output;
end ;
run;

proc gplot data=pdf ;
symbol i=spline v=none ;
plot normal*x ;
run ;
