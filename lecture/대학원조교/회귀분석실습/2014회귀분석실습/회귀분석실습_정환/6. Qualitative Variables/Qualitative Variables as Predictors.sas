
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
	if E=1 and M=0  then class=1 ;     /* 6가지 그룹을 구별하기 위해 class란 변수를 만들고, 1~6까지 범주에 대한 번호를 매김. */
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

/*지시변수를 추가한 모형 적합 및 검토 */
data salary;
	set salary;
	if E = 1 then E1=1 ; else E1=0 ;     /* E=1인 경우 */
	if E = 2 then E2=1 ; else E2=0 ;     /* E=2인 경우 */
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
/*그룹 별 패턴이 여전히 남아있음을 확인할 수 있음*/

/*interaction effect 추가한 모형 적합 및 검토*/
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
/*33번째 관측치는 특이값으로 보임.*/

/*33번 관측치 제거 후 모형 적합 및 검토*/
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
/*더이상 문제점이 발견되지 않는 것 같다.*/
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

/* (1). 다른 기울기 & 다른 절편을 가지는 모형 적합 및 검토 */
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

/* (2). 동일한 기울기 & 다른 절편을 가지는 모형 적합 및 검토 */
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

/* (3). 다른 기울기 & 같은 절편을 가지는 모형 적합 및 검토 */
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

/*one-way ANOVA와 비교*/
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
	model Sales = PDI Q1 Q2 Q3 ;   /* Q1이 유의하지 않으므로 모형에서 제거 */
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

/*그러나 Q2와 Q3의 회귀계수가 거의 같으므로, 지시변수를 줄이는 것이 나아보인다.*/
/*또한 이는 그룹별 산점도에서 2개의 그룹으로 구분되는 것과 의미가 상통한다*/
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
/*수정된 지시변수를 이용한 모형 적합 및 검토 */
proc reg data=ski ;
	model Sales = PDI Q23 / r ; /* MSE가 조금 더 줄어들고, adj-R square가 소폭 상승함.*/
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

/*interaction term을 고려한 모형 적합 및 검토*/
data class ;
	set class ;
	HS = Sex*Height   ;
run ;
proc reg data=class ;
	model Weight = Age Height Sex  HS  ;
quit ;     /* 가장 유의하지 않은 Age를 제거 */
proc reg data=class ;
	model Weight = Height Sex HS ;
quit ;    /* 다음으로 유의하지 않은 HS를 제거 */
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
	plot ri * obs = Sex ;       /*27번 관측치만 제외하면, 남녀 간의 오차 분산이 꽤 다를 것으로 보인다. */
run ; quit ;    
/* 모형은 남성/여성 구별없이 기울기는 동일하다고 보고 있다. 조금 신뢰하기 어려운 모형이다. */
/* 사실 이 자료는 남녀 그룹 간의 오차의 분산이 같지 않다. */
/* 따라서 오차의 분산이 같다고 가정하고 하나의 모형으로 표현한 위의 결과가 만족스럽지 않은 것이다. */

/* 남성과 여성에 대한 데이터를 분리하여 각각 모형을 적합 */
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

/*즉, 여성의 경우, Height가 Weight에 대해 유의하지만, 남성의 경우는 그렇지 않다. */
/*성별에 따라 Height이 유의하거나 유의하지 않기 때문에, 통합모형의 결과가 그리 썩 좋지 않은 것으로 해석된다. */
/*차라리 통합모형을 사용하는 것보다 남녀로 데이터를 나누어 분석하는 것이 더 나을지도 모른다.*/
/*어쨌든 Age는 어느 모형에서도 유의한 효과를 보이지는 않는 것 같다.*/
/*************************************************************************************************************************************/

