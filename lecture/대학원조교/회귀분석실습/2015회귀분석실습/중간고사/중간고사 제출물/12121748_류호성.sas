/*1번*/
data test;
	infile "D:\test.txt" dlm='/' firstobs=2;
	input student section test1 test2 test3 test4;
run;

/*1번(1번)*/
data test1;
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

/*1번(2번)*/
data test2;
	set test1(where=(section=1));
	array a{6} test1-test6;
	total=0;
	do i=1 to 6;
		total=total+a{i};
	end;
	drop i;
run;

/*2번*/

data preg;
	infile "D:\preg.txt" expandtabs firstobs=2;
	input name$ preg_num date;
run;

data expo;
	infile "D:\expo.txt" expandtabs firstobs=2;
	input name$ date exposlvl$;
run;

/*2번(1)*/

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

/*2번(2)*/

data bothid1;
	set bothid;
	if preg_date & expo_date;
run;





/*3번*/

proc import datafile="D:\timerec.xlsx" out=timerec dbms=xlsx replace;
getnames=yes;
run;
 
/*3 (1)*/

data timerec1;
	set timerec;
	label employee=" 고용인"
			phase="분석단계"
			hours="시간";
run;

/*3 (2)*/

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


/*3 (3)*/

data Ana;
	set emp1(where=(phase='Analysis'));
	retain hoursum 0;
	 hoursum=hoursum+hours;
	output;
	drop hours;
run;
data Cod;
	set emp1(where=(phase='Coding'));
	retain hoursum 0;
	 hoursum=hoursum+hours;
	output;
	drop hours;
run;
	
data Tes;
	set emp1(where=(phase='Testing'));
	retain hoursum 0;
	 hoursum=hoursum+hours;
	output;
	drop hours;
run;

data hours;
	set Ana Cod Tes;
run;



/*4번 */

data grunfeld;
	infile "D:\grunfeld.txt" expandtabs;
	input sort$ invest stock value @@;
run;

proc means data=grunfeld;
	var invest stock value;
	class sort;
run;

/*5번*/

data normal;
	do x=1 to 20;
		pdf=pdf("normal",x,10,2);
		output;
	end;
run;

proc gplot data=normal;
	symbol i=spline v=none;
	plot pdf * x;
run;



















































