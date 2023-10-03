data test;
	infile "D:\test.txt" dlm='/' firstobs=2;
	input student section test1 test2 test3 test4;
	run;
data one;
	set test;
	if section=1 then do test5=test1-10; 
									test6=test2-14; 
								end;
	else do test5=test1+3; 
				test6=test2+5;end;
				run;
data two;
	set one; 
	if section=1 then do;
		array test{6} test1-test6;
		total=0;
		do i = 1 to 6;
			total = total + test{i};
			end;
			end;
			drop i;
	else delete;
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
data bothid;
	merge preg(rename=(date=preg_date)) expo(rename=(date=expo_date));
	by name;
run;
data bothid2;
	set bothid;
	if preg_date>0 & expo_date>0;
run;
proc import datafile="D:\timerec.xlsx" dbms=xlsx out=timerec replace;
	getnames=yes;
run;
data timerec1;
	set timerec;
	label employee="고용인"
			phase="분석단계"
			hours="시간";
run; 
data emp1 emp2;
	set timerec;
	if employee='Chen' then output emp1;
		else output emp2;
	run;
data emp1 emp2;
	set timerec;
	if employee='Stewart' then output emp2;
		else output emp1;
	run;
proc sort data=emp1;
	by phase;
	run;
data sum;
	set emp1;
		if phase='analysis' then do;
										retain hoursum1 0 ;
										hoursum1 = hoursum1+hours; end; output; 
			else if phase='coding' then do;
										retain hoursum2 0;
										hoursum2 = hoursum2+hours;end; output; 
			else do;
					retain hoursum3 0;
					hoursum3 = hoursum3+hours; end; output; 
	run;
data grunfeld;
	infile "D:\grunfeld.txt" firstobs=2;
	input sort$ invest stock value @@;
	run;
proc sort data=grunfeld;
	by sort;
run;
proc means data=grunfeld;
	by sort;
run;
data pdf; 
	do x=1 to 20;
	pdf=pdf('normal',x,10,2);
	output;
	end;
	run;
proc gplot data=pdf;
	symbol i=spline v=none;
	plot pdf*x;
	run;
