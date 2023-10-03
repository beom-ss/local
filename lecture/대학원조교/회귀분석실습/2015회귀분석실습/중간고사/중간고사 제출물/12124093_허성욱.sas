data test;
	infile "D:\test.txt" dlm='/' firstobs=2;
	input student section test1 test2 test3 test4;
run;

data q11;
	set test;
	if section=1 then do;
	test5=test1-10;
	test6=test2-14;
	end;
	else do;
	test5=test1-3;
	test6=test2-5;
	end;
run;

data q12;
	set q11(where=(section=1));
	array sum{6} test1-test6;
	total=0;
	do i = 1 to 6;
		total=total+sum{i};
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

data bothi;
	set preg(rename=(date=preg_date)) expo(rename=(date=expo_date));
run;

proc sort data=bothi out =bothid;
	by name;
run;

proc import datafile="D:\timerec.xlsx" out=timerec dbms=xlsx;
	getnames=yes;
run;

data q3;
	set timerec;
	label employee='고용인'
			phase='분석단계'
			hours='시간';
	run;

/*원래 생각했던 코드입니다
data emp1 emp2;
	set q3;
	if employees'Chen' then output emp1;
	else output emp2;
	drop employee;
run;
*/

/*대신에 이렇게 하니까 돌아갑니다.*/
data emp1 emp2;
	set q3;
	if employee='Stewart' then output emp2;
	else output emp1;
	drop employee;
run;

data q33;
	set emp1;
	if phase='Analysis' then do;
	retain hoursum 0;
	hoursum=hoursum+hours;
	last.phase=hoursum;
	end;
	
run;


data grunfeld;
	infile "D:\grunfeld.txt" expandtabs;
	input sort$ invest stock value @@;
run;

proc means data = grunfeld;
	 class sort;
run;

data q5;
do x=1 to 20;
	a = pdf("normal",x,10,2);
end;

run;

proc gplot data=q5;
	plot pdf*x;
	symbol i=spline v=none;
run;
