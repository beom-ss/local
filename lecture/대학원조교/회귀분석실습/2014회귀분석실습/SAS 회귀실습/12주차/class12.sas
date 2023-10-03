data newyork;
	infile "C:\Users\kuk\Desktop\NewYork_River_adjust.txt" expandtabs firstobs=2;
	length river$ 15;
	input River$ x1-x4 y;
run;

symbol1 color=black i=none v=dot;
symbol2 color=blue i=rl v=none;

proc gplot data=newyork;
	plot y*x4=1 y*x4=2/overlay;
run;

proc reg data=newyork;
	model y=x4;
	plot y*x4;
run;

data newriver;
	set newyork;
	if river='Neversink' then delete;
	if river='Hackensack' then delete;
run;

symbol1 color=black i=none v=dot;
symbol2 color=blue i=rl v=none;

proc gplot data=newriver;
	plot y*x4=1 y*x4=2/overlay haxis=0 to 3.5 by 0.5;
run;

proc reg data=newriver;
	model y=x4;
	plot y*x4/haxis=0 to 3.5 by 0.5;
run;

proc reg data=newyork ;
	model y = x4 / r ;
	output out=out1
		p=yhat	Residual=ei  Student=ri  Cookd=Ci;
quit;

proc reg data=newyork ;
	model y = x4  /influence ;
	output out=out2
		p=yhat	Residual=ei Student=ri Cookd=cooki Rstudent=ti h=hii COVRATIO=cov DFFITS=df_fit PRESS=press ;
quit;

/*참고로만 알려주기*/
proc reg data=newyork ;
	model y = x4 / r influence vif ;
	ods output outputstatistics = outall;
quit;

proc reg data=river ;
	model y = x4 / cli clm;
	ods output outputstatistics = outcl ;
quit;

/*(1) 오차의 가정에 대한 진단*/
/***********************************************************************************************************************/
/*가장 중요한 것으로, 오차의 가정이 위배되면, 가정 하에 세운 회귀모형은 적절하지 않은 것이 된다.*/

/*정규성*/
proc univariate data=out2 normal plot;    /*(표준화)잔차 정규확률플롯*/
	VAR ti ;
	QQPLOT ti  / NORMAL(MU=EST SIGMA=EST COLOR=RED L=1) ;
	HISTOGRAM / NORMAL(COLOR=MAROON W=4) CFILL = BLUE CFRAME = LIGR ;
		INSET MEAN STD / CFILL=BLANK FORMAT=5.2 ;
run;
/* color,w는 정규성선 */
/*CFILL = BLUE CFRAME = LIGR  이건 각각 막대색, 배경색*/
/* INSET MEAN STD / CFILL=BLANK FORMAT=5.2 는 범례...랑 흰바탕....*/
/*	PPPLOT ti  / NORMAL(MU=EST SIGMA=EST COLOR=RED L=1) ;*/


/*참고*/
proc kde data=out2 out=density; 
  var ti;
run;
proc sort data=density;
  by ti;
run;
goptions reset=all;
symbol1 c=blue i=join v=none height=1;
proc gplot data=density;
  plot density*ti = 1;
run; quit;
/* 정규 그림 그리기 위함..*/


/*등분산성, 독립성*/
/***********************************************************************************************************************/
/*관측치 번호를 할당*/

data test ;                 
	SET out2 ;
    	id = _N_ ;  
run;

proc plot data=test ;                         		/* v = vertical axis(세로축)을 의미, h = horizontal axis(가로축)을 의미  */
	plot ti * id      /vpos=30 hpos=120 ;       /*(표준화)잔차의 인덱스 플롯 -> 등분산성 및 독립성 체크*/ 
    plot ti * x4     /vpos=30 hpos=120 ;       /*(표준화)잔차 대 설명변수 -> 오차와 설명변수 사이의 무상관 체크*/
    plot ti * yhat  /vpos=30 hpos=120 ;       /*(표준화)잔차 대 적합값 -> 오차와 적합값 사이의 무상관 체크*/
run;                                                          /* vpos : 세로축 길이, hpos : 가로축 길이 */
/* proc insight의 그래프 기능을 이용하면, 직관적이고 간편하게 살펴볼 수 있음. * /
/* SAS 9.3부터는 이 기능이 막힌 듯 하다. */

proc insight data=test;
run; 

/*(2) 높은 지레점(high leverage point), 영향력 있는 관측치(influential point), 특이치(outlier)에 대한 진단*/
proc plot data=test ;   
	plot  hii * id /vpos=30 hpos=120 ;                    /*지레값(leverage value)의 인덱스 플롯*/
  	plot  cooki * id /vpos=30 hpos=120 ;               /*Cook's Distance 인덱스 플롯*/
	plot  df_fit * id /vpos=30 hpos=120 ;                /*DFITS값의 인덱스 플롯*/
run;

proc insight data=test;
run;



/*Hadi의 영향력 측도*/

proc reg data=newyork ;
	model y = x4  ;
run;

data test2 ;
	set test ;
	di = (ei/sqrt(2.59540)) ;															/*di=ei/sqrt(sse)*/
    potential_Fuction = hii/(1-hii) ;
	residual_Function = ((1+1)/(1-hii))*((di*di)/(1-di*di)) ;
	hadi = potential_Fuction + residual_Function ;
run;

proc plot data=test2;   
	plot  hadi * id /vpos=30 hpos=120 ;                                                 		/*hadi의 영향력 측도의 인덱스 플롯*/
  	plot  potential_Fuction * residual_Function /vpos=30 hpos=120 ;    			/*잠재성 - 잔차 플롯*/
run;

/*proc insight의 그래프 기능을 이용하면, 직관적이고 간편하게 살펴볼 수 있음.*/

proc insight data=test2; 
run;

goptions reset=all;
symbol color=black i=none v=dot;
proc gplot data=test2;
	plot potential_Fuction * residual_Function;
run;


/* 연습문제 4.12*/
/*데이터 입력*/

data example ;
	infile "C:\Users\kuksunghee\Desktop\대학원\조교\2학기 회귀실\회귀실\12주차\Exercise_4.12-4.14.txt"  expandtabs firstobs=2 ;
	input  Y  	X1 	X2 	X3  	X4 	X5   	X6  ;
run ;


/*(a)*/

proc reg data=example ;
	model  Y = X1 	X2 	X3  	X4 	X5   	X6  / r influence vif ;
	output out=temp1 p=yhat Residual=ei Student=ri Rstudent=ti Cookd=Ci DFFITS=DFi h=hii ;
quit ;

proc sgscatter data=temp1 ;
  matrix y x1-x6 ;
run;

data temp2 ;                 
	SET temp1 ;
   	obs = _N_ ;  
run;

/*정규성*/
proc univariate data=temp2 normal plot ;
	var ti ;
run;      
/*등분산성과 독립성*/

goption reset=all ;
symbol1	color=black	i=none	v=dot     ;                    
proc gplot data=temp2 ;                        
	plot ti * X1 ;  plot ti * X2 ; plot ti * X3 ; plot ti * X4 ;	plot ti * X5 ; 	plot ti * X6 ;
    plot ti * obs ;  plot ti * yhat ;      
run;



/*교재 4.2절-"회귀분석의 표준적인 가정들"을 참고한다.*/
/*우선, 예측변수들이 서로 독립이 아니다. (다중공선성이 의심됨)*/
/*정규성과 독립성은 문제가 없는 것 같다.*/
/*등분산성은 문제가 있는 것 같다. 표준화 잔차의 인덱스 플롯에서 점점 퍼지는 형태가 보였다.*/



/*(b),(c),(d)*/

data temp3 ;                 
	SET temp2 ;
   	di = (ei/sqrt(26813)) ;
    potential_Fuction = hii/(1-hii) ;
	residual_Function = ((1+6)/(1-hii))*((di*di)/(1-di*di)) ;
	Hi = potential_Fuction + residual_Function ;
run; 

goption reset=all ;
symbol1	color=black		interpol=none	value=dot     ;     
proc gplot data=temp3 ;   
	plot ri * obs ;
	plot Ci * obs ;
	plot DFi * obs ;
	plot  Hi * obs ;                                                 
  	plot  potential_Fuction * residual_Function ;    
run;
proc insight data=temp3 ;
run ;

/*일부 튀는 관측치가 보인다. proc insight를 통해 관측치 번호를 찾을 수 있다.*/
/*ri, hii, Ci, DFi, Hi 의 index plot 과 잠재성-잔차 플롯, 총 6가지의 플롯으로부터 튀는 관측치를 확인할 수 있다.*/


/**********************************************************************************************************************/
