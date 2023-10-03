/*page 3*/
data test;
	input id score1 score2 score3;
	label score1='for test on April 1'
			score2='for test on May 7'
			score3='for test on June 13';
	cards;
1001 84 85 82
1002 93 86 88
1003 84 72 89

;
proc print data=test;
run;
proc print data=test label;
run;


/*page 5*/
data one;
	array arr{2} u v;
	input x y z;
	arr{1}=x+3;
	arr{2}=z-y;
	cards;
1 2 3
4 5 6
;
proc print data=one;run;

data two;
	array type{5} $ type1-type5;
	input x1$ x2$ x3$ x4$ x5$;
	type{1}=cats(x1,'001');
	type{2}=cats(x2,'001');
	type{3}=cats(x3,'001');
	type{4}=cats(x4,'001');
	type{5}=cats(x5,'001');
cards;
A B C D E
F G H I J
;
proc print data=two;run;


/*page 9*/
data a1;
	input x @@;
	cards;
1 2 3 4 5 6 7 8 9
;

data b1;
	set a1;
	if x>5 then do;
		y=x*10;
		ly=sqrt(y);
	end;
run;

proc print data=a1; run;
proc print data=b1; run;

data c1;
	a=1;
	do i=1 to 10;
		a=a+i;
		output;
	end;
run;
proc print data=c1; run;


/*page 10*/
data score;
	array x{5} kor eng math pyhsics chem;
	input id kor eng math pyhsics chem;
	total=0;
	do i=1 to 5;
		total=total+x{i};
	end;
	drop i;
	cards;
1001 93 84 74 85 84
1002 85 94 91 87 83
1003 89 93 79 84 81
1004 72 86 91 85 84
1005 97 80 93 88 91
;
proc print data=score;run;


/*page 11*/
data day;
	input id mon tue wed thr fri sat sun;
	cards;
1 443 403 780 140 90 603 984 
2 469 372 815 134 102 577 980 
3 251 381 929 144 99 575 987 
4 286 465 851 140 108 565 1000 
5 342 402 921 139 109 406 1005 
6 585 535 830 136 110 266 1043 
7 510 397 864 121 80 194 1074 
8 535 369 868 132 72 290 1042 
9 511 322 919 132 105 583 1110 
10 993 510 995 135 103 625 1054 
;

data report_1;
	set day;
	mon=5*(mon-32)/10;
	tue=5*(tue-32)/10;
	wed=5*(wed-32)/10;
	thr=5*(thr-32)/10;
	fri=5*(fri-32)/10;
	sat=5*(sat-32)/10;
	sun=5*(sun-32)/10;
run;

data report_2(drop=i);
	set day;
	array wkday{7} mon tue wed thr fri sat sun;
	do i=1 to 7;
		wkday{i}=5*(wkday{i}-32)/10;
	end;
run;

proc print data=report_1; run;
proc print data=report_2; run;

/*page 18*/
data PDF;
	do x=0 to 40;
	gamma=pdf("gamma",x,4,3);
	normal=pdf("normal",x,12,6);
	output;
	end;
run;

proc gplot data=pdf;
	symbol1 i=spline v=none c=blue;
	symbol2 i=spline v=none c=red l=3;
	plot (gamma normal)*x / overlay legend;
run;

/*page 19*/
data PDF2;
	do x=0 to 10;
		POISSON=pdf("poisson",x,2);
		output;
	end;
run;

proc gplot data=pdf2;
	symbol i=needle v=none c=green w=5;
	plot poisson*x;
run;

/*page 20*/
data CDF;
	do x=0 to 10 by 0.5;
		EXP=cdf("EXPONENTIAL",x,2);
		output;
	end;
run;

proc gplot data=CDF;
	symbol i=spline v=none c=blue w=1;
	plot exp*x;
run;

/*page 23*/
data random;
	do i=1 to 10;
		ranbin=ranbin(1234,20,0.25);
		rannorm=20+rannor(1234)*sqrt(5);
		output;
	end;
run;

proc print data=random;run;



