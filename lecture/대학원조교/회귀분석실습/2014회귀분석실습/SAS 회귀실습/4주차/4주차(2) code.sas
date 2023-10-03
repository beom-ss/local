
/*page 9*/
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


/*page 10*/
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


/*page 11*/
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

/*page 12*/
data exam;
	input subject gender$ exam1 exam2 hwgrade$;
	final = (exam1+exam2) /2;
	label exam1='吝埃绊荤 己利'
		  exam2='扁富绊荤 己利'
		  final='弥辆 己利'
		  hwgrade='槛力 己利';
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

/*page 14*/
/*option nodate nonumber;*/
proc print data=exam ;
/*	title 'print in student number order';*/
	var exam1 exam2 final hwgrade;
run;

/*option nodate nonumber;*/
/*option date number;*/
/*title;*/

proc print data=exam label;
	title 'print in student number order';
	var exam1 exam2 final hwgrade;
run;


/*page 15*/
proc sort data=exam;
	by subject;
run;
proc print data=exam;
run;

data exam2;
	set exam;
run;
proc sort data=exam2;
	by subject;
run;

proc sort data=exam out=exam3;
	by subject;
run;

/*page 16*/
proc means data=exam;
run;

proc means data=exam2;
	by subject;
run;

proc means data=exam;
	title 'Descriptive statistics';
	var exam1 exam2 final;
run;

proc means data=exam2;
	by subject;
run;
proc means data=exam;
	class subject;
run;


/*page 17*/
libname temp 'D:\' ;
data temp.college;
	input id age gender$ gpa score;
	cards;
1 18 M 3.7 650
2 18 F 2.0 490
3 19 F 3.3 580
4 23 M 2.8 530
5 21 M 3.5 640
;
run;

data temp.college2;
	set college;
run;

proc sort data=temp.college2 ;
	by  gpa ;
run;

proc sort data=temp.college out=temp.college3 ;
	by  gpa ;
run;

proc sort data=temp.college out=temp.college4;
	by descending gpa;
run;

proc print data=college;
	var age gender gpa;
	title 'Student in GPA order';
run;

/*page 18*/
data temp.work;
	input id TimeMin TimeSec Gender$;
	cards;
2458 12 38 M
2462 10 5 F
2501 11 13 M
2523 9 42 M
2544 11 46 F
;
run;

proc means data=temp.work;
	var TimeMin TimeSec;
run;

data temp.work2;
	set temp.work;
	TotalTime = TimeMin*60 + TimeSec;
run;
proc print data=temp.work2;
	var id TotalTime;
	title 'Listing of Work TotalTime';
run;


/*End*/
