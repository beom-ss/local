/* 1�� */
/* 1.(1) */
data test;
	infile "D:\�ǽ�\test.txt" dlm='/' missover dsd firstobs=2;
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

/* 2�� */
/* 2.(1) */
data preg;
	infile "D:\�ǽ�\preg.txt" firstobs=2;
	input name$ preg_num date;
run;

data expo;
	infile "D:\�ǽ�\expo.txt" firstobs=2;
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

/* 3�� */
/* 3.(1) */
proc import datafile="D:\�ǽ�\timerec.xlsx" out=timerec dbms=xlsx replace;
	getnames=yes;
run;

data timerec;
	set timerec;
	label employee='�����' phase='�м��ܰ�' hours='�ð�';
run;

/*3.(2)*/
data emp1 emp2;
	set timerec;
	if employee='Stewart' then output emp2;
	else output emp1;
	drop employee;
run;

/* ���� �����ߴ� ���� �Ʒ��� �����ϴ�.
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
	hoursum=hoursum+hours; /* �������� ���ϰ� */
	if last.phase=1 then hoursum=0; /* �� �м������ ������ �κ��̸� hoursum �ʱ�ȭ */
	end;
	drop hours;
	if last.phase=0 then hoursum=.; /* �� �м������ ������ �κ��� �ƴϸ� hoursum�� ���� ���� */
	/* ���� ���� �˰������� �Ϸ� ������ last, first �κп� ���� ��Ȯ�� �������� ���Ͽ� ���α׷��� ���ư��� �ʾҽ��ϴ�.
	������ �ʱ�ȭ���� �ʾҴٴ� �޽����� �߸鼭 ���α׷��� �������� �ʾҽ��ϴ�.*/
run;

/* 4�� */

proc means data=grunfeld;
	var invest stock value;
	class sort;
run;

/* 5�� */
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
