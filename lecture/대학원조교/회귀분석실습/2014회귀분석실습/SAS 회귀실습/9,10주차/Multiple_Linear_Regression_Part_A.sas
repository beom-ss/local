/********************************** 이론편 **********************************/

/*예제 : Supervisor Performance*/

/*1. data input*/
/* infile 의 옵션에서 expandtabs는 공백이 큰 관측치를 구별해주는 역할을 한다. */
/* infile 의 옵션에서 firstobs=2는 파일 첫 번째 줄이 변수명을 포함하고 있는 경우에 사용한다. */
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
/*vpercent와 hpercent는 여러 plot을 한 화면에 그릴 때, 화면분할 비율을 정해주는 것이다.*/
/*vpercent=50 hpercent=50은 하나의 plot 크기가 화면 가로의 50%, 세로의 50%라는 것이다. 따라서 화면에 4개의 plot이 그려진다.*/
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

/* beta_j : x_j를 제외한 나머지 모든 변수들을 고정했을 때,  x_j가 1 단위 증가할 때의 y의 기댓값의 변화량 */
/* ANOVA : H0 : beta_1=beta_2=beta_3=beta_4=beta_5=beta_6=0  vs  H1: at least one beta_j not eq 0 */
/* Full model :          y = beta_0 + beta_1*x1 + beta_2*x2 + beta_3*x3 + beta_4*x4 + beta_5*x5+  beta_6*x6 + error */
/* Reduced model : y = beta_0                                                                                                                    + error */
/* Model의 p-value가 0.0001 보다 작으므로 유의수준=0.05 하에서 H0를 기각. 따라서 모든 beta_j=0  라고 말할 수 없다. */
/* Full model이 적절하다. 적어도 하나의 beta_j가 유의하다고 말할 수 있다. */

/* P-value of Parameter Estimates - x1에 대한 결과를 예를 들면 아래와 같다. */
/* H0 : beta_1=0  vs  H1: beta_j not eq 0 */
/* Full model :          y = beta_0 + beta_1*x1 + beta_2*x2 + beta_3*x3 + beta_4*x4 + beta_5*x5+  beta_6*x6 + error */
/* Reduced model : y = beta_0 +                    beta_2*x2 + beta_3*x3 + beta_4*x4 + beta_5*x5+  beta_6*x6 + error */
/* x1의 p-value가 0.0009 이므로 유의수준=0.05 하에서 H0를 기각. 따라서 beta_1=0  라고 말할 수 없다. Full model이 적절하다.*/
/* beta_1는 모형에 유의하고, 다른 설명변수를 고정하였을 때, 1단위 증가시 y의 기댓값이 0.61319 만큼 증가한다. */


/*4. Confidence intervals of betas*/

/*t 분포의 통계량을 계산하는 방법은 아래의 3가지가 있다.*/
/*put 명령문은 결과를 로그 창에 띄어주는 것으로써, 데이터셋을 직접 열어 확인하지 않아도 되는 장점이 있다.*/
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

/* beta_j에 대한 신뢰구간 계산 */
/*95% C.I. of beta_j : beta_j_hat +- t(2/alpha, n-k-1) * se(beta_j_hat)
/*j=1 : beta_1_hat +- t(2/alpha, n-k-1) * se(beta_1_hat) = 0.61319 +- (1.7138715277)*0.16098 */

proc reg data=supervisor_A ;
	model y = x1-x6 / i ;  /* (X'X)^-1 */
quit;
/*j=1 : beta_1_hat +- t(2/alpha, n-k-1) * root(MSE)*root(c_11) = 0.61319 +- (1.7138715277)*(7.06799)*(0.0005187622)*/


/*5. Partial regression coefficients(편 회귀계수에 대한 해석)*/
/*설명변수가 2개인 모형을 가지고 설명한다.*/
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
	model y = x1-x6 / r ;   /* 잔차 옵션 */
quit;
proc reg data=supervisor_A ;
	model y = x1-x6 / p;   /* 행 관측치 각각에 대한 예측값(y_hat) */  
quit;
proc reg data=supervisor_A ;
	model y = x1-x6 / clm cli ;   /* 행 관측치 각각에 대한 95% 신뢰구간, 예측구간 */  
quit;
proc reg data=supervisor_A ;
	model y = x1-x6 / clm cli alpha=0.1;   /* 관측치에 대한 90% 신뢰구간, 예측구간 */  
quit;

/*새로운 관측치에 대한 95% 신뢰구간, 예측구간*/
/*먼저 새로운 관측치를 포함하는 데이터 셋을 만들고, 기존의 데이터에 합해준다.*/
/*새로운 관측치는 y값을 포함하지 않으므로, 회귀모형을 적합하는데는 전혀 사용되지 않는다.*/
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

/*참고 : 신뢰구간과 예측구간의 폭 계산*/
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
	model y = x1-x6 / noint ;   /* 절편없는 모형 */  
quit;
proc reg data=supervisor_A ;
	model y = x1-x6 / influence; /* 영향력 있는 관측치의 탐지를 위한 통계량들 - 이에 대해선 4장에서 자세히 배움. */
quit;
proc reg data=supervisor_A ;
	model y = x1-x6 / vif; /* 설명변수들 사이의 다중공선성(multicollinearity) 탐지 */
quit;
/*VIF > 10일 때, 다중공선성이 존재한다고 판단한다. 여기서는 모든 xj의 VIF_j < 10이므로 다중공선성의 문제는 없는 것으로 판단된다.*/

/* 다중공선성의 문제에 대처하는 가장 간단한 방법은, 상관관계가 있는 변수들 중 일부를 제거하거나 결합하는 것이다. */
/* 다중공선성이 있더라도, 새로운 관측치가 기존에 모형을 적합한 데이터 범위 내에 있으면, 모형의 예측력이 나쁘지 않다고 한다. */
/*그러나 다중공선성이 존재하면, beta의 분산이 매우 큰 경향이 있어, 모형이 안정적이지 못하게 되므로 이를 시정해줘야 할 필요가 있다. */
/* 다중공선성에 대한 잘 알려져 있는 솔루션들(주성분 회귀, 능형회귀)이 9장에서 심도깊게 다뤄질 것이다. */


