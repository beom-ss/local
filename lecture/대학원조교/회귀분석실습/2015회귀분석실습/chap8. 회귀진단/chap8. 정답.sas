data exam;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap8. 회귀진단\t4_8.txt"  expandtabs firstobs=2 ;
	input  y x1-x6;
run ;


proc reg data=exam ;
	model  y =x1-x6 / r influence vif ;
	output out=exam_out p=yhat Residual=ei Student=ri Rstudent=ti Cookd=Ci DFFITS=DFFITSi h=hii ;
quit ;

proc sgscatter data=exam_out;
  matrix y x1-x6;
run;

data exam_out;
	SET exam_out;
   	id= _N_;  
run;

/*1*/
/*정규성*/
proc univariate data=exam_out normal plot ;
	var ti;
run;
/*등분산성과 독립성*/

symbol i=none v=dot;
proc gplot data=exam_out ;                        
	plot ti*X1;
	plot ti*X2;
	plot ti*X3;
	plot ti*X4;
	plot ti*X5;
	plot ti*X6;
    plot ti*id;
	plot ti*yhat;
run;

/*교재 4.2절-"회귀분석의 표준적인 가정들"을 참고한다.*/
/*우선, 예측변수들이 서로 독립이 아니다. (다중공선성이 의심됨)*/
/*정규성과 독립성은 문제가 없는 것 같다.*/
/*등분산성은 문제가 있는 것 같다. 표준화 잔차의 인덱스 플롯에서 점점 퍼지는 형태가 보였다.*/




/*2*/
data exam_out2;
	set exam_out;
   	di = (ei/sqrt(26813)) ;
    potential_function = hii/(1-hii) ;
	residual_function = ((1+6)/(1-hii))*((di**2)/(1-di**2)) ;
	Hi = potential_function + residual_function ;
run; 
/*3*/
symbol i=none v=dot;
proc gplot data=exam_out2;
	plot ri*id;
	plot Ci*id;
	plot DFFITSi*id;
	plot  Hi*id;                                                 
  	plot  potential_function*residual_function ;    
run;

/*일부 튀는 관측치가 보인다.
ri, hii, Ci, DFi, Hi 의 index plot 과 잠재성-잔차 플롯, 총 6가지의 플롯으로부터 튀는 관측치를 확인할 수 있다.*/

