
/***************************** �̷��� *****************************/
/*���� : Ancombe's Quartet*/
/* infile �� �ɼǿ��� expandtabs�� ������ ū ����ġ�� �������ִ� ������ �Ѵ�. */
data quartet;
	infile"D:\quartet.txt" expandtabs;
	input y1 x1 y2 x2 y3 x3 y4 x4;
run;

/*������ Ȯ��*/
proc corr data=quartet cov; var y1 x1; run;
proc corr data=quartet cov; var y1 x1; run;
proc corr data=quartet cov; var y1 x1; run;
proc corr data=quartet cov; var y1 x1; run;

/*ȸ�͸��� ����*/
proc reg data=quartet ;
	model y1 = x1 ;
	model y2 = x2 ;
	model y3 = x3 ;
	model y4 = x4 ;
quit;

/*������*/
proc plot data=quartet ;
	plot y1*x1 / vpos=30 hpos=60;
run;
proc plot data=quartet vpercent=50 hpercent=50;
	plot y1*x1 ; 	plot y2*x2 ; 	plot y3*x3 ; 	plot y4*x4 ;
run;

symbol1 color=black interpol=none value=dot;
symbol2 color=black interpol=rl value=none;
proc gplot data=quartet ;
	plot y1*x1=1 y1*x1=2 / overlay ;
	plot y2*x2=1 y1*x1=2 / overlay ;
	plot y3*x3=1 y1*x1=2 / overlay ;
	plot y4*x4=1 y1*x1=2 / overlay ;
run;quit;



/*���� : computer repair*/
data repair;
	infile"D:\repair.txt";
	input minutes units;
run;

/*�������� ���� Ȯ��*/
proc plot data=repair ;
	plot minutes * units /vpos=30 hpos=60 ;
run;


/*������ Ȯ��*/
proc corr data=repair cov;
run;

/*ȸ�͸��� ����*/
proc reg data=repair ;
	model minutes = units ;
quit;

/*����ġ ���� ���*/
proc sql;
	create table temp1 as
	select minutes as y,	 units as x, 
	          avg(y) as ybar, avg(x) as xbar,  
              y-avg(y) as y_ybar, x-avg(x) as x_xbar,
              (y-avg(y))**2 as y_ybar2, 		
              (x-avg(x))**2 as x_xbar2,
              (y-avg(y))*(x-avg(x)) as xy
	from repair;
quit;
proc sql;
	create table temp2 as
	select distinct(ybar), sum(xy) as sxy, sum(x_xbar2) as sxx, 
              ybar-(sum(xy)/sum(x_xbar2) )*xbar as beta0, sum(xy)/sum(x_xbar2) as beta1
	from temp1;
quit;

/*t(2/alpha, n-2)�� �� ���ϱ�*/
data tvalue;
	alpha=0.05;
	df=(14-2);
	t=tinv(1-alpha/2,df);   
	put t=;
run; /*����� �α� â���� Ȯ�ΰ���. t=2.1788128297*/

/* beta0, beta1�� ���� �ŷڱ��� ��� */
/*95% C.I. of beta0 : beta0_hat +- t(2/alpha, n-2) * se(beta0_hat) = 4.16165 +- (2.1788128297)*3.35510 */
/*95% C.I. of beta1 : beta1_hat +- t(2/alpha, n-2) * se(beta1_hat) = 15.50877 +- (2.1788128297)*0.50498 */

/*ȸ�͸��� �ɼ�*/
proc reg data=repair;
	model minutes = units/i ;    /* (X'X)^-1 */
quit;
proc reg data=repair;
	model minutes = units/r ;   /*���� �ɼ�*/
quit;
proc reg data=repair;
	model minutes = units/influence;   /* ������ִ� ����ġ Ž�� */  
quit;
proc reg data=repair;
	model minutes = units/p;   /* �� ����ġ ������ ���� ������(y_hat) */  
quit;
proc reg data=repair;
	model minutes = units/clm cli ;   /* �� ����ġ ������ ���� 95% �ŷڱ���, �������� */  
quit;
proc reg data=repair;
	model minutes = units/clm cli alpha=0.1;   /* ����ġ�� ���� 90% �ŷڱ���, �������� */  
quit;


/*������ �������� �ʴ� ����*/
proc reg data=repair;
	model minutes = units / noint ;
quit;

/*��跮, ���� Ȯ��*/
proc univariate data=repair /*freq*/;
	var minutes units ;
	output out=result n=mean_m mean_u;
/*	probplot minutes;*/
run;


/***************************** ��õ�� *****************************/
/*�������� 2.12) newspapers data*/
/* infile �� �ɼǿ��� dlim�� ������ִ� ��ȣ�� ����ġ�� �������ִ� ������ �Ѵ�. */

data news;
	infile"D:\newspapers.txt" dlm="," ;
	length newspaper$ 30 ;
	input newspaper$ daily sunday ;
run;
 

/*(a)*/
proc plot data=news;
	plot sunday * daily;
run;  /*�������踦 ��Ÿ���� �� ����.*/

/*(b)*/
proc reg data=news;
	model sunday =  daily;
quit;  /* yhat = 13.83563 +1.33971*x1 */


/*(c)*/
data tvalue;
alpha=0.05;
df=34-2;
t=tinv(1-alpha/2,df);
put t= ;
run; /*����� �α� â���� Ȯ�ΰ���. t=2.0369333435*/

/* beta0, beta1�� ���� �ŷڱ��� ��� */
/*95% C.I. of beta0 : beta0_hat +- t(2/alpha, n-2) * se(beta0_hat) = 13.83563 +- (2.0369333435)*35.80401 */
/*95% C.I. of beta1 : beta1_hat +- t(2/alpha, n-2) * se(beta1_hat) = 1.33971 +- (2.0369333435)*0.07075 */

/*(d)*/
/*daily�� p-value  <.0001 �̹Ƿ� ���Ǽ��� 0.05 �Ͽ���, H0 : beta=0 �� �Ⱒ�Ѵ�. ��, beta=0�̶�� ���� �� ����.*/
/*���� �Ͽ��� �Ǹźμ��� ���� �Ǹźμ� ���̿� ������ ���谡 �����Ѵ�. */
/*���� �Ǹźμ��� 1 ���� ������ ��, �Ͽ��� �Ǹźμ��� ��� ��ȭ���� 1 ���� �����Ѵ�.*/

/*(e)*/
/*R-square=0.9181�κ���, �Ͽ��� �Ǹźμ��� ���� �Ǹźμ��� ���� �� 92%�� ����ȴٰ� ���� �� �ִ�.*/

/*(f), (g)*/
proc reg data=news;
	model sunday =  daily / clm cli ;
quit; 
proc print data=news;
run;
data news2;  /*���ο� ����ġ(x1)�� ���ؼ��� �߰�. ǥ�� ������ 1000���� �Ǿ������� ������ ��.*/
	input daily;
	cards;
500
2000
;
run;

data news3;  /*�� ����ġ�� ������ ������ �¿� �߰�*/
	set news news2;
run;

/* �߰��� ������ �¿� ���� �ŷڱ���, ���������� �������ν�, ���ο� ����ġ�� ���� ���� �� �� �ִ�. */
/* output ����� Ű���带 ����, �߰� �м��� �ʿ��� ������ ���� ������ �� �ִ�. */
proc reg data=news3; 
	model sunday=daily / clm cli;
	output out = temp p=yhat U95M=C_upper L95M=C_lower U95=P_upper L95=P_lower;
quit;

/* (h)*/
proc sql;
	create table interval as
	select newspaper, daily, sunday, yhat, (C_upper - C_lower) as C_interval, (P_upper - P_lower) as P_interval
	from temp;
quit;
/*������ �������� ���, x1(daily)=2000���� ������ �����߾��� x1�� �������� ��� ���̾��� ������, �ŷڱ����� ���������� ���� �д�. ��, ū ������ �߻���*/
/*�̷��� �������� ���� �ۿ� ��ġ�ϴ� ����ġ�� ���� ������ ���յ��� �������� ������, extrapolation(�ܻ��)�� ������� �Ѵ�.*/


/*�׷����� ǥ��*/
goption reset=all ;                                      /*gplot�� �ɼ� �ʱ�ȭ*/
symbol1 value=dot    color=black   interpol=none  ci=black   line=2 width=1 ;    /*����ġ��  ǥ��*/  
symbol2 value=none color=blue interpol=rlclm95    ci=blue   line=2  width=1 ;  /*95%�ŷڱ��� ǥ��*/
symbol3 value=none color=red interpol=rlcli95    ci=red   line=2  width=1 ;       /*95%�������� ǥ��*/
proc gplot data=news  ;                         
	plot  sunday*daily=1 sunday*daily=2 sunday*daily=3 / overlay ; 
run ; quit ;
