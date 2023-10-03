/*page 2*/
data one;
	input x y;
	z = x+y;
	cards;
1 2
3 4
;
run;

/*page 4*/
data one;
	input x1 x2 x3 x4;
	mean=(x1+x2+x3+x4)/4;
/*	mean2=mean(x1,x2,x3,x4);*/
	var=((x1*x1+x2*x2+x3*x3+x4*x4)-4*mean*mean) / 3;
/*	var2=((x1**2+x2**2+x3**2+x4**2)-4*mean*mean) / 3;*/
/*	var3=var(x1,x2,x3,x4);*/
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
proc print data=one;
run;

/*page 5*/
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

/*page 6*/
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

/*page 7*/
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

/*page 8*/
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

/*page 10*/
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

/*page 11*/
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

/*page 12_¿¹Á¦*/
data ex;
	input name$ gender$ age weight height;
	length age2$ 8;
	if age>=10 & age<=19 then age2 = 'teens';
	else age2 = 'twenties';
	cards;
Alfred M 24 69.0 172.5
Becka F 18 55.3 168.0
Gail F 14 34.3 149.0
Jeffrey M 25 72.5 184.0
John M 20 59.0 165.5
;
run;


/*page 14*/
data logic;
	input x y;
	z=x>y;
	cards;
4 1
2 3
5 .
;
run;

/*page 15*/
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

/*page */
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

/*page */
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

/*page */
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

/*page */
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
