data test;
input student section test1 test2 test3 test4;
cards;
238900545 1 94 91 87 64
254701167 1 95 96 97 88
238806445 2 91 86 94 91
999002527 2 80 76 78 53
263924860 1 92 40 85 69
459700886 2 75 76 80 70
416724915 2 66 69 72 59
999001230 1 82 84 80 66
242760674 1 75 76 70 82
990001252 2 51 66 91 86
;
run;

data test_1_1;
set test;
if section=1
then
test5= test1-10;
test6=test2-14;
if section=2
then
test5=test1-3;
test6=test2-5;
run;

data testsum;
set test_1_1;
sum=test1+test2+test3+test4+test5+test6;
run;



data preg;
input name$ preg_num date;
rename date=preg_date;
cards;
JONES 2 741202 
CONNERS 1 600718 
SMITH 1 620427 
CONNERS 3 650926 
NEELY 1 710111 
JONES 3 770614 
CONNERS 2 620809
run;

data expo;
input name$ date exposlvl$;
rename date=expo_date;
cards;
JONES 721230 LOW 
SMITH 601017 HIGH 
CONNERS 641112 LOW 
CARSON 680119 MED 
GRANT 710315 HIGH
;
run;



data bothid;
merge preg expo;
by name;
drop preg_num exposlvl;
run;




data timerec;
input employee$ phase$ hours;
cards;
Chen Analysis 8
Chen Analysis 7
Chen Coding 2.5
Chen Testing 8
Chen Coding 8.5
Chen Testing 6
Chen Coding 4
Stewart Coding 8
Stewart Testing 4.5
Stewart Coding 4.5
Stewart Coding 10.5
Stewart Testing 10
;
run;

data timerec1;
set timerec;
label employee=고용인;
label phase=분석단계;
label hours=시간;
run;

data emp1 emp2;
set timerec;
if employee= "Chen" then output emp1;
if employee= "Stewart" then output emp2;
drop employee;
run;








