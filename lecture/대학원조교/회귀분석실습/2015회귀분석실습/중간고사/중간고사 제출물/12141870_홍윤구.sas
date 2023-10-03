data work.test;
infile 'D:\test.txt'  dlm='/'  firstobs=2 ;
input student section test1 test2 test3 test4;
run;

data test1;
set test;
if (section = 1) then do;
			test5 = test1 - 10;
			test6 = test2 - 14;
			
			end;
else if (section =2) then do;
			test5 = test1 + 3;
			test6 = test2 + 5;
			
			end;
run;

data test7;
set test1(where=(section=1));
array test{6} test1 - test6;
	retain sum1 (0);
	
	do i=1 to 6;
		sum1 = sum1+test{i};
	end;	

drop i;
run;




data preg;
infile "D:\preg.txt" expandtabs firstobs = 2;
input name$ preg_num data;
run;

data expo;
infile "D:\expo.txt"  expandtabs firstobs=2;
input name$ date exposlvl$;
run;

proc sort data = expo;
by name;
run;
proc sort data = preg;
by name;
run;

data bothid;
merge preg(rename=(data = preg_date)) expo(rename=(date = expo_date));
by name;
run;

data bothid1;
merge preg(rename=(data = preg_date)) expo(rename=(date = expo_date));
by name;
if preg_date ^= NULL & expo_date ^= NULL;
drop NULL;
run;




proc import datafile = "D:\timerec.xlsx" out = timer dbms= xlsx replace;
getnames = yes;
run;

data Timer;
set timer;
label employee = '고용인'
		phase = '분석단계'
		hours = '시간'
		;
run;

data emp1 emp2;
set timer;
if (employee = 'Chen') then output emp1;
else if (employee = 'Stewart') then output  emp2;
drop employee;
run;

data emp1 emp2;
set timer;
 if (employee = 'Stewart') then output  emp2;
 else output emp1;
drop employee;
run;




proc means data = emp1 sum;
	var hours;
	by phase;
	run;







data grunfeldA;
infile "D:\grunfeld.txt" expandtabs ;
input sort$ invest stock value ;
run;

data grunfeldB;
infile "D:\grunfeld.txt" expandtabs ;
input sort$ invest stock value sort$ invest stock value;
run;

data grunfeld;
set grunfeldA grunfeldB;
run;

proc means data = grunfeld;
	by sort;
	run;



	data norm;
		do n=1 to 20 by 0.5;
			x = pdf('normal',n , 10,4);
			output;
			end;
	run;

	proc gplot data = norm;
		symbol i = spline v=none;
		plot x*n;
		run;









