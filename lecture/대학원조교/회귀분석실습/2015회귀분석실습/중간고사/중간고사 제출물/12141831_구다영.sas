data test;
	infile "C:\Users\a29\Desktop\test.txt" dlm='/' firstobs=2;
	input student section test1 test2 test3 test4;
run;
data num1_1;
	set test;
	if section=1 then do;
		test5 = test1-10;
		test6 = test2-14;
		end;
	else do;
		test5=test1+3;
		test6=test2+5;
		end;
run;
data num1_2;
	set num1_1(where=(section=1));
	array test{6} test1-test6;
		total = 0;
		do i=1 to 6;
			total=total+test{i};
		end;
run;


data preg;
	infile "C:\Users\a29\Desktop\preg.txt"  firstobs=2;
	input name$ preg_num date;
run;
proc sort data=preg;
	by name;
run;
data expo;
	infile "C:\Users\a29\Desktop\expo.txt" firstobs=2;
	input name$ date exposlvl$;
run;
proc sort data=expo;
	by name;
run;
data bothid;
merge preg(rename=(date=PREG_DATE)) expo(rename=(date=EXPO_DATE)) ;
	 by name;
run;
data num2_2;
	set bothid / ;
run;


proc import datafile="C:\Users\a29\Desktop\timerec.xlsx" out=timerec dbms=xlsx replace;
	getnames=yes;
run;
data num3_1;
	set timerec;
	label employee='고용인'
			phase='분석단계'
			hours='시간';
run;
data emp1 emp2;
	set num3_1;
	if employee='Chen' then output emp1;
	else output emp2;
	drop employee;
run;
data emp1 emp2;
	set num3_1;
	if employee='Stewart' then output emp1;
	else output emp2;
	drop employee;
run;
		

data grunfeld;
	infile "C:\Users\a29\Desktop\grunfeld.txt" ;
	input sort$1,24-25  invest 2-7 ,26-31 stock 8-15,32-39  value 16-21,40-45;
run;
proc means data=grunfeld;
	var invest stock value;
	by sort;
run;

data pdf;
	do x= 1 to 20;
	Normal=pdf("normal",x,10,2);
	output;
	end;
run;
proc gplot data=pdf;
	symbol i=spline v=none;
	plot Normal*x;
run;

