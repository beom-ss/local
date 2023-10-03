
/*************************************************************************************************************************************/
/* 사례 : 급료조사 데이터 (Salary Survey) */
/*************************************************************************************************************************************/
/*데이터 입력*/
data salary ;
	infile "D:\salary_survey.txt" expandtabs firstobs=2 ;
	input S X E M ;
run ;

/*산점도*/
goption reset=all ;                           
symbol value=dot interpol=r ;          
proc gplot data= salary  ;                         
	plot  S*X ;
run ; quit ;

/* 그룹 별 산점도 */
data salary ;
	set salary ;
	if E=1 and M=0  then class=1 ;   
	if E=1 and M=1  then class=2 ;
	if E=2 and M=0  then class=3 ;
	if E=2 and M=1  then class=4 ;
	if E=3 and M=0  then class=5 ;
	if E=3 and M=1  then class=6 ;
run ;

goption reset=all ;                           
symbol value=dot interpol=r ;          
proc gplot data= salary  ;                         
	plot  S*X = class ;
run ; quit ;

data salary;
	set salary;
	if E = 1 then E1=1 ; else E1=0 ;     
	if E = 2 then E2=1 ; else E2=0 ;    
run;
proc reg data=salary ;
	model S = X E1 E2 M / r;
	output out=salary_stat Student=ri ;
quit ;
goption reset=all ;                                      
symbol value=dot ;                  
proc gplot data=salary_stat ;                         
	plot  ri*X=class ;  
    plot  ri*class=class ;  
run ; quit ;


data salary ;
	set salary ;
	E1M=E1*M ;
	E2M=E2*M ;
run ;
proc reg data=salary ;
	model S = X E1 E2 M E1M E2M / r ;
	output out=salary_stat Rstudent=ri ;
quit ;
goption reset=all ;                                   
symbol value=dot  ;                
proc gplot data=salary_stat ;                         
	plot  ri*X=class ;  
    plot  ri*class=class ;  
run ; quit ;

data salary;
	set salary;
	obs_num = _N_;
run;
proc reg data=salary ;
	model S = X E1 E2 M E1M E2M / r;
	where obs_num^=33 ;
	output out = salary_stat_33 Student=ri ;
quit ;
goption reset=all ;                               
symbol value=dot ;             
proc gplot data=salary_stat_33 ;                         
	plot  ri*X=class ;  
    plot  ri*class=class ; 
run ; quit ;
/*************************************************************************************************************************************/



/*************************************************************************************************************************************/
/* 사례 : 고용 전 검사 데이터 (Preemployment Testing) */
/*************************************************************************************************************************************/
/*데이터 입력*/
data test ;
	infile "D:\preemployment_testing.txt" expandtabs firstobs=2 ;
	input TEST RACE JPERF ;
run ;

/*산점도*/
goption reset=all ;
symbol value=dot interpol=r ;      
proc gplot data= test  ;                         
	plot  JPERF * TEST ;
run ; quit ;
/* 그룹 별 산점도 */
goption reset=all ;
symbol value=dot interpol=r ;      
proc gplot data= test  ;                         
	plot  JPERF * TEST = RACE  ;
run ; quit ;

data test ;
	set test ;
	TEST_RACE = TEST*RACE ; 
run ;
proc reg data=test ;        
	model JPERF = TEST RACE TEST_RACE / r ;
	test RACE = TEST_RACE = 0 ;
	output out=test_stat Student=ri ;
quit;
goption reset=all ;                                      
symbol value=dot ;                    
proc gplot data=test_stat ;                         
	plot ri * TEST = RACE  ;  
    plot ri * RACE = RACE ;
	plot ri * TEST_RACE = RACE  ;
run ; quit ;

proc reg data=test ;         
	model JPERF = TEST RACE / r ;
	test RACE = 0 ;
	output out=test_stat Student=ri ;
quit;
goption reset=all ;                                      
symbol value=dot ;                    
proc gplot data=test_stat ;                         
	plot ri * TEST = RACE  ;  
    plot ri * RACE = RACE ;
run ; quit ;

proc reg data=test ;         
	model JPERF = TEST TEST_RACE / r  ;            
	test TEST_RACE = 0 ;
	output out=test_stat Student=ri ;
quit;
goption reset=all ;                                      
symbol value=dot ;              
proc gplot data=test_stat ;                         
	plot ri * TEST = RACE ; 
    plot ri * TEST_RACE = RACE ;
run ; quit ;
/*************************************************************************************************************************************/



/*************************************************************************************************************************************/
/* 연습문제 5-5  : 옥수수 생산량 데이터 */
/*************************************************************************************************************************************/
/*데이터 입력*/
data corn;
	infile "D:\corn_yeild.txt" expandtabs firstobs=2 ;
	input yield fertilizer;
run;

/*(a)*/
data corn ;   
	set corn;
	if fertilizer=1 then F1=1; else F1=0;
	if fertilizer=2 then F2=1; else F2=0;
	if fertilizer=3 then F3=1; else F3=0;
run;

/*(b)*/
proc reg data=corn ;
	model yield = F1 F2 F3 ; 
quit;

/*(c)*/
proc reg data=corn ;
	model yield = F1 F2 F3 ;
	test F1=F2=F3=0 ;
quit;

/*(d)*/
data corn ;
	set corn ;
	if fertilizer in (1,2,3) then F=1; 
    else F=0;
run;
proc reg data=corn ;
	model yield = F ;
	test F=0;
quit;

proc anova data=corn ;
   class fertilizer ;
   model yield = fertilizer ;
   means fertilizer / tukey lines;
run; quit;
/*************************************************************************************************************************************/



/*************************************************************************************************************************************/
/* 연습문제 5-3  : 스키 판매량 데이터 */
/*************************************************************************************************************************************/
/*데이터 입력*/
data ski;
	infile "D:\ski_sales.txt" expandtabs firstobs=2 ;
	input Quarter $ Date Sales PDI;
run;

/*산점도*/
goption reset=all ;
symbol value=dot interpol=r ;    
proc gplot data=ski  ;                         
	plot  Sales*PDI ;
run ; quit ;
/* 그룹 별 산점도 */
goption reset=all ;
symbol value=dot interpol=r ;    
proc gplot data=ski  ;                         
	plot  Sales*PDI=Quarter  ;
run ; quit ;

/*지시변수를 추가한 모형 적합 및 검토 */
data ski ;
	set ski ;
	if Quarter = "Q1" then Q1=1 ; else Q1=0 ;     
	if Quarter = "Q2" then Q2=1 ; else Q2=0 ;   
	if Quarter = "Q3" then Q3=1 ; else Q3=0 ;
run ;
proc reg data=ski ;
	model Sales = PDI Q1 Q2 Q3 ;  
quit ;
proc reg data=ski ;
	model Sales = PDI Q2 Q3 / r;
	output out=ski_stat Student=ri ;
quit ; 
goption reset=all ;                                      
symbol value=dot ;                    
proc gplot data=ski_stat ;                         
	plot ri * PDI = Quarter ;  
    plot ri * Quarter = Quarter ;
run ; quit ;

data ski ;
	set ski ;
	if Quarter = "Q2" or Quarter = "Q3"  then Q23=1 ; else Q23=0 ;     
run ;
/* 그룹 별 산점도 */
goption reset=all ;
symbol value=dot interpol=r ;    
proc gplot data=ski  ;                         
	plot  Sales*PDI=Q23  ;
run ; quit ;

proc reg data=ski ;
	model Sales = PDI Q23 / r ; 
	output out=ski_stat Student=ri ;
quit;  
goption reset=all ;                                      
symbol value=dot ;                    
proc gplot data=ski_stat ;                         
	plot ri * PDI = Q23 ;
    plot ri * Q23 = Q23 ;
run ; quit ;
/*************************************************************************************************************************************/



/*************************************************************************************************************************************/
/* 연습문제 5-6  : 학생 개인정보 데이터 */
/*************************************************************************************************************************************/
/*데이터 입력*/
data class ;
	infile "D:\class_data.txt" expandtabs firstobs=2 ;
	input Age	Height	Weight	Sex ;
run;

/*산점도*/
goption reset=all ;
symbol value=dot interpol=r ;      
proc gplot data=class  ;                         
	plot  Weight*Height ;
    plot  Weight*Age ;
run ; quit ;
/*그룹별 산점도*/
goption reset=all ;
symbol value=dot interpol=r ;      
proc gplot data=class  ;                         
	plot  Weight*Height=Sex  ;
	plot  Weight*Age=Sex  ; 
run ; quit ;     

data class ;
	set class ;
	HS = Sex*Height   ;
run ;
proc reg data=class ;
	model Weight = Age Height Sex  HS  ;
quit ;    
proc reg data=class ;
	model Weight = Height Sex HS ;
quit ;  
proc reg data=class ;
	model Weight = Height Sex / r ;
	output out=class_stat Student=ri p=yhat ;
quit ; 
data class_stat ;
	set class_stat ;
	obs_num = _N_ ;
run ;

goption reset=all ;                                      
symbol value=dot ;                    
proc gplot data=class_stat ;                         
	plot ri * Height  = Sex ;
    plot ri * Sex = Sex ;    
	plot ri * yhat = Sex ;
	plot ri * obs = Sex ;     
run ; quit ;    


proc sql ;
	create table class_female as 
	select * 
	from class
	where Sex=1 ;
quit ;
proc sql ;
	create table class_male as 
	select * 
	from class
	where Sex=0 ;
quit ;

/*산점도 - 여성 - */
goption reset=all ;
symbol value=dot interpol=r ;      
proc gplot data=class_female  ;                         
	plot  Weight*Height  ;
    plot  Weight*Age  ;
run ; quit ;     
/*모형적합 - 여성 - */
proc reg data=class_female;
	model Weight = Height Age;
quit ;

/*산점도 - 남성 - */
goption reset=all ;
symbol value=dot interpol=r ;      
proc gplot data=class_male  ;                         
	plot  Weight*Height  ;
	plot  Weight*Age  ;
run ; quit ;    
/*모형적합 - 남성 - */
proc reg data=class_male ;
	model Weight = Height Age ;
quit ;

/*************************************************************************************************************************************/

