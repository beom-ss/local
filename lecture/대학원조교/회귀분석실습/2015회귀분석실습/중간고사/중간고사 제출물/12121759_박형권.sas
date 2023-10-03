data test;
infile "C:\test.txt" dlm='/' firstobs=2;
input student$ section test1 test2 test3 test4;
run;

data pm1_1;
	set test;
	if section = 1 then do;
		test5 = test1 - 10;
		test6 = test2 - 14;
		end;
	else do;
		test5 = test1 + 3;
		test6 = test2 + 5;
		end;
	run;

data pm1_2;
	set pm1_1(where=(section=1));
	array test{6} test1-test6;
	total = 0;
	do i = 1 to 6;
	total = total + test{i};
	end;
	drop i;
run;

data preg;
	infile "C:\preg.txt" dlm = ' ' firstobs=2;
	input name$ preg_num date$;
run;

data expo;
	infile "C:\expo.txt" dlm = ' ' firstobs=2;
	input name$ date$ exposlvl$;
run;

proc sort data = preg;
by name;
run;
proc sort data = expo;
by name;
run;
data bothid;
	merge preg (rename =(date = preg_date))
			   expo (rename =(date = expo_date));
	by name;
run;

data bothid2;
	set bothid(where=(preg_date ^= '' and expo_date ^= ''));
run;

proc import datafile = "C:\timerec.xlsx" out = timerec dbms = xlsx replace;
						getnames = yes;
				run;

data pm3_1;
	set timerec;
	label employee = '고용인'
			phase = '분석단계'
			hours = '시간';
	run;
data emp1 emp2;
	set timerec;
	if employee = 'Chen' then output emp1;
	else output emp2;
	drop employee;
run;

data emp1 emp2;
	set timerec;
	if employee = 'Stewart' then output emp2;
	else output emp1;
	drop employee;
run;

proc sort data = emp1 out = emp1_1;
by phase;
run;
data pm3_3;
	set emp1_1;
	retain hoursum 0;
	do;
	if last.phase = 1 then ;
	hoursum = hoursum + hours;
	retain hoursum 0;
	end;
	drop hours;
run;

proc means data = emp1 sum;
		var hours;
		class phase;
		output out = pm3_3_ 
							sum = hoursum;
		run;

data grunfeld;
	infile "C:\grunfeld.txt"  dlm = ' ';
	input sort$ invest stock value @@;
	run;

proc sort data = grunfeld;
by sort;
run;
proc means data = grunfeld;
		var invest stock value;
		class sort;
		run;



data pm5;
	do x = 1 to 20;
	normal = pdf('normal', x, 10, 2);
	output;
	end;
run;

proc gplot data = pm5;
	symbol i=spline v=none;
	plot normal * x;
run;
