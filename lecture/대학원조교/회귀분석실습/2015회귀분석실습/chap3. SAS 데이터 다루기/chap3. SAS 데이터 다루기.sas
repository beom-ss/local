/*page 3*/
data one;
	input x y;
	z=x+y;
	keep z;
	cards;
1 2
3 4
;
run;

proc print data=one;
run;

data two;
	input id sex$ score;
	if sex='M' then gender=1;
	else gender=2;
	drop sex;
	cards;
1234 M 93
1532 F 84
3294 F 83
4132 M 79
;
run;
proc print data=two;
run;

/*page 5*/
data three;
	input x;
	delete;
	cards;
12
14
19
;
run;
data four1;
	input id sex$ score;
	if sex='F' then delete;
	drop sex;
	cards;
1234 M 93
1532 F 84
3294 F 83
4132 M 79
;
run;
data four2;
	input id sex$ score;
	if sex='M';
	drop sex;
	cards;
1234 M 93
1532 F 84
3294 F 83
4132 M 79
;
run;
data four3;
	input id sex$ score;
	if sex^='M' then delete;
	drop sex;
	cards;
1234 M 93
1532 F 84
3294 F 83
4132 M 79
;
run;
proc print data=four1;
run;
proc print data=four2;
run;
proc print data=four3;
run;


/*page7*/
data five1;
	input x1 x2 x3;
	x=x1; col=1; output;
	x=x2; col=2; output;
	x=x3; col=3; output;
	cards;
7 9 3
4 5 6
;
run;
proc print data=five1;
run;
data five2;
	input x1 x2 x3;
	x=x1; col=1; 
	x=x2; col=2; 
	x=x3; col=3; 
	cards;
7 9 3
4 5 6
;
run;
proc print data=five2;
run;
data male female;
	input id sex$ score;
	if sex='M' then output male;
	else output female;
	drop gender;
	cards;
1234 M 93
1532 F 84
3294 F 83
4132 M 79
;
run;
proc print data=male; run;
proc print data=female; run;



/*page 9*/
data a1;
	input id x1 x2;
	cards;
1 33 44
2 32 34
1 22 44
1 32 67
2 11 34
;
proc sort data=a1;
	by id;
run;

data b1;
	set a1;
		by id;
		if first.id=1;
run;
proc print data=b1;
run;


/*page 10*/
data c1;
	input code1 x y @@;
	cards;
11 1 22	21 4 34
51 2 56	41 3 77
;
proc sort data=c1;
	by code1;
run;
data c2;
	input code1 code2$;
	cards;
11 a1
21 b1
31 c1
61 f1
;
data all;
	merge c1 c2;
	by code1;
run;

proc print data=c1; run;
proc print data=c2; run;
proc print data=all; run;



/*page 12*/
data cusum;
	retain cusum 0;
	input x;
	cusum=cusum+x;
	cards;
1
4
3
;
run;
proc print data=cusum; run;



/*page 18*/
data score;
	infile "D:\score.txt" dlm=',' dsd missover firstobs=2;
	input ID SEX$ X1 X2 X3 TOTAL;
run;

proc print data=score(drop=sex);
run;

data total;
	set score(keep=id total);
run;
proc print data=total;
run;
data total;
	set score;
	keep id total;
run;


/*page 19*/
proc print data=score(where=(sex='M') keep=id total sex);
run;

data high;
	set score(where=(total>=260) keep=id sex);  /*잘못된 결과*/
run;

data high1_1;
	set score;
	if total>=260;
	keep id sex;
run;
data high1_2;
	set score;
	where total>=260;
	keep id sex;
run;
proc print data=high1_1;run;
proc print data=high1_2;run;


/*page 20*/
proc print data=score(rename=(x1=math x2=eng x3=kor));
run;

proc print data=score(firstobs=3 obs=6);
run;

