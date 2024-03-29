/*page 4*/
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

/*page 7*/
data one;
	input x y;
	cards;
12 34
56 78
63 94
;
run;

/*page 8*/
proc print data = sashelp.class;
run;
/*page 9*/
proc contents data = sashelp.class;
run;

/*page 12) list input*/
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
proc print data=one;
run;

data two;
	input x y z;
	cards;
1 2 3 4 5 6
7 8 9 8 4 2
;
run;
proc print data=two;
run;

data three;
	input x y z;
	cards;
1 2 
3 4 5
6 7 8
;
run;
proc print data=three;
run;

data four;
	input x y z;
	cards;
1 2 3 4
5 6
7 8
9 0 1
;
run;
proc print data=four;
run;

/*����*/
data five;
	input x y z;
	cards;
3 2 4 6 8
7 
9 8 4 7 2
2 3 8
;
run;
proc print data=five;
run;

/*page 15) column input*/
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

/*page 19) formatted input*/
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

/*page 21) named input*/
data four;
	input id= gender=$ weight=;
	cards;
id=1234 gender=M weight=49.5
id=1537 gender=F weight=40.0
id=1745 gender=M weight=70.2
id=1955 gender=F weight=42.3
;
run;

/*page 22) ����*/
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
