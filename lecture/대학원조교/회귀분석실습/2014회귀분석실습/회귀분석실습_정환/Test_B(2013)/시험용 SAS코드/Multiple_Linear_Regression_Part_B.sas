/********************************** 이론편 **********************************/

/*예제 : Supervisor Performance*/

/*1. data input*/
/* infile 의 옵션에서 expandtabs는 공백이 큰 관측치를 구별해주는 역할을 한다. */
/* infile 의 옵션에서 firstobs=2는 파일 첫 번째 줄이 변수명을 포함하고 있는 경우에 사용한다. */
data supervisor_A  ;
	infile "D:\supervisor_A.txt" ;
	input y x1 x2 x3 x4 x5 x6 ;
/*	input y x1-x6 ;*/
run;
data supervisor_B ;
	infile "D:\supervisor_B.txt" expandtabs;
	input y x1-x6 ;
run;
data supervisor_C  ;
	infile "D:\supervisor_C.txt" firstobs=2;
	input y x1-x6 ;
run;


proc reg data=supervisor_A ;
	model y = x1 x2 x3 x4 x5 x6 ;  
quit;
proc reg data=supervisor_A;
	model y =  ;
quit;
data pvalue ;
  alpha = 0.05 ; df1=6  ; df2=30-6-1 ;
  f0 = finv(1-alpha, df1, df2) ;
  p = 1 - probf(10.50, df1, df2) ;
  put f0 =  ;
  put p = ;
run ; 


proc reg data=supervisor_A ;
	model y = x1 x2 x3 x4 x5 x6 ;  
quit;
proc reg data=supervisor_A;
	model y = x1 x3  ;  
quit;
proc reg data=supervisor_A ;
	model y = x1 x2 x3 x4 x5 x6 ;  
	test x2=x4=x5=x6=0 ;
quit;
data values ;
  alpha = 0.05 ; df1=4  ; df2=30-6-1 ;
  f0 = finv(1-alpha, df1, df2) ;
  p = 1 - probf(0.53, df1, df2) ;
  put f0 =  ;
  put p = ;
run ; 


proc reg data=supervisor_A ;
	model y = x1 x2 x3 x4 x5 x6 ;  
quit;
proc sql;
	create table temp as
	select * , (x1+x3) as v 
	from supervisor_A;
quit;
proc reg data=temp ;
	model y = v x2 x4 x5 x6;
quit;
proc reg data=supervisor_A ;
	model y = x1 x2 x3 x4 x5 x6 ; 
    test x1=x3 ;
quit;
data values ;
  alpha = 0.05 ; df1=1  ; df2=30-6-1 ;
  f0 = finv(1-alpha, df1, df2) ;
  p = 1 - probf(1.21, df1, df2) ;
  put f0 =  ;
  put p = ;
run ; 



proc reg data=supervisor_A ;
	model y = x1 x3 ;  
quit;
proc sql;
	create table temp as
	select * , (x1+x3) as v 
	from supervisor_A;
quit;
proc reg data=temp ;
	model y = v ;
quit;
proc reg data=temp ;
	model y = x1 x3  ;  
	test x1=x3 ;
quit;
data values ;
  alpha = 0.05 ; df1=1  ; df2=30-2-1 ;
  f0 = finv(1-alpha, df1, df2) ;
  p = 1 - probf(3.66, df1, df2) ;
  put f0 =  ;
  put p = ;
run ; 


proc reg data=supervisor_A ;
	model y = x1 x2 x3 x4 x5 x6 ;  
quit;
proc sql;
	create table temp as
	select * , (x1+x3) as v 
	from supervisor_A;
quit;
proc reg data=temp ;
	model y = v ;
quit;
proc reg data=supervisor_A;
 model y=x1 x2 x3 x4 x5 x6;
 test x1=x3 , x2=x4=x5=x6=0;
quit;
data values ;
  alpha = 0.05 ; df1=5  ; df2=30-6-1 ;
  f0 = finv(1-alpha, df1, df2) ;
  p = 1 - probf(1.10, df1, df2) ;
  put f0 =  ;
  put p = ;
run ; 


proc reg data=supervisor_A ;
	model y = x1 x3 ;  
quit;
proc sql;
	create table temp as
	select * ,  (y-x3) as z ,  (x1-x3) as v 
	from supervisor_A;
quit;
proc reg data=temp ;
	model z = v ;
quit;
proc reg data=supervisor_A;
 model y = x1 x3;
 test x1 + x3 = 1 ;
quit;
data values ;
  alpha = 0.05 ; df1=1  ; df2=30-2-1 ;
  f0 = finv(1-alpha, df1, df2) ;
  p = 1 - probf(1.61, df1, df2) ;
  put f0 =  ;
  put p = ;
run ; 


proc reg data=supervisor_A ;
	model y = x1 x3 ;  
quit;
proc sql;
	create table temp as
	select * , (y - 0.5*x1 - 0.5*x3) as z
	from supervisor_A;
quit;
proc reg data=temp ;
	model z =  ;
quit;
proc reg data=supervisor_A;
 model y = x1 x3;
 test x1=x3=0.5 ;
quit;
data values ;
  alpha = 0.05 ; df1=2  ; df2=30-2-1 ;
  f0 = finv(1-alpha, df1, df2) ;
  p = 1 - probf(2.31, df1, df2) ;
  put f0 =  ;
  put p = ;
run ; 


proc reg data=supervisor_A ;
	model y = x1 x2 x3 ;  
quit;
proc sql;
	create table temp as
	select * , (y - 0.5*x1 - 0.5*x3) as z
	from supervisor_A;
quit;
proc reg data=temp ;
	model z =  x2 ;
quit;
proc reg data=supervisor_A;
 model y = x1 x2 x3;
 test x1=x3=0.5 ;
quit;
data values ;
  alpha = 0.05 ; df1=2  ; df2=30-3-1 ;
  f0 = finv(1-alpha, df1, df2) ;
  p = 1 - probf(1.98, df1, df2) ;
  put f0 =  ;
  put p = ;
run ; 


/**********************************************/
