
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


proc insight data=river;
run;
proc reg data = river;
	model y = x4 /r influence vif;
	output out = river_stat
    p=yhat Residual=ei RStudent=ti Cookd=cooki h=hii DFFITS=df_fit; 
quit;
data river_stat; 
	set river_stat;
 	di = (ei/sqrt(2.59540)) ;            
    potential_Fuction = hii/(1-hii) ;   
    residual_Function = ((1+1)/(1-hii))*((di*di)/(1-di*di)) ;  
    hadi = potential_Fuction + residual_Function ; 
run;
proc insight data=river_stat;
run;

proc sql ;
	create table river_delete as 
    select * 
 	from river
    where obs_num not in (4, 5) ;	 
quit;
proc reg data = river_delete;
	model y = x4 /r influence vif;      
	output out = river_delete_stat
    p=yhat Residual=ei RStudent=ti h=hii Cookd=cooki DFFITS=df_fit;
quit;
data river_delete_stat;
	set river_delete_stat;
 	observation_number = _N_ ; 	 
    di = (ei/sqrt(1.37579)) ;             
    potential_Fuction = hii/(1-hii) ;   
    residual_Function = ((1+1)/(1-hii))*((di*di)/(1-di*di)) ;  
    hadi = potential_Fuction + residual_Function ;  
run;
proc insight data=river_delete_stat;
run;


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
	obs_num = _N_ ; 	
run;
proc insight data=hill;
run;

proc reg data=hill ;
	model Time = Distance Climb  / r influence vif ;
	output out=hill_stat
	p=yhat	Residual=ei  Rstudent=ti h=hii Cookd=cooki DFFITS=df_fit ;
quit;
data hill_stat; 
	set hill_stat;
 	di = (ei/sqrt(24810082)) ;          
    potential_Fuction = hii/(1-hii) ;
    residual_Function = ((1+1)/(1-hii))*((di*di)/(1-di*di)) ;  
    hadi = potential_Fuction + residual_Function ;  
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


proc sql ;
	create table hill_delete as 
    select * 
 	from hill
    where obs_num not in (7, 18) ;	 
quit;
proc reg data=hill_delete ;
	model Time = Distance Climb  / r influence vif ;  
	output out=hill_delete_stat
	p=yhat	Residual=ei  Rstudent=ti h=hii Cookd=cooki DFFITS=df_fit ;
quit;
data hill_delete_stat; 
	set hill_delete_stat;
 	di = (ei/sqrt(3958172)) ;         
    potential_Fuction = hii/(1-hii) ;   
    residual_Function = ((1+1)/(1-hii))*((di*di)/(1-di*di)) ;  
    hadi = potential_Fuction + residual_Function ;  
run;
proc insight data=hill_delete_stat;
run;
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
proc insight data=repair;
run;
proc reg data=repair;
	model minutes = units/partial;
run;

data repair ;
	set repair ;
	Units2 = Units * Units ;
run;
proc reg data=repair ;
	model Minutes=Units Units2 / vif  ;
quit ;    
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
proc reg data=repair ;
	model Minutes=Centered_Units Centered_Units2 /vif  ;
quit ;    
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
	obs_num = _N_ ; 	 
run;

proc insight data=example;
run;
proc reg data = example;
	model Y = X1 X2 X3 X4 X5 X6 /r influence vif;
	output out = example_stat
    p=yhat Residual=ei RStudent=ti Cookd=cooki h=hii DFFITS=df_fit; 
quit;
data example_stat; 
	set example_stat;
 	di = (ei/sqrt(26813)) ;          
    potential_Fuction = hii/(1-hii) ; 
    residual_Function = ((1+1)/(1-hii))*((di*di)/(1-di*di)) ; 
    hadi = potential_Fuction + residual_Function ;  
run;
proc insight data=example_stat;     
run;
/**********************************************************************************************************************/


