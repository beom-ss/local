
/********************************************************문제 1*************************************************************/
data dataset_01 ;
	infile"D:\dataset_01.txt" firstobs=2 expandtabs ;
	input a1 a2 ;
run ;

/*(1)(2)(3)*/
proc reg data=dataset_01 ;
	model a1 = a2 ;
	test a2 = - 0.1 ;
run ; quit ;

/*(4)*/
data tvalue ;
	alpha=0.10 ;
	df=(10-2) ;
	t=tinv(1-alpha/2, df) ;   
	put t= ;
run ; 

/*(5)*/
data temp ;  
	input a2 ;
	cards ;
100
;
run ;
data dataset_01 ; 
	set dataset_01 temp ;
run ;
proc reg data=dataset_01 ; 
	model a1 = a2 / clm  ;
run ; quit ;
/**************************************************************************************************************************/



/********************************************************문제 2*************************************************************/
data dataset_02 ;
	infile"D:\dataset_02.txt" firstobs=2 expandtabs ;
	input a1 a2 a3 a4 a5 ;
run ;

/*(1)(2)(3)(4)*/
proc reg data=dataset_02 ;
	model a3 = a1 a2 a4 a5 / i ;
	test a1=1 ;
	test a2=a4=0 ;
run ; quit ;

/*(5)*/
data temp ;  
	input a1 a2 a4 a5 ;
	cards ;
1 2 1 1
;
run ;
data dataset_02 ; 
	set dataset_02 temp ;
run ;
proc reg data=dataset_02 ; 
	model a3 = a1 a5 / clm alpha=0.1 ;
run ; quit ;
/**************************************************************************************************************************/



/********************************************************문제 3*************************************************************/
data dataset_03 ;
	infile"D:\dataset_03.txt" firstobs=2 expandtabs ;
	input x1 x2 x3 y ;
run ;

/*(1)(2)(3)*/
data dataset_03 ;
	set dataset_03 ;
	obs_num = _N_ ; 
run ;

proc reg data = dataset_03 ;
	model y = x1 x2 x3  / r influence vif ;
	output out = dataset_03_stat
    p=yhat Residual=ei RStudent=ti Cookd=cooki h=hii DFFITS=df_fit ; 
run ; quit ;

data dataset_03_stat ; 
	set dataset_03_stat ;
 	di = (ei/sqrt(198.67450)) ;         
    potential_Fuction = hii/(1-hii) ;   
    residual_Function = ((1+1)/(1-hii))*((di*di)/(1-di*di)) ;  
    hadi = potential_Fuction + residual_Function ; 
run;

proc univariate data=dataset_03_stat normal plot;    /*오차의 가정-정규성*/
	VAR ti ; 
	QQPLOT ti  / NORMAL(MU=EST SIGMA=EST COLOR=RED L=1) ;
run;
proc sgplot data=dataset_03_stat ;		scatter x=yhat y=ti                 / datalabel=obs_num;	  run;    /*오차의 가정-등분산성*/
proc sgplot data=dataset_03_stat ;		scatter x=x1 y=ti                    / datalabel=obs_num;	  run;    /*선형성 가정-설명변수*/ 
proc sgplot data=dataset_03_stat ;		scatter x=x2 y=ti                    / datalabel=obs_num;	  run;    /*선형성 가정-설명변수*/ 
proc sgplot data=dataset_03_stat ;		scatter x=x3 y=ti                    / datalabel=obs_num;	  run;    /*선형성 가정-설명변수*/ 
proc sgplot data=dataset_03_stat ;		scatter x=obs_num y=ti         / datalabel=obs_num;   run;    /*특이값*/ 
proc sgplot data=dataset_03_stat ;		scatter x=obs_num y=hii       / datalabel=obs_num;   run;    /*지레점*/ 
proc sgplot data=dataset_03_stat ;		scatter x=obs_num y=cooki  / datalabel=obs_num;   run;    /*영향력*/
proc sgplot data=dataset_03_stat ;		scatter x=obs_num y=df_fit    / datalabel=obs_num;  run;     /*영향력*/
proc sgplot data=dataset_03_stat ;		scatter x=obs_num y=hadi    / datalabel=obs_num;  run;     /*영향력*/
proc sgplot data=dataset_03_stat ;		scatter x=residual_Function y=potential_Fuction / datalabel=obs_num; run;  /*영향력*/

/*(4)*/
proc sql ;
	create table dataset_03_delete as 
    select * 
 	from dataset_03
    where obs_num not in (5, 8, 16, 20) ;	 
quit;
proc reg data=dataset_03_delete ;
	model y = x1 x2 x3 / r influence vif ; 
	output out=dataset_03_delete_stat
	p=yhat	Residual=ei  Rstudent=ti h=hii Cookd=cooki DFFITS=df_fit ;
run ; quit ;
data dataset_03_delete_stat; 
	set dataset_03_delete_stat;
 	di = (ei/sqrt(5.14359)) ;        
    potential_Fuction = hii/(1-hii) ;   
    residual_Function = ((1+1)/(1-hii))*((di*di)/(1-di*di)) ;  
    hadi = potential_Fuction + residual_Function ; 
run;

proc univariate data=dataset_03_delete_stat normal plot;    /*오차의 가정-정규성*/
	VAR ti ; 
	QQPLOT ti  / NORMAL(MU=EST SIGMA=EST COLOR=RED L=1) ;
run;
proc sgplot data=dataset_03_delete_stat ;		scatter x=yhat y=ti                 / datalabel=obs_num;	  run;    /*오차의 가정-등분산성*/
proc sgplot data=dataset_03_delete_stat ;		scatter x=x1 y=ti                    / datalabel=obs_num;	  run;    /*선형성 가정-설명변수*/ 
proc sgplot data=dataset_03_delete_stat ;		scatter x=x2 y=ti                    / datalabel=obs_num;	  run;    /*선형성 가정-설명변수*/ 
proc sgplot data=dataset_03_delete_stat ;		scatter x=x3 y=ti                    / datalabel=obs_num;	  run;    /*선형성 가정-설명변수*/ 
proc sgplot data=dataset_03_delete_stat ;		scatter x=obs_num y=ti         / datalabel=obs_num;   run;    /*특이값*/ 
proc sgplot data=dataset_03_delete_stat ;		scatter x=obs_num y=hii       / datalabel=obs_num;   run;    /*지레점*/ 
proc sgplot data=dataset_03_delete_stat ;		scatter x=obs_num y=cooki  / datalabel=obs_num;   run;    /*영향력*/
proc sgplot data=dataset_03_delete_stat ;		scatter x=obs_num y=df_fit    / datalabel=obs_num;  run;     /*영향력*/
proc sgplot data=dataset_03_delete_stat ;		scatter x=obs_num y=hadi    / datalabel=obs_num;  run;     /*영향력*/
proc sgplot data=dataset_03_delete_stat ;		scatter x=residual_Function y=potential_Fuction / datalabel=obs_num; run;  /*영향력*/
/**************************************************************************************************************************/



/********************************************************문제 4*************************************************************/
data dataset_04 ;
	infile"D:\dataset_04.txt" firstobs=2 expandtabs ;
	input e s x y ;
run ;

/*(1)*/
proc reg data=dataset_04 ;
	model y = x ;
run ; quit ;

/*(2)*/
data dataset_04 ;
	set dataset_04 ;
	ex = e*x ;
run ;
proc reg data=dataset_04 ;
	model y = x e ex ;
	test e=ex=0 ;
run ; quit ;

/*(3)*/
data dataset_04 ;
	set dataset_04 ;
	es = e*s ;
run ;
proc reg data=dataset_04 ;
	model y = x e s es ;
	test es=0 ;
run ; quit ;
/**************************************************************************************************************************/
