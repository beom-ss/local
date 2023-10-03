/******************1. 라이브러리 설정******************/

/* 라이브러리 설정하는 방법 libname 라이브러리이름 “ 주소 ”;*/  
libname inha "C:\"; 

/* 라이브러리 설정한 곳에 저장 */
data inha.class;
	set sashelp.class;
run;

/* work(임시저장장소)에 저장 종료 시 삭제 됨 */
 data class;
	set sashelp.class; /* 기본적으로 저장 된  */
 run;


/******************2. DATA STEP에서의 주요 기능******************/

/*2-1 set문*/
/* 저장한 class Dataset을 가져오기 */
data ex;
	set inha.class; /* 라이브러리이름.Dataset이름 */
run;

 /*2-2 계산*/
 /* 저장한 class Dataset을 가져오기 */
data ex;

	set inha.class; /* 라이브러리이름.Dataset이름 */

	H_W_ratio=Height/Weight; /* (키 / 몸무게) */

run;

   
data ex1;
	set inha.one;

	mean = mean(x1, x2, x3, x4);
	var=var(x1, x2, x3, x4);
	sd=std(x1, x2, x3, x4);
	sd1=sqrt(var);
	max=max(x1, x2, x3, x4);
	min=min(x1, x2, x3, x4);

run;


data ex2;
	set inha.two;

	if x < y then z1=x-1;

	if x > 13 then z2=x-1;

run;
 


data ex3;
	set inha.two;

	if x < 13 then z1=x-1;
						 z2=y-1;

run;
	

data ex4;
	set inha.two;

	if x < 13 then do;

	z1=x-1;
    z2=y-1;

	end;

run;
	
data ex5;
	set inha.two;

	if x < y then z=x-1;
	else z=y-1;

run;


/* 조건문 */
data grade;
	set inha.three;

	if score >= 90 then grade="A";
	else if score >= 80 then grade="B";
	else if score >= 70 then grade="C";
	else if score >= 60 then grade="D";
	else grade="F";

run;


data grade2;
	set inha.three;

	if score >= 90 then grade="A";
	if score >= 80 then grade="B";
	if score >= 70 then grade="C";
	if score >= 60 then grade="D";
	else grade="F";

run;


data grade3;
	set inha.three;

	if score >= 90 then grade="A";
	if score < 90 and score >= 80  then grade="B";
	if score < 80 and score >= 70  then grade="C";
	if score < 70 and score >= 60  then grade="D";
	if score < 60 then grade="F";

run;



/* 논리 연산자 */

data logic;
	input x y;
	z=x>y;
	cards;
4 1
2 3
5 .
;run;

data logic2;
	input x y z;
	if x-y then v=1;
	else v=0;
	if z then w=1;
	else w=0;
	cards;
4 2 -2
3 3 1
1 5 .
4 . 0
;run;

/* keep drop */
data ex1;
	input x y;
	z=x+y;
	keep z;
	cards;
1 2
3 4
;run;

data ex2;
	input id gender $ score;
	if gender="M" then gen=1;
	else gen=2;
	drop gender;
	cards;
1234 M 93
1532 F 84
3294 F 83
4132 M 79
;run;

/* delete output */
data ex1;
	input x;
	delete;
	cards;
12
14
19
;run;

data ex2;
	input id gender $ score;
	if gender="F" then delete;
	drop gender;
	cards;
1234 M 93
1532 F 84
3294 F 83
4132 M 79
;run;

data male female;
	input id gender $ score;
	if gender="M" then output male;
	else output female;
	drop gender;
	cards;
1234 M 93
1532 F 84
3294 F 83
4132 M 79
;run;
