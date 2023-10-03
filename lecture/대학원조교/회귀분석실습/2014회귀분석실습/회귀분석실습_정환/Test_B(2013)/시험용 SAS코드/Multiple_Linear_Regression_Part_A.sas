
/*���� : Supervisor Performance*/

/*1. data input*/
/* infile �� �ɼǿ��� expandtabs�� ������ ū ����ġ�� �������ִ� ������ �Ѵ�. */
/* infile �� �ɼǿ��� firstobs=2�� ���� ù ��° ���� �������� �����ϰ� �ִ� ��쿡 ����Ѵ�. */
data supervisor_A  ;
	infile "D:\supervisor_A.txt" ;
	input y x1 x2 x3 x4 x5 x6 ;
/*	input y x1-x6 ;*/
run;
data supervisor_B ;
	infile "D:\supervisor_B.txt" expandtabs;
	input y x1-x6 ;
run;
data supervisor_C  ;
	infile "D:\supervisor_C.txt" firstobs=2;
	input y x1-x6 ;
run;


/*2. plot & correlation*/
/*vpercent�� hpercent�� ���� plot�� �� ȭ�鿡 �׸� ��, ȭ����� ������ �����ִ� ���̴�.*/
/*vpercent=50 hpercent=50�� �ϳ��� plot ũ�Ⱑ ȭ�� ������ 50%, ������ 50%��� ���̴�. ���� ȭ�鿡 4���� plot�� �׷�����.*/
proc plot data=supervisor_A vpercent=33 hpercent=50 ; 
	plot y*x1 ; 	plot y*x2 ; 	plot y*x3 ; 	plot y*x4 ;		plot y*x5 ; 	plot y*x6 ;
run;
proc corr data=supervisor_A cov ; 
	var y x1 x2 x3 x4 x5 x6 ;
run;


/*3. Model fitting*/
proc reg data=supervisor_A ;
	model y = x1 x2 x3 x4 x5 x6 ;  /*No option*/
quit;


/*4. Confidence intervals of betas*/

data tvalue_A ;
alpha=0.05 ; df=30-6-1 ;
t=tinv(1-alpha/2,df) ;
run ; 
data tvalue_B ;
t=tinv(0.95 , 23) ;
run ; 
data tvalue_C ;
t=tinv(0.95 , 23) ;
put t=  ;
run ; 

proc reg data=supervisor_A ;
	model y = x1-x6 / i ;  
quit;

proc reg data=supervisor_A ;
	model y = x1 / r ; 	output out=subset_1 r=y_x1 ;
run;quit;
proc reg data=supervisor_A ;
	model x2 = x1 / r ; output out=subset_2 r=x2_x1;
quit;
proc sql ;
	create table subset_3 as
	select t1.y,  t1.x1,  t1.x2 , t1.y_x1 'y|x1' , t2.x2_x1 'x2|x1'
	from subset_1 as t1, subset_2 as t2 
	where (t1.y=t2.y) and (t1.x1=t2.x1) and (t1.x2=t2.x2) ;
quit; run;
data subset_3_B;
	merge subset_1 subset_2;
run;
proc reg data=subset_3 ;
	model y_x1 = x2_x1 ;
quit;


/*6. Several options of multiple linear regression*/

proc reg data=supervisor_A ;
	model y = x1-x6 / r ;   
quit;
proc reg data=supervisor_A ;
	model y = x1-x6 / p;  
quit;
proc reg data=supervisor_A ;
	model y = x1-x6 / clm cli ;  
quit;
proc reg data=supervisor_A ;
	model y = x1-x6 / clm cli alpha=0.1;   
quit;

data new;
	input x1-x6;
	cards;
67 53 56 65 75 43
;
run;
data supervisor_A_update ;
	set new supervisor_A ;
run;
proc reg data=supervisor_A_update ;
	model y = x1-x6 / cli clm;
run;

/*���� : �ŷڱ����� ���������� �� ���*/
proc reg data=supervisor_A_update; 
	model y=x1-x6/cli clm;
	output out = temp p=yhat U95M=C_upper L95M=C_lower U95=P_upper L95=P_lower;
quit;
proc sql;
	create table interval as
	select x1, x2, x3, x4, x5, x6, y, yhat, (C_upper - C_lower) as C_interval, (P_upper - P_lower) as P_interval
	from temp;
quit;

proc reg data=supervisor_A ;
	model y = x1-x6 / noint ;   
quit;
proc reg data=supervisor_A ;
	model y = x1-x6 / influence; 
quit;
proc reg data=supervisor_A ;
	model y = x1-x6 / vif; 
quit;


/**********************************************/
