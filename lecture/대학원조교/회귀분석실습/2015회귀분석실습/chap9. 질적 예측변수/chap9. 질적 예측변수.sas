/*page 2*/
data salary;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap9. 질적 예측변수\salary.txt" expandtabs firstobs=2;
	input S X E M;
run;
proc print data=salary(obs=23);
run;
proc print data=salary(firstobs=24);
run;

/*page 3*/
data salary1;
	set salary;
	if E=1 then E1=1; else E1=0;
	if E=2 then E2=1; else E2=0;
run;

proc reg data=salary1 plots=none;
	model S=X E1 E2 M;
run;


/*page 4*/
proc reg data=salary1 noprint;
	model S=X E1 E2 M;
	output out=salary_out student=ri;
run;
quit;
data salary_out;
	set salary_out;
	if E=1 and M=0 then class=1;
	if E=1 and M=1 then class=2;
	if E=2 and M=0 then class=3;
	if E=2 and M=1 then class=4;
	if E=3 and M=0 then class=5;
	if E=3 and M=1 then class=6;
run;

symbol v=dot  h=1;
footnote h=2 "표준화잔차 vs 경력연수(X)";
proc gplot data=salary_out;
	plot ri*X=class;
run;

/*page 5*/
symbol v=dot h=1 c=black;
footnote h=2 "표준화잔차 vs 교육수준-관리의 조합";
proc gplot data=salary_out;
	plot ri*class;
run;
goption reset=all;


/*page 6*/
data salary2;
	set salary_out;
	E1M=E1*M;
	E2M=E2*M;
	drop ri;
run;
proc reg data=salary2 plots=none;
	model S=X E1 E2 M E1M E2M;
run;


/*page 7*/
proc reg data=salary2 noprint;
	model S=X E1 E2 M E1M E2M;
	output out=salary2_out student=ri;
run;
quit;


symbol v=dot h=1;
footnote h=2 "표준화잔차 vs 경력연수(X) : 확장된 모형";
proc gplot data=salary2_out;
	plot ri*X=class;
run;
goption reset=all;


/*page 8*/
proc reg data=salary2_out plots=none;
	where ri>-4;
	model S=X E1 E2 M E1M E2M;
run;


/*page 9*/
proc reg data=salary2_out noprint;
	where ri>-4;
	model S=X E1 E2 M E1M E2M;
	output out=salary3_out student=ri_33;
run;
quit;

symbol v=dot  h=1;
footnote h=2 "표준화잔차 vs 경력연수(X) : 확장된 모형, 관측개체 33 제외";
proc gplot data=salary3_out;
	plot ri_33*X=class;
run;
goption reset=all;


/*page 10*/
symbol v=dot h=1 c=black;
footnote h=2 "표준화잔차 vs 교육수준-관리의 조합 : 확장된 모형, 관측개체 33 제외";
proc gplot data=salary3_out;
	plot ri_33*class;
run;
goption reset=all;


/*page 11*/
data testing;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap9. 질적 예측변수\preemployment_testing.txt" expandtabs firstobs=2;
	input X Z Y;
	label X='TEST'
			Z='RACE'
			Y='JPERF';
run;

proc print data=testing(obs=10);
run;
proc print data=testing(firstobs=11);
run;

/*page 12*/
symbol i=r v=dot h=1;
proc gplot data=testing;
	plot Y*X=Z;
run;
goption reset=all;

/*page 13*/
data testing1;
	set testing;
	XZ=X*Z;
	label XZ='RACE*TEST';
run;

proc reg data=testing1 plots=none;
	model Y=X;
	output out=testing_out student=ri;
run;

proc reg data=testing1 plots=none;
	model Y=X Z XZ;
	output out=testing1_out student=ri;
	test Z=XZ=0;
run;

/*page 14*/
symbol v=dot  h=1;
footnote h=2 "표준화잔차 vs 검사점수 : 모형 1";
proc gplot data=testing_out;
	plot ri*X;
run;
symbol v=dot  h=1;
footnote h=2 "표준화잔차 vs 검사점수 : 모형 3";
proc gplot data=testing1_out;
	plot ri*X;
run;

/*page 15*/
symbol v=dot  h=1;
footnote h=2 "표준화잔차 vs 인종 : 모형 1";
proc gplot data=testing_out;
	plot ri*Z;
run;

/*page 16*/
symbol v=dot  h=1;
footnote h=2 "표준화잔차 vs 검사점수 : 모형 1, 소수민족만";
proc gplot data=testing_out;
	where Z=1;
	plot ri*X;
run;

symbol v=dot  h=1;
footnote h=2 "표준화잔차 vs 검사점수 : 모형 1, 소수민족만";
proc gplot data=testing_out;
	where Z=0;
	plot ri*X;
run;

goption reset=all;

/*page 17*/
proc reg data=testing1 plots=none;
	model Y=X Z;
	test Z=0;
run;

/*page 18*/
proc reg data=testing1 plots=none;
	model Y=X XZ;
	test XZ=0;
run;




/*page 19*/
data ski;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap9. 질적 예측변수\ski_sales.txt" expandtabs firstobs=2 ;
	input Quarter $ Date Sales PDI;
run;
proc print data=ski(obs=20);
run;
proc print data=ski(firstobs=21);
run;


/*page 20*/
/*plot을 통한 데이터 탐색*/
goption reset=all;
symbol value=dot interpol=r;
proc gplot data=ski;
	plot Sales*PDI;
run;

goption reset=all;
symbol value=dot interpol=r;    
proc gplot data=ski;                         
	plot  Sales*PDI=Quarter;
run ;


/*page 21*/
/*계절성의 특성을 지우는 dummy변수 생성*/
data ski1;
	set ski;
	if Quarter="Q1" then Q1=1; else Q1=0;     
	if Quarter="Q2" then Q2=1; else Q2=0;   
	if Quarter="Q3" then Q3=1; else Q3=0;
run;
proc reg data=ski1 plots=none;
	model Sales = PDI Q1 Q2 Q3;   /* Q1이 유의하지 않으므로 모형에서 제거 */
run;

proc reg data=ski1 plots=none;
	model Sales = PDI Q2 Q3 / r;
	output out=ski_out Student=ri;
run;
quit;

/*page 22*/
goption reset=all;
symbol v=dot h=1;
proc gplot data=ski_out;
	plot ri*PDI=Quarter;
    plot ri*Q2;
	plot ri*Q3;
run;

/*page 23*/
/* Q2와 Q3의 회귀계수가 거의 같으므로, 지시변수를 줄이는 것이 나아보인다.*/
data ski2;
	set ski1;
	if Quarter = "Q2" or Quarter = "Q3"  then Q23=1 ; else Q23=0 ;     
run ;

/*수정된 지시변수를 이용한 모형 적합 및 검토 */
proc reg data=ski2 plots=none;
	model Sales = PDI Q23;             /* MSE가 조금 더 줄어들고, adj-R square가 소폭 상승함.*/
	output out=ski2_out Student=ri;
run;
quit;

/* 그룹 별 산점도 */
goption reset=all;
symbol value=dot interpol=r;
proc gplot data=ski2;
	plot Sales*PDI=Q23;
run;

/*page 24*/
goption reset=all;
symbol v=dot h=1;
proc gplot data=ski2_out;
	plot ri*PDI;
    plot ri*Q23;
run;



