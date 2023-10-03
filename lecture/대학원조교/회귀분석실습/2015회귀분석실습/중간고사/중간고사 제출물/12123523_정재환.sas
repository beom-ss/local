data test;
	infile "D:\test.txt"  firstobs=2 dlm='/';
	input student$ section test1 test2 test3 test4;
	if section='1' then do test5=test1+10;
									test6=test2+14;
	end;
	else do test5=test1+3;
				test6=test2+5;
	end;

	array test{6} test1-test6;
	do i=1 to 6;
	total=0;
	if section='1' then  total=total+test{i};
	drop i;
	end;
	run;


data preg(rename=(date=preg_date));
	infile "D:\preg.txt" firstobs=2;
	input name$ preg_num date;

data expo(rename=(date=expo_date));
	infile "D:\expo.txt" firstobs=2;
	input name$ date exposlvl$;
proc sort data=preg;
	by name;
proc sort data=expo;
	by name;
data bothid;
	merge preg expo ;
	by name;


proc import datafile="D:\timerec.xlsx" out=timerec dbms=xlsx replace;
	getnames=yes;
	label employee='고용인'
			phase='분석단계'
			hours='시간';
data emp1 emp2;
	set timerec;
	if employee='Stewart' then output  emp2;
	else output emp1;
	drop employee; 

proc sort data=emp1;
	by phase;
data emp3;
	set emp1;
	retain hoursum 0;
	hoursum=hoursum+hours;
	if phase='Coding' then do;
										retain hoursum 0;
										hoursum=hoursum+hours;
										end;
	else if phase='Testing' then do;
										retain hoursum 0;
										hoursum=hoursum+hours;
										end;





data grunfeld;
	infile "D:\grunfeld.txt";
	input sort$ invest stock value @@;
proc sort data=grunfeld;
	by sort;
proc means data=grunfeld;
	var invest stock value;
	by sort;


data plot;
	do x=1 to 20 ;
	pdf=pdf('normal',x,10,4);
	end;
proc gplot data=plot;
	symbol1 i=spline v=none;
	plot pdf*x;
