
/* The beginning of Base Programmining*/

/*page 04*/
data one;
	input x;
	cards;
12
15
24
27
;
run;
proc print data=one;
run;

/*page 11*/
data one;
	input x y;
	cards;
12 34
56 78
63 94
;
run;

/*page 12*/
data one;
	input id gender$ weight;
	cards;
1234 M 49.5
1537 F 40.0
1745 M 70.2
1955 F 42.3
;
run;

/*page 14*/
data one;
	input x y z;
	cards;
1 2 3
4 5 6
;
run;
proc print data=one; run;

data two;
	input x y z;
	cards;
1 2 3 4 5 6
7 8 9 8 4 2
;
run;
proc print data=two; run;

data three;
	input x y z;
	cards;
1 2 
3 4 5
6 7 8
;
run;
proc print data=three; run;

data four;
	input x y z;
	cards;
1 2 3 4
5 6
7 8
9 0 1
;
run;
proc print data=four; run;

/*page 15*/
data two;
	input id 1-4 gender$ 5-6 weight 8-12;
	cards;
1234 M 49.5
1537 F 40.0
1745 M 70.2
1955 F 42.3
;
run;

/*page 17*/
data one;
	input x 1-4 y $ 5-8;
	cards;
12  AB
 12  AB
  12  AB
1 2 A B
 1 2 A B
;
run;

/*page 18*/
data two;
	input id 1-4 gender$ 5-6 weight 8-12;
	cards;
1234 M0 49.552A7
1537 F1 40.035B2
1745 M1 70.241A4
1955 F0 42.357A3
;
run;

/*page 19*/
data three;
	input id 4. gender$ 3. weight 4.1;
	cards;
1234 M 49.5
1537 F 40.0
1745 M 70.2
1955 F 42.3
;
run;

/*page 20*/
data three;
	input x 4.2 a$ 4.;
	cards;
1234A
12.3 A
 77 A B
199  A B
 199A  B
;
run;

/*page 21*/
data four;
	input id= gender=$ weight=;
	cards;
id=1234 gender=M weight=49.5
id=1537 gender=F weight=40.0
id=1745 gender=M weight=70.2
id=1955 gender=F weight=42.3
;
run;

/*page 22*/
/*1) list*/
data smoke;
	input id smoke$ gender$ age height;
	cards;
1 Y m 32 185.52
2 N f 65 177.71
3 Y f 24 177.15
4 Y m 19 180.67
;
run;
/*2) column*/
data smoke;
	input id 1 smoke$ 3 gender$ 5 age 7-8 height 10-15;
	cards;
1 Y m 32 185.52
2 N f 65 177.71
3 Y f 24 177.15
4 Y m 19 180.67
;
run;
/*3) formatted*/
data smoke3;
	input id  smoke$ gender$ age height 7.2;
	cards;
1 Y m 32 185.52
2 N f 65 177.71
3 Y f 24 177.15
4 Y m 19 180.67
;
run;
/*4) named*/
data smoke;
	input id= smoke=$ gender=$ age= height=;
	cards;
id=1 smoke=Y gender=m age=32 height=185.52
id=2 smoke=N gender=f age=65 height=177.71
id=3 smoke=Y gender=f age=24 height=177.15
id=4 smoke=Y gender=m age=19 height=180.67
;
run;

/*page 23*/
data one;
	input x y;
	z = x+y;
	cards;
1 2
3 4
;
run;

/*page 25*/
data one;
	input x1 x2 x3 x4;
	mean=(x1+x2+x3+x4)/4;
	var=((x1*x1+x2*x2+x3*x3+x4*x4)-4*mean*mean) / 3;
	sd=sqrt(var);
	min=min(x1,x2,x3,x4);
	max=max(x1,x2,x3,x4);
	range=max-min;
	cards;
1 4 5 6
2 5 3 7
9 4 5 2
;
run;

/*page 26*/
data two;
	max=max(x1,x2,x3,x4);
	mean=(x1+x2+x3+x4)/4;
	input x1 x2 x3 x4;
	cards;
1 4 5 6
2 5 3 7
9 4 5 2
;
run;

/*page 27*/
data ex1;
	input x y;
	if x<y then x=x-1;
	cards;
12 13
14 15
11 8
;
run;

data ex2;
	input x y;
	if x>13 then z=x-1;
	cards;
12 13
14 15
11 8
;
run;

/*page 28*/
data ex3;
	input x y;
	if x<13 then x=x-1;
					  y=y-1;
	cards;
12 13
14 15
11 8
;
run;

data ex4;
	input x y;
	if x<13 then do;
		x=x-1;
		y=y-1;
	end;
	cards;
12 13
14 15
11 8
;
run;

/*page 29*/
data ex5;
	input x y;
	if x<y then z=x-1;
	else z=y-1;
	cards;
12 13
14 15
11 8
;
run;

/*page 31*/
data grade;
	input id score;
	if score >= 90 then grade='A';
	else if score >= 80 then grade='B';
	else if score >= 70 then grade='C';
	else if score >= 60 then grade='D';
	else grade='F';
	cards;
123 89
456 92
375 73
129 55
;
run;

/*page 32*/
data grade2;
	input id score;
	if score >= 90 then grade='A';
	if score >= 80 then grade='B';
	if score >= 70 then grade='C';
	if score >= 60 then grade='D';
	else grade='F';
	cards;
123 89
456 92
375 73
129 55
;
run;

data grade3;
	input id score;
	if score >= 90 then grade='A';
	if score < 90 & score >= 80 then grade='B';
	if score < 80 & score >= 70 then grade='C';
	if score < 70 & score >= 60 then grade='D';
	if score < 60 then grade='F';
	cards;
123 89
456 92
375 73
129 55
;
run;

/*page 34*/
data logic;
	input x y;
	z=x>y;
	cards;
4 1
2 3
5 .
;
run;

/*page 35*/
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
;
run;

/*page 37*/
data ex1;
	input x y;
	z=x+y;
	keep z;
	cards;
1 2
3 4
;
run;

data ex2;
	input id gender$ score;
	if gender='M' then gen=1;
	else gen=2;
	drop gender;
	cards;
1234 M 93
1532 F 84
3294 F 83
4132 M 79
;
run;

/*page 38*/
data ex1;
	input x;
	delete;
	cards;
12
14
19
;
run;

data ex2;
	input id gender$ score;
	if gender='F' then delete;
	drop gender;
	cards;
1234 M 93
1532 F 84
3294 F 83
4132 M 79
;
run;

/*page 39*/
data ex3;
	input x1 x2 x3;
	x=x1; col=1; output;
	x=x2; col=2; output;
	x=x3; col=3; output;
	cards;
7 9 3
4 5 6
;
run;

data ex4;
	input x1 x2 x3;
	x=x1; col=1; 
	x=x2; col=2; 
	x=x3; col=3; 
	cards;
7 9 3
4 5 6
;
run;

/*page40*/
data male female;
	input id gender$ score;
	if gender='M' then output male;
	else output female;
	drop gender;
	cards;
1234 M 93
1532 F 84
3294 F 83
4132 M 79
;
run;

/*page 41*/

data sample;   /*work라이브러리에 데이터생성*/
	infile "C:\Users\Dharma\Desktop\sample.txt"; /*txt파일로부터 데이터 로딩*/
	input x y z;
run;
data temp.sample;   /*temp라이브러리에 데이터생성*/
	infile "C:\Users\Dharma\Desktop\sample.txt"; /*txt파일로부터 데이터 로딩*/
	input x y z;
run;

/*영구적인 데이터셋 저장*/
Libname temp 'D:\' ; /*라이브러리이름 지정*/
data temp.sample;    /*지정된 라이브러리에 데이터생성*/
	input x y z;
	cards;
8 2 1
5 34 14
41 3 12
;
run;
Libname temp 'D:\' ; /*이후 라이브러리를 불러오면, 라이브러리 내 데이터 로딩*/

/*page 43*/
data one;
	input x y;
	cards;
1 2
3 4
;
run;
data two;
	set one;
	p=x+y;
	z=x*y;
run;

data score;
	input id gender$ score;
	cards;
1234 M 93
1532 F 84
3294 F 83
4132 M 79
;
run;
data male;
	set score;
	if gender='M';
run;

/*page 44*/
data one;
	input x y;
	cards;
1 2
3 4
;
run;
data two;
	input x y;
	cards;
5 6
7 8
;
run;
data three;
	set one two;
	z=x+y;
run;

/*page 45*/
data one;
	input x y;
	cards;
1 2
3 4
;
run;
data two;
	input x w;
	cards;
5 6
7 8
;
run;
data three;
	set one two;
	z=x+y;
	p=x+w;
run;

/*page 46*/
data one;
	input x y;
	cards;
1 2
3 4
;
run;
data two;
	input x w;
	cards;
5 6
7 8
;
run;
data three;
	merge one two;
	z=x+y;
	p=x+w;
run;

/*page 47*/
/*예1*/
data one;
	input x y$;
	cards;
1 a
2 b
3 c
;
run;
data two;
	input z w$;
	cards;
4 p
5 q
6 r
;
run;
data three;
	merge one two;
run;

/*예2*/
data one;
	input x y$;
	cards;
1 a
2 b
3 c
;
run;
data two;
	input x w$;
	cards;
4 p
5 q
6 r
;
run;
data three;
	merge one two;
run;

/*예3*/
data one;
	input x y$;
	cards;
1 a
2 b
3 c
;
run;
data two;
	input z w$;
	cards;
4 p
5 q
6 r
7 s
;
run;
data three;
	merge one two;
run;

/*page 48*/
data one;
	input x @@;
	cards;
1 2 3
4 5 6
;
run;
data two;
	input x;
	cards;
1 2 3
4 5 6
;
run;

/*page 49*/
data three;
	input x y;
	cards;
1 2 3 4 5 6
7 8 9 7 2 6
;
run;
data four;
	input x y @@;
	cards;
1 2 3 4 5 6
7 8 9 7 2 6
;
run;

/*page 50*/
data score;
	input id score1 score2 score3;
	label score1='for test on April 1'
		    score2='for test on May 7'
		    score3='for test on June 13';
	cards;
1001 84 85 82
1002 93 86 88
1003 84 72 89
;
run;

/*page 51*/
data exam;
	input subject gender$ exam1 exam2 hwgrade$;
			final = (exam1+exam2) /2;
	label exam1='중간고사 성적'
		    exam2='기말고사 성적'
		    final='최종 성적'
		    hwgrade='숙제 성적';
	cards;
10 M 80 84 A
7 M 85 89 A
4 F 90 86 B
20 M 82 85 B
25 F 94 94 A
14 F 88 84 C
;
run;
proc print data=exam;
run;

/*page 53*/
/*option nodate nonumber;*/ 
proc print data=exam ;
	title 'print in student number order';
	var exam1 exam2 final hwgrade;
run;
/*option date number;*/

proc print data=exam label;
	title 'print in student number order';
	var exam1 exam2 final hwgrade;
run;
/*title;*/

/*page 54*/
proc sort data=exam out=sorted_exam;
	by subject;
run;
proc print data=sorted_exam;
run;

proc sort data=exam;
	by subject;
run;
proc print data=exam;
run;

/*page 55*/
proc means data=exam;
	title 'Descriptive statistics';
	var exam1 exam2 final;
run;

proc means data=exam;
	by subject;
run;

proc means data=exam;
	class subject;
run;

/*page 56*/
data college;
	input id age gender$ gpa score;
	cards;
1 18 M 3.7 650
2 18 F 2.0 490
3 19 F 3.3 580
4 23 M 2.8 530
5 21 M 3.5 640
;
run;

proc sort data=college;
	by gpa;
run;

proc print data=college;
	var age gender gpa;
	title 'Student in GPA order';
run;

/*The end of Base Programmining*/


