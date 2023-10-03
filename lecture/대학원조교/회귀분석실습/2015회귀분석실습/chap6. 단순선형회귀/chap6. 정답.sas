
data news;
	infile "D:\회귀분석실습\newspapers.txt" dlm=',';
	input newspaper $ daily sunday;
run;
symbol i=rl;
/*1*/
proc gplot data=news;
	plot daily*sunday;
run;

/*2*/
proc reg data=news;
	model sunday=daily;
run;
quit;
/*3*/
data beta;
	input beta0_mu beta0_se beta1_mu beta1_se;
	beta0_u=beta0_mu+2.037*beta0_se;
	beta0_l=beta0_mu-2.037*beta0_se;
	beta1_u=beta1_mu+2.037*beta1_se;
	beta1_l=beta1_mu-2.037*beta1_se;
	cards;
25.83213 25.25694 0.68527 0.03619 
;
/*4*/
*anova table -> F-test 유의
/*5*/
R-square ;

/*6*/
data plus;
	input daily;
	cards;
500
;
run;
data news2;
	set news plus;
run;
proc reg data=news2;
	model sunday=daily/clm cli;
run;

/*비교*/
proc reg data=news;
	model sunday=daily/clm cli;
run;
