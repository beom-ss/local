/* 1번 */
/* 1.(1) */
data test;
	infile "D:\실습\test.txt" dlm='/' missover dsd firstobs=2;
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

/* 1.(2) */
data test_1;
	set test(where=(section=1));
	array test{6} test1-test6;
	total=0;
	do i=1 to 6;
		total=total+test{i};
	end;
	drop i;
run;

/* 2번 */
/* 2.(1) */
data preg;
	infile "D:\실습\preg.txt" firstobs=2;
	input name$ preg_num date;
run;

data expo;
	infile "D:\실습\expo.txt" firstobs=2;
	input name$ date exposlvl$;
run;

proc sort data=preg; by name; run;
proc sort data=expo; by name; run;

data bothid;
	merge preg(rename=(date=PREG_DATE)) expo(rename=(date=EXPO_DATE));
	by name;
run;

/* 2.(2) */
data bothid;
	set bothid;
	if PREG_DATE=. | EXPO_DATE=. then delete;
run;

/* 3번 */
/* 3.(1) */
proc import datafile="D:\실습\timerec.xlsx" out=timerec dbms=xlsx replace;
	getnames=yes;
run;

data timerec;
	set timerec;
	label employee='고용인' phase='분석단계' hours='시간';
run;

/*3.(2)*/
data emp1 emp2;
	set timerec;
	if employee='Stewart' then output emp2;
	else output emp1;
	drop employee;
run;

/* 원래 생각했던 답은 아래와 같습니다.
data emp1 emp2;
	set timerec;
	if employee='Chen' then output emp1;
	else output emp2;
	drop employee;
run;
*/

/*3.(3)*/
proc sort data=emp1; by phase; run;

data emp1;
	set emp1;
	do;
	retain hoursum 0;
	hoursum=hoursum+hours; /* 누적합을 구하고 */
	if last.phase=1 then hoursum=0; /* 각 분석방법의 마지막 부분이면 hoursum 초기화 */
	end;
	drop hours;
	if last.phase=0 then hoursum=.; /* 각 분석방법의 마지막 부분이 아니면 hoursum의 값을 지움 */
	/* 위와 같은 알고리즘으로 하려 했으나 last, first 부분에 대해 정확히 숙지하지 못하여 프로그램이 돌아가지 않았습니다.
	변수가 초기화되지 않았다는 메시지가 뜨면서 프로그램이 구동되지 않았습니다.*/
run;

/* 4번 */

proc means data=grunfeld;
	var invest stock value;
	class sort;
run;

/* 5번 */
data PDF;
	do x=1 to 20;
		PDF=pdf('normal',x,10,sqrt(4));
		output;
	end;
run;

proc gplot data=PDF;
	symbol i=spline v=none;
	plot PDF*x;
run;
