/*1-1번문제*/
data test;
	infile "C:\test.txt" dlm='/' firstobs=2;
	input student section test1 test2 test3 test4;
	if section=1 then do;
	test5=test1-10;
	test6=test2-14;
	end;
	else do;
	test5=test1+3;
	test6=test2+5;
	end;
run;

/*1-2번문제*/
data test1;
	set test;
	if section=1 then do;
	array test{6} test1-test6;
	i=1 to 6;
	total=0;
	total=total+test{i};
	end;
run;

/*2-1번문제*/
data preg;
	infile "C:\preg.txt" firstobs=2;
	input name$ preg_num date;
run;
data expo;
	infile "C:\expo.txt" firstobs=2;
	input name$ date exposlvl$;
run;
data bothid;
	merge preg(=rename(date=PREG_DATE))
			expo(=rename(date=EXPO_DATE));
by name;
run;
/*2-2 문제*/

/*3-1 문제*/
proc import datafile="C:\timerec.xlsx" out=timerec dbms=xlsx replace;
getnames=yes;
data timerec;
	set timerec;
	label employee='고용인'
			phase='분석단계'
			hours='시간';
run;

/*3-2 문제*/
data emp1 emp2;
	set timerec;
	if employee='Chen' then output emp1;
	else output emp2;
	drop employee;
run;

/*3-3번 문제*/
proc sort data=Emp1;
by phase;
run;

data emp11;
	set emp1;
	by phase;
	retain hoursum 0;
	hoursum=hoursum+hours;
	drop hours;
	run;

/*4번 문제*/
data grunfeld;
	infile "C:\grunfeld.txt";
	input sort$ invest stock value @@;
run;
proc means data=grunfeld;
	var invest stock value;
	class sort;
run;


/*5번 문제*/
data normal;
	do x=1 to 20;
	nor_pdf=NOR("normal",x,10,2);
	output;
	end;
run;

proc gplot data=normal;
	symbol i=spline v=none;
	plot nor_pdf*x;
run;













