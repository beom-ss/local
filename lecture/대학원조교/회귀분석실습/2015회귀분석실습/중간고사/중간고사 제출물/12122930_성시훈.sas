1-1;
data test;	
	infile "d:\test.txt" dlm='/' firstobs=2;
	input student section test1 test2 test3 test4;
run;

data test5;
	set test;
	array test{2} test1-test2;
			test5={1}; test6={2}; 
	 if section=1 then do; test1=test1-10; text2=text2-20; end;
	 if section=2 then do; test1=test1+3; text2=text2+5; end;
run;

1-2;
data two;
	set test(=where(section=1));
	array test{6} test1-test6;
			total=0;
	do i=1 to 6;
		 	total=total+text{i};
	output;
	end;
run;

2-1;
data preg;
	infile "d:\preg.txt" firstobs=2;  
	input name$ preg_num date;
run;

data expo;
	infile "d:\expo.txt" firstobs=2;
	input name$ date exposlvl$;
run;

proc sort data=preg; by name; run;
proc sort data=expo; by name; run;

data bothid;
	merge preg(rename=(date=preg_date))		
				expo(rename=(date=expo_date));
	by name; 
run;
 

3-1;
proc import datafile="d:\timerec.xlsx" out=timerec dbms=xlsx replace; getnames=yes; run;

data timerec1;
	set timerec;
		label employee="고용인"
				phase="분석단계"
				hours="시간"	;
run;	

3-2;
data emp1 emp2;
	set timerec;
	if employee="Chen" then output emp1;
	else output emp2;
	drop employee;
run;

data emp2 emp1;
	set timerec;
	if employee="Stewart" then output emp2;
	else output emp1;
	drop employee;
run;

3-3;
data retain;
	set emp1;
	retain total=0;
		total=total+hours; 
	output;
	by phase;
	drop hour;
run;

4;
data grunfeld;
	infile "d:\grunfeld.txt";
	 input sort$ invest stock value;
run;

proc means data=grunfeld;
	var invest stock value;
	by sort;
run;

5;
data normal_pdf;
	do x=1 to 20;
	normal_pdf=pdf("normal",x,10,2);
	output; end;
run;

proc gplot data=normal_pdf;
	symbol i=spline v=none;
	plot normal_pdf*x;
run;



	


	
