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

/*page 13*/
proc contents data=sasuser._ALL_ NODETAILS;
run;

/*page 14*/
data one;
	input x y;
	cards;
12 34
56 78
63 94
;
run;

/*page 17*/
data one;
	input id gender$ weight;
	cards;
1234 M 49.5
1537 F 40.0
1745 M 70.2
1955 F 42.3
;
run;

/*page 18*/
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


/*page 19*/
data two;
	input id 1-4 gender$ 5-6 weight 8-12;
	cards;
1234 M 49.5
1537 F 40.0
1745 M 70.2
1955 F 42.3
;
run;

/*page 20*/
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


/*page 21*/
data three;
	input id 4. gender$ 3. weight 4.1;
	cards;
1234 M 49.5
1537 F 40.0
1745 M 70.2
1955 F 42.3
;
run;

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

/*page 22*/
data four;
	input id= gender=$ weight=;
	cards;
id=1234 gender=M weight=49.5
id=1537 gender=F weight=40.0
id=1745 gender=M weight=70.2
id=1955 gender=F weight=42.3
;
run;



