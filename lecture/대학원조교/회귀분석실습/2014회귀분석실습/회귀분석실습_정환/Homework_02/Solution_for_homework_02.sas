
/**********************************************************************************************************************/

/* exercise 4-3 */

/**********************************************************************************************************************/


/*데이터 입력*/
data repair ;
	infile "D:\Computer_Repair.txt"	expandtabs firstobs=2 ;
	input  Units	Minutes ;
run ;


/*(a)*/

/*산점도*/
goption reset=all ;
symbol1	color=red		interpol=none	value=dot     ;                    
symbol2	color=blue 	interpol=rl			value=none  ;                      
proc gplot data=repair ;                         
	plot  Minutes*Units=1 Minutes*Units=2 / overlay ; 
run ; quit ;

proc reg data=repair ;
	model Minutes=Units ;
quit ;


/*(b)*/
proc reg data=repair ;
	model Minutes=Units / r  influence vif  ;
	output out = residual_repair p=yhat Rstudent=ti  ; 
quit ;     /* 잔차관련 통계량 추출 */

data residual_repair ;
	set residual_repair ;
	obs=_N_ ;
run;      /* 관측치 번호 추가 */

/*정규성*/
proc univariate data=residual_repair normal plot ;
	var ti ;
run;      
/*등분산성과 독립성*/
goption reset=all ;
symbol1	color=red		interpol=none	value=dot     ;                    
proc gplot data=residual_repair ;                        
	plot ti * Units ;     
    plot ti * obs ;
    plot ti * yhat ;      
run; quit ;     
/*정규성은 만족하는 것 같다.*/
/*Λ자형의 패턴이 계속 나타나는 것으로, 등분산성과 독립성 모두 만족되지 않는 것으로 보는 것이 타당할 것 같다.*/
/*Hadi 교재에서는 선형성 가정이라는 것도 추가로 말하고 있는데, 어쨌거나 선형성도 깨진다.*/


/**********************************************************************************************************************/

/* exercise 4-12 */

/**********************************************************************************************************************/


/*데이터 입력*/
data example ;
	infile "D:\Exercise_4.12-4.14.txt"  expandtabs firstobs=2 ;
	input  Y  	X1 	X2 	X3  	X4 	X5   	X6  ;
run ;


/*(a)*/

proc reg data=example ;
	model  Y = X1 	X2 	X3  	X4 	X5   	X6  / r influence vif ;
	output out=temp_1 p=yhat Residual=ei Student=ri Rstudent=ti Cookd=Ci DFFITS=DFi h=hii ;
quit ;
data temp_2 ;                 
	SET temp_1 ;
   	obs = _N_ ;  
run;
/*정규성*/
proc univariate data=temp_2 normal plot ;
	var ti ;
run;      
/*등분산성과 독립성*/
goption reset=all ;
symbol1	color=red		interpol=none	value=dot     ;                    
proc gplot data=temp_2 ;                        
	plot ti * X1 ;  plot ti * X2 ; plot ti * X3 ; plot ti * X4 ;	plot ti * X5 ; 	plot ti * X6 ;;
    plot ti * obs ;  plot ti * yhat ;      
run; quit ;     

/*교재 4.2절-"회귀분석의 표준적인 가정들"을 참고한다.*/
/*우선, 예측변수들이 서로 독립이 아니다. (다중공선성이 의심됨)*/
/*정규성과 독립성은 문제가 없는 것 같다.*/
/*등분산성은 문제가 있는 것 같다. 표준화 잔차의 인덱스 플롯에서 점점 퍼지는 형태가 보였다.*/



/*(b),(c),(d)*/

data temp_3 ;                 
	SET temp_2 ;
   	di = (ei/sqrt(26813)) ;
    potential_Fuction = hii/(1-hii) ;
	residual_Function = ((1+6)/(1-hii))*((di*di)/(1-di*di)) ;
	Hi = potential_Fuction + residual_Function ;
RUN; 

goption reset=all ;
symbol1	color=red		interpol=none	value=dot     ;     
proc gplot data=temp_3 ;   
	plot ri * obs ;
	plot Ci * obs ;
	plot DFi * obs ;
	plot  Hi * obs ;                                                 
  	plot  potential_Fuction * residual_Function ;    
run; quit;
proc insight data=temp_3 ;
run ;

/*일부 튀는 관측치가 보인다. proc insight를 통해 관측치 번호를 찾을 수 있다.*/
/*ri, hii, Ci, DFi, Hi 의 index plot 과 잠재성-잔차 플롯, 총 6가지의 플롯으로부터 튀는 관측치를 확인할 수 있다.*/


/**********************************************************************************************************************/
