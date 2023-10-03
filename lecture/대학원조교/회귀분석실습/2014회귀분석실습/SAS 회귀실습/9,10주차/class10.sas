/*데이터 읽기*/
data supervisor_A  ;
	infile "D:\supervisor_A.txt" ;
	input y x1 x2 x3 x4 x5 x6 ;
run;

/*(1) 모든 회귀계수들이 0 인가에 대한 검정*/

/*full model*/
proc reg data=supervisor_A ;
	model y = x1 x2 x3 x4 x5 x6 ;  
run;
/*reduced model*/
proc reg data=supervisor_A;
	model y =  ;
run;
/*통계량 확인*/
data pvalue ;
  alpha = 0.05 ; df1=6  ; df2=30-6-1 ;
  f0 = finv(1-alpha, df1, df2) ;
  p = 1 - probf(10.50, df1, df2) ;
  put f0 =  ;
  put p = ;
run ; 
/*(2) 일부 회귀계수들이 0 인가에 대한 검정*/

/*full model*/
proc reg data=supervisor_A ;
	model y = x1 x2 x3 x4 x5 x6 ;  
run;
/*reduced model*/
proc reg data=supervisor_A;
	model y = x1 x3  ;  
run;
/*test option*/
proc reg data=supervisor_A ;
	model y = x1 x2 x3 x4 x5 x6 ;  
	test x2=x4=x5=x6=0 ;
run;
/*통계량 확인*/
data values ;
  alpha = 0.05 ; df1=4  ; df2=30-6-1 ;
  f0 = finv(1-alpha, df1, df2) ;
  p = 1 - probf(0.53, df1, df2) ;
  put f0 =  ;
  put p = ;
run ; 


/*(3) 일부 회귀계수들이 동일 한가에 대한 검정*/

/*Situation 1 : b1=b3 */
/************************************/
/*full model*/
proc reg data=supervisor_A ;
	model y = x1 x2 x3 x4 x5 x6 ;  
run;
/*reduced model*/
proc sql;
	create table temp as
	select * , (x1+x3) as v 
	from supervisor_A;
run;
proc reg data=temp ;
	model y = v x2 x4 x5 x6;
run;
/*test option*/
proc reg data=supervisor_A ;
	model y = x1 x2 x3 x4 x5 x6 ; 
    test x1=x3 ;
run;
/*통계량 확인*/
data values ;
  alpha = 0.05 ; df1=1  ; df2=30-6-1 ;
  f0 = finv(1-alpha, df1, df2) ;
  p = 1 - probf(1.21, df1, df2) ;
  put f0 =  ;
  put p = ;
run ; 

/* Situation 2 : b1=b3, b1+b3=1 | b2=b4=b5=b6=0 */
/**********************************************/
/*full model*/
proc reg data=supervisor_A ;
	model y = x1 x3 ;  
run;
/*reduced model*/
proc sql;
	create table temp as
	select * , (y - 0.5*x1 - 0.5*x3) as z
	from supervisor_A;
quit;
proc reg data=temp ;
	model z =  ;
run;
/*test option*/
proc reg data=supervisor_A;
 model y = x1 x3;
 test x1=x3=0.5 ;
run;
/*통계량 확인*/
data values ;
  alpha = 0.05 ; df1=2  ; df2=30-2-1 ;
  f0 = finv(1-alpha, df1, df2) ;
  p = 1 - probf(2.31, df1, df2) ;
  put f0 =  ;
  put p = ;
run ; 

/* Situation 3 : b1=b3, b1+b3=1 | b4=b5=b6=0 */
/**********************************************/
/*full model*/
proc reg data=supervisor_A ;
	model y = x1 x2 x3 ;  
run;
/*reduced model*/
proc sql;
	create table temp as
	select * , (y - 0.5*x1 - 0.5*x3) as z
	from supervisor_A;
run;
proc reg data=temp ;
	model z =  x2 ;
run;
/*test option*/
proc reg data=supervisor_A;
 model y = x1 x2 x3;
 test x1=x3=0.5 ;
run;
/*통계량 확인*/
data values ;
  alpha = 0.05 ; df1=2  ; df2=30-3-1 ;
  f0 = finv(1-alpha, df1, df2) ;
  p = 1 - probf(1.98, df1, df2) ;
  put f0 =  ;
  put p = ;
run ; 



