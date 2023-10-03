data test;
	infile "D:\test.txt" dlm='/' dsd firstobs=2;
	input student section test1 test2 test3 test4;
run;

data test_1;
	set test;
	if section=1 then do;
		test5=test1-10;
		test6=test2-14;
		end;
	else do;
		test5=test1+3;
		test6=test2+5;
		end;
run;	

data test_2;
	array test{6} test1-test6;
	set test_1;
	if section=1;
	total=0;
	do i=1 to 6;
	total=total+test{i};
	end;
	drop i;
run;

data preg;
	infile "D:\preg.txt" firstobs=2;
	input name$ preg_num date;
run;

data expo;
	infile "D:\expo.txt" firstobs=2;
	input name$ date exposlvl$;
run;

proc sort data=preg;
	by name;
run;
proc sort data=expo;
	by name;
run;

data bothid(where=(preg_date^=. & expo_date^=.));
	merge preg(rename=(date=preg_date)) expo(rename=(date=expo_date));
		by name;
run;

proc import datafile="D:\timerec.xlsx" out=timerec dbms=xlsx replace;
	getnames=yes;
run;

data timerec_1;
	set timerec;
	label employee='고용인'
			 phase='분석단계'
			 hours='시간';
run;
data emp1 emp2;
	set timerec;
	if employee='Chen' then output emp1;
	else if employee='Stewart' then output emp2;
	drop employee;
run;

data emp1 emp2;
	set timerec;
	if employee='Stewart' then output emp2;
	else output emp1;
	drop employee;
run;

data h_s;
	set emp1;
		retain hoursum 0;
		hoursum=hoursum+hours;
		drop hours;
run;

data grunfeld;
	infile "D:\grunfeld.txt" expandtabs;
	input sort$ invest stock value @@;
run;

proc means data=grunfeld;
	class sort;
	var invest stock value;
run;

data pdf;
	do x=1 to 20;
		normal=pdf("normal",x,10,2);
		output;
	end;
run;

proc gplot data=pdf;
	symbol i=spline v=none;
	plot normal*x;
run;
