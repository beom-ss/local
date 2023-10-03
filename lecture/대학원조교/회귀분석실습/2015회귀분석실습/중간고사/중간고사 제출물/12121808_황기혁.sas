/*1번*/
data test;
	infile "D:\test.txt" dlm='/' firstobs=2;
	input student section test1 test2 test3 test4;
run;
/*1-(1)*/
data test2;
	set test;
	test5=0;
	test6=0;
	if section=1 then do;
		test5=test1-10;
		test6=test2-14;
		end;
	else do;
		test5=test1+3;
		test6=test2+5;
		end;
run;
/*1-(2)*/
data test3;
	set test2(where=(section=1));
	array test{6} test1-test6;
	total=0;
	do i=1 to 6;
		total=total+test{i};
	end;
	drop i;
run;

/*2번*/
data preg;
	infile "D:\preg.txt" dlm=" " firstobs=2;
	input name$ preg_num date;
run;
data expo;
	infile "D:\expo.txt" dlm=" " firstobs=2;
	input name$ date exposlvl$;
run;
proc sort data=preg; by name; run;
proc sort data=expo; by name; run;
/*2-(1)*/
data bothid;
	merge preg(rename=(date=PREG_DATE)) expo(rename=(date=EXPO_DATE));
	by name;
run;
/*2-(2)*/
data bothid; 
	merge preg(rename=(date=PREG_DATE) ) expo(rename=(date=EXPO_DATE));
	by name;
	if preg_date='null' | expo_date='null' then delete;
run;

/*3번*/
proc import datafile="D:\timerec.xlsx" out=timerec dbms=xlsx replace;
	getnames=yes;
run;
/*3-(1)*/
data timerec2;
	set timerec;
	label employee='고용인' phase='분석단계' hours='시간';
run;
/*3-(2)*/
data emp1 emp2;
	set timerec2;
	if employee='Chen' then output emp1;
	else output emp2;
	drop employee;
run;
data emp1 emp2;
	set timerec2;
	if employee='Stewart' then output emp2;
	else output emp1;
	drop employee;
run;
/*3-(3)*/
proc sort data=emp1; by phase; run;
data emp1_2;
	set emp1;
	retain hoursum 0;
	hoursum=hoursum+hours;
	by phase;
	if last.phase=1 then do;
		output;
		hoursum=0;
		end;
	drop hours;
run;



/*4번*/
data grunfeld;
	infile "D:\grunfeld.txt" dlm=" ";
	input sort$ invest stock value @@;
run;
proc sort data=grunfeld;
	by sort;
run;
proc means data=grunfeld;
	var invest stock value;
	by sort;
run;

/*5번*/
data pdf;
	do x=1 to 20;
		norm_pdf=pdf("normal",x,10,2);
		output;
	end;
run;
proc gplot data=pdf;
	symbol i=spline v=none;
	plot norm_pdf*x;
run;
