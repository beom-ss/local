
/***********************************************************************************************************************/
/* 사례 : NewYork River */
/***********************************************************************************************************************/

/*data입력*/
data river ;
	infile"D:\NewYork_River.txt"  expandtabs firstobs=2 ;
	length river $ 15 ;
	input river $ x1 -x4 y ;
run;
data river;
	set river;
	obs_num = _N_ ; 	  /* 관측치번호 */ 
run;
/*데이터에 관측치 번호만 추가해줌(이후 분석의 편의를 위해서)*/

/*모형적합 전 데이터탐색*/
proc insight data=river;
run;
/*모형 적합 후 오차의 가정 검토 & 영향력 있는 관측개체 탐지*/
proc reg data = river;
	model y = x4 /r influence vif;
	output out = river_stat
    p=yhat Residual=ei RStudent=ti Cookd=cooki h=hii DFFITS=df_fit; 
/*p는 예측값을, Residual은 잔차를, Rstudent는 외적표준화잔차를, Cookd는 Cook의 거리를, h는 지레값을, DFFITS는 DFFits값을 의미함*/
quit;
/*Hadi가 제안하는 통계량의 계산*/
data river_stat; 
	set river_stat;
 	di = (ei/sqrt(2.59540)) ;             /* 정규화잔차 = 잔차/sqrt(적합된 모형의 SSE) */
    potential_Fuction = hii/(1-hii) ;   /* 잠재성 함수 */
    residual_Function = ((1+1)/(1-hii))*((di*di)/(1-di*di)) ;  /* 잔차 함수 */
    hadi = potential_Fuction + residual_Function ;   /* Hadi의 영향력 측도 */
run;
proc insight data=river_stat;
run;

/*모형을 외곡시키는 일부 관측치 제거 후, 다시 오차의 가정 검토 & 영향력 있는 관측개체 탐지*/
proc sql ;
	create table river_delete as 
    select * 
 	from river
    where obs_num not in (4, 5) ;	  /* 관측치번호가 4, 5번인 행 관측치를 제거*/     
quit;
proc reg data = river_delete;
	model y = x4 /r influence vif;      /*R-square와 adjusted R-square가 대폭 증가함.*/
	output out = river_delete_stat
    p=yhat Residual=ei RStudent=ti h=hii Cookd=cooki DFFITS=df_fit;
quit;
data river_delete_stat;
	set river_delete_stat;
 	observation_number = _N_ ; 	  /* 관측치번호 */ 
    di = (ei/sqrt(1.37579)) ;             /* 정규화잔차 = 잔차/sqrt(적합된 모형의 SSE) */
    potential_Fuction = hii/(1-hii) ;   /* 잠재성 함수 */
    residual_Function = ((1+1)/(1-hii))*((di*di)/(1-di*di)) ;  /* 잔차 함수 */
    hadi = potential_Fuction + residual_Function ;   /* Hadi의 영향력 측도 */
run;
proc insight data=river_delete_stat;
run;
/*영향력 있는 관측개체를 무조건 제거하는 것이 아님. 적합결과를 왜곡시킨다고 확실히 판단되는 것에 한해서 선택적으로 제거할 수 있다.*/


/*변수들의 효과에 대한 진단플롯*/
/*첨가변수플롯(Added Variable Plot) - 비선형의 패턴을 확인할 수 있음*/
proc reg data=river ;
	model y = x1 x2 x3 x4 / partial  ;  
quit;
/************************************************************************************************************************/



/************************************************************************************************************************/
/* 사례 : Scottish Hills Races */
/***********************************************************************************************************************/

/*data입력*/
data hill ;
    infile "D:\Scottish_Hills_Races.txt" expandtabs firstobs=2;
	length hill_race$ 30 ;
	input hill_race$ Time Distance Climb ;
run;
data hill;
	set hill;
	obs_num = _N_ ; 	  /* 관측치번호 */ 
run;
/*모형적합 전 데이터탐색*/
proc insight data=hill;
run;
/*모형 적합 후 오차의 가정 검토 & 영향력 있는 관측개체 탐지*/
proc reg data=hill ;
	model Time = Distance Climb  / r influence vif ;
	output out=hill_stat
	p=yhat	Residual=ei  Rstudent=ti h=hii Cookd=cooki DFFITS=df_fit ;
quit;
/*Hadi가 제안하는 통계량의 계산*/
data hill_stat; 
	set hill_stat;
 	di = (ei/sqrt(24810082)) ;          /* 정규화잔차 = 잔차/sqrt(적합된 모형의 SSE) */
    potential_Fuction = hii/(1-hii) ;   /* 잠재성 함수 */
    residual_Function = ((1+1)/(1-hii))*((di*di)/(1-di*di)) ;  /* 잔차 함수 */
    hadi = potential_Fuction + residual_Function ;   /* Hadi의 영향력 측도 */
run;
proc insight data=hill_stat;
run;


/***********************************************************************************************************************/
/*모형 적합 후 오차의 가정 검토 & 영향력 있는 관측개체 탐지 (command)*/
/***********************************************************************************************************************/
proc univariate data=hill_stat normal plot;    /*오차의 가정-정규성*/
	VAR ti ; 
	QQPLOT ti  / NORMAL(MU=EST SIGMA=EST COLOR=RED L=1) ;
run;
/***********************************************************************************************************************/
proc sgplot data=hill_stat ;		scatter x=yhat y=ti                 / datalabel=obs_num;	  run;     /*오차의 가정-등분산성*/
proc sgplot data=hill_stat ;		scatter x=Distance y=ti          / datalabel=obs_num;	  run;     /*선형성 가정-설명변수*/ 
proc sgplot data=hill_stat ;		scatter x=Climb y=ti               / datalabel=obs_num;  run;      /*선형성 가정-설명변수*/ 
proc sgplot data=hill_stat ;		scatter x=obs_num y=ti         / datalabel=obs_num;   run;     /*특이값, 오차의 가정-등분산성 & (독립성)*/ 
proc sgplot data=hill_stat ;		scatter x=obs_num y=hii       / datalabel=obs_num;   run;     /*지레점*/ 
proc sgplot data=hill_stat ;		scatter x=obs_num y=cooki  / datalabel=obs_num;   run;     /*영향력*/
proc sgplot data=hill_stat ;		scatter x=obs_num y=df_fit    / datalabel=obs_num;  run;      /*영향력*/
proc sgplot data=hill_stat ;		scatter x=obs_num y=hadi    / datalabel=obs_num;  run;      /*영향력*/
proc sgplot data=hill_stat ;		scatter x=residual_Function y=potential_Fuction / datalabel=obs_num; run;  /*영향력*/
/***********************************************************************************************************************/


/*모형을 외곡시키는 일부 관측치 제거 후, 다시 오차의 가정 검토 & 영향력 있는 관측개체 탐지*/
proc sql ;
	create table hill_delete as 
    select * 
 	from hill
    where obs_num not in (7, 18) ;	  /* 관측치번호가 7, 18번인 행 관측치를 제거*/     
quit;
proc reg data=hill_delete ;
	model Time = Distance Climb  / r influence vif ;  /*adj_R square가 91%에서 98%로 급상승 */
	output out=hill_delete_stat
	p=yhat	Residual=ei  Rstudent=ti h=hii Cookd=cooki DFFITS=df_fit ;
quit;
/*Hadi가 제안하는 통계량의 계산*/
data hill_delete_stat; 
	set hill_delete_stat;
 	di = (ei/sqrt(3958172)) ;            /* 정규화잔차 = 잔차/sqrt(적합된 모형의 SSE) */
    potential_Fuction = hii/(1-hii) ;   /* 잠재성 함수 */
    residual_Function = ((1+1)/(1-hii))*((di*di)/(1-di*di)) ;  /* 잔차 함수 */
    hadi = potential_Fuction + residual_Function ;   /* Hadi의 영향력 측도 */
run;
proc insight data=hill_delete_stat;
run;
/*일부 영향력 높은 관측치를 제거하면, 오차의 가정이 만족되는 것으로 보인다.*/
/**********************************************************************************************************************/



/**********************************************************************************************************************/
/* exercise 4-3 */
/**********************************************************************************************************************/

/*데이터 입력*/
data repair ;
	infile "D:\Computer_Repair.txt"	expandtabs firstobs=2 ;
	input Units Minutes ;
run ;
data repair ;
	set repair ;
	obs_num=_N_ ;
run;    
/*모형적합 전 데이터탐색*/
proc insight data=repair;
run;
/*모형적합*/
proc reg data=repair;
	model minutes = units/partial; /*첨가변수플롯(Added Variable Plot) - 비선형의 패턴을 확인할 수 있음*/
run;

/*곡선형의 패턴으로부터 X^2항을 추가*/
data repair ;
	set repair ;
	Units2 = Units * Units ;
run;
proc reg data=repair ;
	model Minutes=Units Units2 / vif  ;
quit ;    
/*X와 X^2 사이의 공선성을 제거 - Centering */
proc sql ;
	create table repair as
	select *, (Units - avg(Units)) as Centered_Units
	from repair;
quit ;
proc sql ;
	create table repair as
	select *, (Centered_Units*Centered_Units) as Centered_Units2
	from repair;
quit ;
/*Centering 후에 높은 vif 수치가 개선*/
proc reg data=repair ;
	model Minutes=Centered_Units Centered_Units2 /vif  ;
quit ;    
/*Centering의 효과에 대한 플롯*/
proc sgplot data=repair ;
	scatter x=Units y=Units2 / datalabel=obs_num;
run;     
proc sgplot data=repair ;
	scatter x=Centered_Units y=Centered_Units2 / datalabel=obs_num;
run;    
/**********************************************************************************************************************/



/**********************************************************************************************************************/
/* exercise 4-12 */
/**********************************************************************************************************************/

/*데이터 입력*/
data example ;
	infile "D:\Exercise_4.12-4.14.txt"  expandtabs firstobs=2 ;
	input  Y  	X1 	X2 	X3  	X4 	X5   	X6  ;
run ;
data example;
	set example;
	obs_num = _N_ ; 	  /* 관측치번호 */ 
run;

/*모형적합 전 데이터탐색*/
proc insight data=example;
run;
/*모형 적합 후 오차의 가정 검토 & 영향력 있는 관측개체 탐지*/
proc reg data = example;
	model Y = X1 X2 X3 X4 X5 X6 /r influence vif;
	output out = example_stat
    p=yhat Residual=ei RStudent=ti Cookd=cooki h=hii DFFITS=df_fit; 
quit;
/*Hadi가 제안하는 통계량의 계산*/
data example_stat; 
	set example_stat;
 	di = (ei/sqrt(26813)) ;             /* 정규화잔차 = 잔차/sqrt(적합된 모형의 SSE) */
    potential_Fuction = hii/(1-hii) ;   /* 잠재성 함수 */
    residual_Function = ((1+1)/(1-hii))*((di*di)/(1-di*di)) ;  /* 잔차 함수 */
    hadi = potential_Fuction + residual_Function ;   /* Hadi의 영향력 측도 */
run;
proc insight data=example_stat;     
run;
/*표준화잔차의 플롯에서 깔대기모양의 퍼지는 패턴이 감지되므로, 등분산성이 위배되는 것으로 판단됨.*/
/**********************************************************************************************************************/


