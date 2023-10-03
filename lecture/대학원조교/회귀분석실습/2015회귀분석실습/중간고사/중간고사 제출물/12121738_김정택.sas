data emp1 emp2;
    set timerec_1;
    if employee = 'Chen' then output emp1;
    else output emp2;
    drop employee;
run;
/* 1번 */
data test;
	infile "C:\Users\a9\Desktop\회귀시험\test.txt" dlm='/' firstobs=2;
	input student section test1 test2 test3 test4;
run;
/*(1)*/
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
/*(2)*/
data test_2;
	set test_1(where=(section=1));
	array arr{6} test1-test6;
	total = 0;
	do i = 1 to 6;
	total = total+arr{i};
	end;
run;

/* 2번 */
data preg;
	infile "C:\Users\a9\Desktop\회귀시험\preg.txt" firstobs=2;
	input name$ preg_num date;
run;

data expo;
	infile "C:\Users\a9\Desktop\회귀시험\expo.txt" firstobs=2;
	input name$ date exposlvl$;
run;

/* (1) */
data bothid;
	merge preg(rename=(date=preg_date)) expo(rename=(date=expo_date));
run;

/* (2) */
data bothid_1;
	set bothid;
	if preg_date and expo_date = ' ' then delete;
	else output bothid_1;
run;


/* 3번 */
proc import datafile = "C:\Users\a9\Desktop\회귀시험\timerec.xlsx" out=timerec dbms=xlsx replace;
	getnames = yes;
run;

/* (1) */
data timerec_1;
	set timerec;
	label employee = '고용인'
			phase = '분석단계'
			hours = '시간';
run;

/* (2)  */
data emp1 emp2;
	set timerec_1;
	if employee = 'Stewart' then output emp2;
	else output emp1;
	drop employee;
run;



/* (3) */
proc sort data=emp1;
	by phase;
run;

data emp1_1;
	set emp1;
	retain hoursum 0;
	hoursum = hoursum+hours;
	by phase;
	drop hours;
run;


	

/* 4번 */
data grunfeld;
	infile "C:\Users\a9\Desktop\회귀시험\grunfeld.txt" ;
	input sort$ invest stock value @@;
run;

proc sort data=grunfeld;
	by sort;
run;

proc means data=grunfeld;
	by sort;
run;

/* 5번 */
data normal;
	do x= 1 to 20;
	normpdf = pdf('normal',x,10,2);
	output;
	end;
run;

proc gplot data = normal;
	symbol i =spline v=none;
	plot normpdf * x;
run;
