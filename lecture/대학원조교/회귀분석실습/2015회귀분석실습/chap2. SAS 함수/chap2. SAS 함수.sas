/*page 1*/
data one;
	input x y;
	z=x+y;
	cards;
1 2
3 4
;

/*page 5*/
data test1;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap2. SAS 함수\infile_1.txt";
	input x y z;
run;
data test2;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap2. SAS 함수\infile_2.txt" expandtabs ;
	input x y z;
run;
data test3_1;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap2. SAS 함수\infile_3.txt" dlm=',';
	input x y z;
run;
data test3_2;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap2. SAS 함수\infile_3.txt" dlm=',' missover;
	input x y z;
run;
data test3_3;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap2. SAS 함수\infile_3.txt" dlm=',' dsd;
	input x y z;
run;
data test3_4;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap2. SAS 함수\infile_3.txt" dlm=',' missover dsd;
	input x y z;
run;

data test3;
	input x y z;
	cards;
8 2 1
5 . 33
41 3 12
;
run;

/*page 6*/
filename inha "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap2. SAS 함수\infile_3.txt";
data test3_5;
	infile inha dlm=',' dsd;
	input x y z;
run;

/*page 8*/
proc import datafile="D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap2. SAS 함수\import_1.xlsx" out=import1 dbms=xlsx replace;
	getnames=yes;
run;
proc import datafile="D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap2. SAS 함수\import_2.xlsx" out=import2 dbms=xlsx replace;
	getnames=no;
run;
proc import datafile="D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap2. SAS 함수\import_3.csv" out=import3 dbms=csv replace;
	getnames=no;
run;

/*page 10*/
data one;
	set test1;
	a=x+y;
run;
data two;
	set test2;
	b=x+y;
run;

data three;
	set one two;
run;

/*page 12*/
data four;
	merge one two;
run;
data five;
	merge two one;
run;

data six;
	merge three test3;
run;

/*page 15*/
data logic;
	input x y;
	a=x>y;
	cards;
4 1
2 3
5 .
;
run;
proc print data=logic;
run;
data logic1;
	set logic;
	b=a>y;
	AND=a&b;
	OR=a|b;
	NOT=^a;
	drop x y;
run;
proc print data=logic1;
run;

/*page 18*/
data func;
	input x y z;
	cards;
-1.3 1 11
4.3 2 12
-7 3 13
5 4 .
2.7 . 15
-2.7 10 16
0 100 17
;
run;
proc print data=func;
run;

data func1;
	set func;
	EXP=EXP(y);
	SQRT=SQRT(y);
	LN=LOG(y);
	LOG=LOG10(y);

	ABS=ABS(x);
	CEIL=CEIL(x);
	INT=INT(x);
	FLOOR=FLOOR(x);
	SIGN=SIGN(x);
run;
proc print data=func1;
run;

data func2;
	set func;
	N=N(x,y,z);
	MAX=MAX(x,y,z);
	MIN=MIN(x,y,z);
	SUM=SUM(x,y,z);
	MEAN=MEAN(x,y,z);
	RANGE=RANGE(x,y,z);
	STD=STD(x,y,z);
	STDERR=STDERR(x,y,z);
	VAR=VAR(x,y,z);
	CV=CV(x,y,z);
run;
proc print data=func2;
run;

/*page 19*/
data func3;
	set func;
	LAG1=LAG(X);
	LAG3=LAG3(X);
	DIF1=DIF(X);
	DIF=X-LAG(X);
	DIF3=DIF3(X);
	drop y z;
run;
proc print data=func3;
run;

/*page 24*/
data grade;
	input id score;
	cards;
123 89
456 92
375 73
129 55
;
run;

data grade1;
	set grade;
	if score>=90 then grade='A';
	if score>=80 then grade='B';
	if score>=70 then grade='C';
	if score>=60 then grade='D';
	else grade='F';
run;
data grade2;
	set grade;
	if score>=90 then grade='A';
	if score<90 and score>=80 then grade='B';
	if score<80 and score>=70 then grade='C';
	if score<70 & score>=60 then grade='D';
	if score<60 then grade='F';
run;
data grade3;
	set grade;
	if score>=90 then grade='A';
	else if score>=80 then grade='B';
	else if score>=70 then grade='C';
	else if score>=60 then grade='D';
	else grade='F';
run;
proc print data=grade1;
run;
proc print data=grade2;
run;
proc print data=grade3;
run;




