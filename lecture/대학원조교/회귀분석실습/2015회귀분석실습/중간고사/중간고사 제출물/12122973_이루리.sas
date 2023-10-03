data test;
	infile 'D:\test.txt' firstobs=2 dlm='/';
	input student section test1 test2 test3 test4;
	run;
data one;
	set test;
	if section=1 then do;
	test5=test1-10; 
	test6=test2-14;
	end;
	if section=2 then do;
	test5=test1+3;
	test6=test2+5;
	end;
run; 
data two;
	set one;
	if section=1 then output two;
run;
data two_1;
	set two;
	array arr{6} test1-test6;
	total=0;
		do i=1 to 6;
		total=total+arr{i};
		end;
run;
data preg;
	infile 'D:\preg.txt' firstobs=2;
	input name$ preg_num date;
	run;
data expo;
	infile 'D:\expo.txt' firstobs=2;
	input name$ date exposlvl$;
	run;
proc sort data=expo;
	by name;
	run;
proc sort data=preg;
	 by name;
	 run;
data bothid;
	merge expo(rename=(date=preg_date)) preg(rename=(date=expo_date));
	by name;
	run;
data bothid_1 ;
	merge expo(rename=(date=preg_date) where=(preg_num='0' delete preg_num)) preg(rename=(date=expo_date));
	by name ;
	run;


proc import datafile='D:\timerec.xlsx' out=timerec dbms=xlsx replace;
	getnames=yes;
	run;
data label;
	set timerec;
	label employee='고용인'
			phase='분석단계'
			hours='시간';
run;
data emp1  emp2;
	set timerec;
	if employee='Stewart' then output emp2;
	else output emp1;
	drop employee;
run;
proc means data=emp1 sum;
	class phase;
	var hours;
	run;

data grunfeld;
	infile 'D:\grunfeld.txt' expandtabs ;
	input sort$ invest stock value @@;
	run;
proc means data=grunfeld;
	class sort;
	var invest stock value;
	run;
data pdf;
	do x=1 to 20;
	normal=pdf('normal',x,10,2);
	output;
	end;
	run;
proc plot data=pdf;
	symbol i=spline v=none;
	plot normal*x;
	run;
