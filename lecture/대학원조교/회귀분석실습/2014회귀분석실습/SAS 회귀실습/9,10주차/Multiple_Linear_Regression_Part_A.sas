/********************************** �̷��� **********************************/

/*���� : Supervisor Performance*/

/*1. data input*/
/* infile �� �ɼǿ��� expandtabs�� ������ ū ����ġ�� �������ִ� ������ �Ѵ�. */
/* infile �� �ɼǿ��� firstobs=2�� ���� ù ��° ���� �������� �����ϰ� �ִ� ��쿡 ����Ѵ�. */
data supervisor_A  ;
	infile "C:\Users\kuksunghee\Desktop\supervisor_A.txt" ;
	input y x1 x2 x3 x4 x5 x6 ;
/*	input y x1-x6 ;*/
run;
data supervisor_B ;
	infile "C:\Users\kuksunghee\Desktop\supervisor_B.txt" expandtabs;
	input y x1-x6 ;
run;
data supervisor_C  ;
	infile "C:\Users\kuksunghee\Desktop\supervisor_C.txt" firstobs=2;
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

/* beta_j : x_j�� ������ ������ ��� �������� �������� ��,  x_j�� 1 ���� ������ ���� y�� ����� ��ȭ�� */
/* ANOVA : H0 : beta_1=beta_2=beta_3=beta_4=beta_5=beta_6=0  vs  H1: at least one beta_j not eq 0 */
/* Full model :          y = beta_0 + beta_1*x1 + beta_2*x2 + beta_3*x3 + beta_4*x4 + beta_5*x5+  beta_6*x6 + error */
/* Reduced model : y = beta_0                                                                                                                    + error */
/* Model�� p-value�� 0.0001 ���� �����Ƿ� ���Ǽ���=0.05 �Ͽ��� H0�� �Ⱒ. ���� ��� beta_j=0  ��� ���� �� ����. */
/* Full model�� �����ϴ�. ��� �ϳ��� beta_j�� �����ϴٰ� ���� �� �ִ�. */

/* P-value of Parameter Estimates - x1�� ���� ����� ���� ��� �Ʒ��� ����. */
/* H0 : beta_1=0  vs  H1: beta_j not eq 0 */
/* Full model :          y = beta_0 + beta_1*x1 + beta_2*x2 + beta_3*x3 + beta_4*x4 + beta_5*x5+  beta_6*x6 + error */
/* Reduced model : y = beta_0 +                    beta_2*x2 + beta_3*x3 + beta_4*x4 + beta_5*x5+  beta_6*x6 + error */
/* x1�� p-value�� 0.0009 �̹Ƿ� ���Ǽ���=0.05 �Ͽ��� H0�� �Ⱒ. ���� beta_1=0  ��� ���� �� ����. Full model�� �����ϴ�.*/
/* beta_1�� ������ �����ϰ�, �ٸ� �������� �����Ͽ��� ��, 1���� ������ y�� ����� 0.61319 ��ŭ �����Ѵ�. */


/*4. Confidence intervals of betas*/

/*t ������ ��跮�� ����ϴ� ����� �Ʒ��� 3������ �ִ�.*/
/*put ��ɹ��� ����� �α� â�� ����ִ� �����ν�, �����ͼ��� ���� ���� Ȯ������ �ʾƵ� �Ǵ� ������ �ִ�.*/
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

/* beta_j�� ���� �ŷڱ��� ��� */
/*95% C.I. of beta_j : beta_j_hat +- t(2/alpha, n-k-1) * se(beta_j_hat)
/*j=1 : beta_1_hat +- t(2/alpha, n-k-1) * se(beta_1_hat) = 0.61319 +- (1.7138715277)*0.16098 */

proc reg data=supervisor_A ;
	model y = x1-x6 / i ;  /* (X'X)^-1 */
quit;
/*j=1 : beta_1_hat +- t(2/alpha, n-k-1) * root(MSE)*root(c_11) = 0.61319 +- (1.7138715277)*(7.06799)*(0.0005187622)*/


/*5. Partial regression coefficients(�� ȸ�Ͱ���� ���� �ؼ�)*/
/*�������� 2���� ������ ������ �����Ѵ�.*/
proc reg data=supervisor_A ;
	model y = x1 x2 ;
quit;

/*y = beta_0 + beta_1*(x1) + beta_2*(x2) + error*/
/*y|x1 = alpha_0  + alpha_1*(x2|x1) + error where alpha_1 = beta_2*/
proc reg data=supervisor_A ;
	model y = x1 / r ; 	output out=subset_1 r=y_x1 ;
run;quit;
proc reg data=supervisor_A ;
	model x2 = x1 / r ; output out=subset_2 r=x2_x1;
quit;
proc sql ;
	create table subset_3 as
	select t1.y,  t1.x1,  t1.x2 , t1.y_x1 'y|x1' , t2.x2_x1 'y|x2'
	from subset_1 as t1, subset_2 as t2 
	where (t1.y=t2.y) and (t1.x1=t2.x1) and (t1.x2=t2.x2) ;
quit; run;
data subset_3;
	merge subset_1 subset_2;
run;
proc reg data=subset_3 ;
	model y_x1 = x2_x1 ;
quit;
proc reg data=supervisor_A ;
	model y = x2 / r ; 	output out=subset_4 r=y_x2 ;
run;quit;
proc reg data=supervisor_A ;
	model x1 = x2 / r ; output out=subset_5 r=x1_x2;
quit;
data subset_6;
	merge subset_4 subset_5;
run;
proc reg data=subset_6;
	model y_x2 = x1_x2 ;
quit;

proc reg data=supervisor_A;
	model y=x1 x2/r ; output out=test1 r=y_x1x2;
quit;
proc sql;
create table test as
	select *,avg(y) as meany
	from supervisor_A;
quit;

proc reg data=test;
	model meany=x1 x2/r ; output out=test2 r=m_x1x2;
quit;
data test3;
	merge test1 test2;
run;
proc reg data=test3;
	model y_x1x2=m_x1x2;
run;





/*6. Several options of multiple linear regression*/

proc reg data=supervisor_A ;
	model y = x1-x6 / r ;   /* ���� �ɼ� */
quit;
proc reg data=supervisor_A ;
	model y = x1-x6 / p;   /* �� ����ġ ������ ���� ������(y_hat) */  
quit;
proc reg data=supervisor_A ;
	model y = x1-x6 / clm cli ;   /* �� ����ġ ������ ���� 95% �ŷڱ���, �������� */  
quit;
proc reg data=supervisor_A ;
	model y = x1-x6 / clm cli alpha=0.1;   /* ����ġ�� ���� 90% �ŷڱ���, �������� */  
quit;

/*���ο� ����ġ�� ���� 95% �ŷڱ���, ��������*/
/*���� ���ο� ����ġ�� �����ϴ� ������ ���� �����, ������ �����Ϳ� �����ش�.*/
/*���ο� ����ġ�� y���� �������� �����Ƿ�, ȸ�͸����� �����ϴµ��� ���� ������ �ʴ´�.*/
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
	model y = x1-x6 / noint ;   /* ������� ���� */  
quit;
proc reg data=supervisor_A ;
	model y = x1-x6 / influence; /* ����� �ִ� ����ġ�� Ž���� ���� ��跮�� - �̿� ���ؼ� 4�忡�� �ڼ��� ���. */
quit;
proc reg data=supervisor_A ;
	model y = x1-x6 / vif; /* �������� ������ ���߰�����(multicollinearity) Ž�� */
quit;
/*VIF > 10�� ��, ���߰������� �����Ѵٰ� �Ǵ��Ѵ�. ���⼭�� ��� xj�� VIF_j < 10�̹Ƿ� ���߰������� ������ ���� ������ �Ǵܵȴ�.*/

/* ���߰������� ������ ��ó�ϴ� ���� ������ �����, ������谡 �ִ� ������ �� �Ϻθ� �����ϰų� �����ϴ� ���̴�. */
/* ���߰������� �ִ���, ���ο� ����ġ�� ������ ������ ������ ������ ���� ���� ������, ������ �������� ������ �ʴٰ� �Ѵ�. */
/*�׷��� ���߰������� �����ϸ�, beta�� �л��� �ſ� ū ������ �־�, ������ ���������� ���ϰ� �ǹǷ� �̸� ��������� �� �ʿ䰡 �ִ�. */
/* ���߰������� ���� �� �˷��� �ִ� �ַ�ǵ�(�ּ��� ȸ��, ����ȸ��)�� 9�忡�� �ɵ���� �ٷ��� ���̴�. */


