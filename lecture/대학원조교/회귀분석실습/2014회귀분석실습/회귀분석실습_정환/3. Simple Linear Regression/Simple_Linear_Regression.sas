
/***************************** 이론편 *****************************/
/*예제 : Ancombe's Quartet*/
/* infile 의 옵션에서 expandtabs는 공백이 큰 관측치를 구별해주는 역할을 한다. */
data quartet;
	infile"D:\quartet.txt" expandtabs;
	input y1 x1 y2 x2 y3 x3 y4 x4;
run;

/*상관계수 확인*/
proc corr data=quartet cov; var y1 x1; run;
proc corr data=quartet cov; var y1 x1; run;
proc corr data=quartet cov; var y1 x1; run;
proc corr data=quartet cov; var y1 x1; run;

/*회귀모형 적합*/
proc reg data=quartet ;
	model y1 = x1 ;
	model y2 = x2 ;
	model y3 = x3 ;
	model y4 = x4 ;
quit;

/*산점도*/
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



/*예제 : computer repair*/
data repair;
	infile"D:\repair.txt";
	input minutes units;
run;

/*산점도를 통해 확인*/
proc plot data=repair ;
	plot minutes * units /vpos=30 hpos=60 ;
run;


/*상관계수 확인*/
proc corr data=repair cov;
run;

/*회귀모형 적합*/
proc reg data=repair ;
	model minutes = units ;
quit;

/*추정치 직접 계산*/
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

/*t(2/alpha, n-2)의 값 구하기*/
data tvalue;
	alpha=0.05;
	df=(14-2);
	t=tinv(1-alpha/2,df);   
	put t=;
run; /*결과는 로그 창에서 확인가능. t=2.1788128297*/

/* beta0, beta1에 대한 신뢰구간 계산 */
/*95% C.I. of beta0 : beta0_hat +- t(2/alpha, n-2) * se(beta0_hat) = 4.16165 +- (2.1788128297)*3.35510 */
/*95% C.I. of beta1 : beta1_hat +- t(2/alpha, n-2) * se(beta1_hat) = 15.50877 +- (2.1788128297)*0.50498 */

/*회귀모형 옵션*/
proc reg data=repair;
	model minutes = units/i ;    /* (X'X)^-1 */
quit;
proc reg data=repair;
	model minutes = units/r ;   /*잔차 옵션*/
quit;
proc reg data=repair;
	model minutes = units/influence;   /* 영향력있는 관측치 탐색 */  
quit;
proc reg data=repair;
	model minutes = units/p;   /* 행 관측치 각각에 대한 예측값(y_hat) */  
quit;
proc reg data=repair;
	model minutes = units/clm cli ;   /* 행 관측치 각각에 대한 95% 신뢰구간, 예측구간 */  
quit;
proc reg data=repair;
	model minutes = units/clm cli alpha=0.1;   /* 관측치에 대한 90% 신뢰구간, 예측구간 */  
quit;


/*절편을 포함하지 않는 모형*/
proc reg data=repair;
	model minutes = units / noint ;
quit;

/*통계량, 분포 확인*/
proc univariate data=repair /*freq*/;
	var minutes units ;
	output out=result n=mean_m mean_u;
/*	probplot minutes;*/
run;


/***************************** 실천편 *****************************/
/*연습문제 2.12) newspapers data*/
/* infile 의 옵션에서 dlim은 명시해주는 기호로 관측치를 구별해주는 역할을 한다. */

data news;
	infile"D:\newspapers.txt" dlm="," ;
	length newspaper$ 30 ;
	input newspaper$ daily sunday ;
run;
 

/*(a)*/
proc plot data=news;
	plot sunday * daily;
run;  /*선형관계를 나타내는 것 같다.*/

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
run; /*결과는 로그 창에서 확인가능. t=2.0369333435*/

/* beta0, beta1에 대한 신뢰구간 계산 */
/*95% C.I. of beta0 : beta0_hat +- t(2/alpha, n-2) * se(beta0_hat) = 13.83563 +- (2.0369333435)*35.80401 */
/*95% C.I. of beta1 : beta1_hat +- t(2/alpha, n-2) * se(beta1_hat) = 1.33971 +- (2.0369333435)*0.07075 */

/*(d)*/
/*daily의 p-value  <.0001 이므로 유의수준 0.05 하에서, H0 : beta=0 을 기각한다. 즉, beta=0이라고 말할 수 없다.*/
/*따라서 일요일 판매부수와 주중 판매부수 사이에 유의한 관계가 존재한다. */
/*주중 판매부수가 1 단위 증가할 때, 일요일 판매부수의 평균 변화량이 1 단위 증가한다.*/

/*(e)*/
/*R-square=0.9181로부터, 일요일 판매부수는 주중 판매부수에 의해 약 92%가 설명된다고 말할 수 있다.*/

/*(f), (g)*/
proc reg data=news;
	model sunday =  daily / clm cli ;
quit; 
proc print data=news;
run;
data news2;  /*새로운 관측치(x1)에 대해서만 추가. 표의 단위가 1000으로 되어있음에 유의할 것.*/
	input daily;
	cards;
500
2000
;
run;

data news3;  /*새 관측치를 기존의 데이터 셋에 추가*/
	set news news2;
run;

/* 추가된 데이터 셋에 대해 신뢰구간, 예측구간을 구함으로써, 새로운 관측치에 대한 값을 알 수 있다. */
/* output 문장과 키워드를 통해, 추가 분석에 필요한 정보만 따로 저장할 수 있다. */
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
/*마지막 데이터의 경우, x1(daily)=2000으로 모형을 적합했었던 x1의 범위에서 벗어난 값이었기 때문에, 신뢰구간과 예측구간의 폭이 넓다. 즉, 큰 오차가 발생함*/
/*이렇게 설명변수의 범위 밖에 위치하는 관측치로 인해 모형의 적합도가 떨어지는 문제를, extrapolation(외삽법)의 문제라고 한다.*/


/*그래프로 표현*/
goption reset=all ;                                      /*gplot의 옵션 초기화*/
symbol1 value=dot    color=black   interpol=none  ci=black   line=2 width=1 ;    /*관측치만  표시*/  
symbol2 value=none color=blue interpol=rlclm95    ci=blue   line=2  width=1 ;  /*95%신뢰구간 표시*/
symbol3 value=none color=red interpol=rlcli95    ci=red   line=2  width=1 ;       /*95%예측구간 표시*/
proc gplot data=news  ;                         
	plot  sunday*daily=1 sunday*daily=2 sunday*daily=3 / overlay ; 
run ; quit ;
