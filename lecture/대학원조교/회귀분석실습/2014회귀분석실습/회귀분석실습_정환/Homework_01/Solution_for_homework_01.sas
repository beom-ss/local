
/**********************************************************************************************************************/

/* exercise 2-10 */
data height ;
	infile "D:\height_of_husband_and_wife.txt"	expandtabs firstobs=2 ;
	input Husband	Wife ;
run ;

/*(a),(b),(c),(d)*/
proc corr data=height cov ;
run ;
proc sql;
	create table height_meter as
	select Husband/100 as Husband_m,  Wife/100 as Wife_m 
	from height ;
run;
proc corr data=height_meter cov ;
run ;

/*(e)*/
proc sql;
	create table height_another as
	select Husband, Husband-5 as Husband_a
	from height;
run;
proc corr data=height_another cov ;
run ;

/*(f)*/
proc reg data=height ;
	model Wife = Husband ;
	model Husband = Wife ;
quit ;

/*  보다 나은 모형의 선택 기준으로, MSE나 (adj)R-square를 보는 경우가 있지만, 이는 반응변수가 같은 경우에 해당한다.            */
/*  즉, SST가 같은 조건 하에서 MSE나 (adj)R-square 값을 기준으로 보다 더 나은 모형을 선택할 수는 있다.                                */
/*  이 문제의 경우 반응변수가 달라지기 때문에 이러한 기준은 타당하지 않을 것이다. 또한  (adj)R-square값은 같다.                    */

/* 따라서 이 문제의 경우에는 beta의 standard error(표준오차)가 보다 더 작게 나온 모형을 기준을 생각할 수는 있다.       .           */

/*Model 1 : Wife = 41.93015 + 0.69965  * Husband + error */
/*Model 2 : Husband = 37.81005 + 0.83292 *  Wife + error*/

/*따라서 표준오차와 상식적인 면에서 보면, 반응변수를 wife로, 설명변수를 Husband로 두는 것이 좀 더 나을 것 같다.                     */


/*plot*/
proc plot data=height vpercent=50 hpercent=50 ;        /*  v = vertical axis(세로축)을 의미, h = horizontal axis(가로축)을 의미  */
	plot Wife*Husband ;  plot Husband*Wife ;                  /*  vpercent, hpercent는 하나의 그림의 전체화면에서의 비율을 설정      */
run;

symbol1	color=red		interpol=none	value=dot    ;      /*  symbol 1은 관측치 사이를 통과하지 않고 점으로 표시                         */
symbol2	color=blue 	interpol=rl			value=none ;      /*  symbol 2는 관측치 사이를 회귀 적합선으로 통과.                               */
proc gplot data=height ;
	plot Wife*Husband =1 Wife*Husband =2 / overlay ;   /*  y1 vs x1 : 선형 관계(linear)                               */
	plot Husband*Wife=1 Husband*Wife=2 / overlay ;   /*  y2 vs x2 : 비 선형 관계(non-linear)                   */
run;quit;


/*(g),(h) : 기울기 검정 */
proc reg data=height ;
	model Wife = Husband ;
quit ;


/*(j),(k)*/
proc reg data=height ;
	model Wife = Husband ;
	model Husband = Wife ;
	model Wife = Husband / noint ;
	model Husband = Wife / noint ;
quit ;
/*Model 1 :         Wife = 41.93015 + 0.69965*Husband + error */
/*Model 2 : Husband = 37.81005 + 0.83292*Wife + error*/
/*Model 3 :         Wife =                  0.93941*Husband + error*/
/*Model 4 : Husband =                  1.06291*Wife + error*/

/* 보통 키 큰 남성과 작은 여성의 조합이 커플의 대부분이므로, 모형 1과 모형 3은 논리에 맞는 것 같다.*/
/* 실제  데이터에서, 남성에 비해 여성이 키가 큰 경우는 2가지 밖에 없다. (39번, 78번 관측치)*/
/*그러나 모형 1이 맞다고 봤을 때, 단순히 변수의 위치만 바꾼 모형 2는 이질적인 결과가 나오므로, 모형1도 의심스럽다. */
/*모형 2의 beta_1 >1 이어야 이것이 모형 1의 논리와 맞아 떨어진다. 그러나 beta1 < 1 의 결과가 나온다 */

/*이는 절편값에 비해 기울기 값이 지나치게 작기 때문에 이런 결과가 나오는 것이 아닐까 판단된다.*/
/*주의할 점은, 모형 3, 4의 절편없는 모형의 R-square값이 SAS에서는 신뢰할 수 없는 값으로 알려져있다. (미니탭에서는 아예 출력 X )*/

/*어쨌거나 이 문제의 경우에는 절편이 빼는 것이 더 나은 모델링이 아닐까 판단된다.*/
/*절편항이 유의하게 나왔지만, 절편은 모형의 보정을 위해 존재하는 것임을 생각한다면, 이 경우에는 과감히 빼는 것이 더 바람직할 것 같다.*/


/**********************************************************************************************************************/


/* exercise 3-14 */
data cigarette ;
	infile "D:\cigarette_consumption.txt"  expandtabs firstobs=2 ;
	input State $ Age HS Income Black Female Price Sales ;
run ;

/*(a)*/
proc reg data=cigarette ;
	model Sales = Age HS Income Black Female Price ;
	test Female = 0 ;
quit ;

data pvalue1 ;
  df=51-6-1 ; 
  p =  2*(1-probt(1.40, df) ;
  put p = ;
run ; 

data pvalue2 ;
  alpha = 0.05 ; df1=1  ; df2=51-6-1 ;
  f0 = finv(1-alpha, df1, df2) ;
  p = 1 - probf(0.04, df1, df2) ;
  put f0 =  ;
  put p = ;
run ; 

/*(b)*/
proc reg data=cigarette ;
	model Sales = Age HS Income Black Female Price ;
	test Female = HS = 0 ;
quit ;

/*(c)*/
proc reg data=cigarette ;
	model Sales = Age Income Black Price ;
quit ;
data pvalue ;
  alpha = 0.05 ; df=51-4-1 ;
  t0 = tinv(1-alpha, df) ;
  p = 1 - probt(2.75, df) ;
  put t0 =  ;
  put p = ;
run ; 

/*(d)*/
proc reg data=cigarette ;
	model Sales = Age Black Price ;
quit ;

/*(e)*/
proc reg data=cigarette ;
	model Sales = Price Age Income ;
quit ;

/*(f)*/
proc reg data=cigarette ;
	model Sales = Income ;
quit ;
proc corr data=cigarette;
	var Sales Income;
run;


/**********************************************************************************************************************/
