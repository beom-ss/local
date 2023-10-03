
/**************************************************************************************/
/* 탐색적 데이터 분석(Exploratory Data Analysis)  - 모형 적합 전 -                                                  */
/* 모형 적합 전, 데이터 탐색의 목적으로 여러가지 그래프를 그려보거나  통계량을 확인할 수 있다.        */
/**************************************************************************************/


/* 사례 : Ancombe's Quartet */
/* infile 의 옵션에서 expandtabs는 공백이 큰 관측치를 구별해주는 역할을 한다. */
/* infile 의 옵션에서 firstobs=2는 파일 첫 번째 줄이 변수명을 포함하고 있는 경우에 사용한다. */

data quartet;
	infile"C:\Users\kuksunghee\Desktop\Anscombe's_Data.txt" expandtabs firstobs=2 ;
	input y1 x1 y2 x2 y3 x3 y4 x4;
run;

proc plot data=quartet vpercent=33 hpercent=50 ;       /*  v = vertical axis(세로축)을 의미, h = horizontal axis(가로축)을 의미  */
	plot y1*x1 ; 	plot y2*x2 ; 	plot y3*x3 ; 	plot y4*x4 ;     /*  vpercent, hpercent는 하나의 그림의 전체화면에서의 비율을 설정      */
run;quit;


symbol1	color=red		i=none	v=dot    ;      	/*  symbol 1은 관측치 사이를 통과하지 않고 점으로 표시                         */
symbol2	color=blue 	i=rl			v=none ;    /*  symbol 2는 관측치 사이를 회귀 적합선으로 통과.                               */
proc gplot data=quartet ;
	plot y1*x1=1 y1*x1=2 / overlay ;  	/*  y1 vs x1 : 선형 관계(linear)                               */
	plot y2*x2=1 y2*x2=2 / overlay ;  	/*  y2 vs x2 : 비 선형 관계(non-linear)                   */
	plot y3*x3=1 y3*x3=2 / overlay ;   /*  y3 vs x2 : 특이값(outlier)                                   */
	plot y4*x4=1 y4*x4=2 / overlay ;   /*  y4 vs x2 : 영향력 있는 관측치(influential point)   */
run;quit;



/* 사례 : Hamilton's Quartet */
/* infile 의 옵션에서 expandtabs는 공백이 큰 관측치를 구별해주는 역할을 한다. */
/* infile 의 옵션에서 firstobs=2는 파일 첫 번째 줄이 변수명을 포함하고 있는 경우에 사용한다. */


data hamilton ;
	infile"C:\Users\kuksunghee\Desktop\hamilton's_Data.txt" expandtabs firstobs=2 ;
	input y	x1	x2 ;
run;

/* 1. proc insight 기능을 이용하는 방법 */


proc insight data=hamilton;
run;

/* 2. proc univariate 기능을 이용하는 방법 */

proc univariate data=hamilton normal plot ;
	var y x1 x2 ;
	histogram;
run;

/* Plot Matrix */


proc sgscatter data=hamilton ;
  matrix y x1 x2 ;
run;



/* 3D Plot */
proc g3d data=hamilton ;
	scatter x1 * x2 = y /
	shape="balloon" ;
run;

/* 3D plot with surface */
/* First, create the grid data */
/* Then, plot the Surface */

proc g3grid data=hamilton out=a;
  grid x1 * x2 = y / 
    axis1=30 to 80 by 5
    axis2=30 to 80 by 5 ;
run;
proc g3d data=a ;
  plot x1 * x2 = y ;
run;

/* We can adjust the detail in the grid */
proc g3grid data=hamilton out=b;
  grid x1 * x2 = y / 
  axis1=30 to 80 by 1
  axis2=30 to 80 by 1 ;
run;
proc g3d data=b ;
  plot x1 * x2 = y ;
run;

/* It can be helpful to view at different angles */

proc g3d data=b ;
  plot x1 * x2 = y /
  rotate=45 tilt=80 ;
run;
proc g3d data=b ;
  plot x1 * x2 = y /
  rotate=30 tilt=20 ;
run;
proc g3d data=b ;
  plot x1 * x2 = y /
  rotate=45 tilt=60 ;
run;


/* y 대 x1, y대 x2, x1 대 x2에서는 아무런 선형관계가 보이지 않음. */
/* 그러나  y 대 x1, x2 에서는 거의 완벽한 적합결과를 보임. */
proc plot data=hamilton vpercent=33 hpercent=50 ;
	plot y*x1;	plot y*x2 ; 	
run;

symbol1	color=red		i=none	v=dot    ;      /*  symbol 1은 관측치 사이를 통과하지 않고 점으로 표시                         */
symbol2	color=blue 	i=rl			v=none ;      /*  symbol 2는 관측치 사이를 회귀 적합선으로 통과.                               */
proc gplot data=hamilton ;
	plot y*x1=1 y*x1=2 / overlay ;   
	plot y *x2=1 y*x2=2 / overlay ; 
run;quit;


proc reg data=hamilton ;
	model y = x1 ;
	plot y * x1;
run;
proc reg data=hamilton ;
	model y = x2 ;
    plot y * x2;
run;
proc reg data=hamilton ;
	model y = x1 x2 ;
run;

/* 3D plot을 이용해서, 변수가 3개까지인 경우에 한하여 적합평면을 자세히 볼 수 있다. */
proc g3grid data=hamilton out=b;
  grid x1 * x2 = y / 
  axis1=30 to 80 by 1
  axis2=30 to 80 by 1 ;
run;
proc g3d data=b ;
  plot x1 * x2 = y ;
run;
proc insight data=hamilton;
run;


/**************************************************************************************/
/************************************************************************************************************************/
/*  잔차검정(residual checking)  - 모형 적합 후 -                                                                                                                                        */
/*  오차를 직접 이용하지 못하므로, 오차의 추정량인 잔차가 오차의 가정을 잘 만족하는지를 살펴본다.                                                              */
/*  잔차를 이용하여  여러가지 그래프를 그려보거나  통계량을 확인함으로써 이를 판단한다.                                                                             */
/*  또한 모형 적합 결과에 과도한 영향을 미치는 일부 관측치에 대해 관측하고, 유사시 제거함으로써 모형을 개선할 수도 있다.                            */
/************************************************************************************************************************/


/************************************************************************************************************************/

/* 사례 : NewYork River */

/***********************************************************************************************************************/


/*데이터 입력 : 문자변수의 문장에 공백이 섞여 있으므로, infile문에서 이를 해결하기는 쉽지 않다.*/
/***********************************************************************************************************************/

/*해결방법 1*/
/*txt파일을 직접 수정한다. 즉, 문자변수 내 공백을 없애거나 _로 바꿔준다.*/

data river ;
	infile"C:\Users\kuksunghee\Desktop\NewYork_River_adjust.txt"  expandtabs firstobs=2 ;
	length river $ 15 ;
	input river $ x1 -x4 y ;
run ;


/*하지만 이 방법은 관측치 수가 매우 많을 때는 써먹을 수 없다는 단점이 있다.*/

/*해결방법 2*/
/*이는 좀 더 개선된 방법으로, 관측치 수가 매우 많을 때에도 써먹을 수 있는 방법이다.*/
/*txt파일을 엑셀에서 불러와서, 엑셀파일(xlsx)이나 csv파일로 저장한다.*/


proc import datafile="D:\NewYork_River.xls"  out=river_A  dbms=xls  replace  ;
	getnames=yes ;    																										  /*첫번째 행이 변수명인 경우, getnames=yes*/
run;

proc import datafile="D:\NewYork_River01.xls"  out=river_AA dbms=xls  replace;
	getnames=no ;     																											 /*첫번째 행이 변수명이 아닌  경우, getnames=no*/
run;                  /* 이 경우, 데이터 셋에 들어가는 변수명이 자동으로 할당되므로, 바꿔주야 함 */


data river_AAA_1;                                               								/* 변수명 바꿔주기 (방법1) */
	set river_AA;
	rename var1=river var2=x1 var3=x2 var4=x3 var5=x4 var6=y;     	 /* 이 경우, 변수명은 바뀌지만, 변수의 레이블은 기존의 변수명이 된다.*/
run;


proc reg data=river_AAA_1 ; model y = x1; run;  						


																											/* parameter estimates결과에 각 변수의 레이블이 표시됨. */
proc sql ;                                                            																/* 변수명 바꿔주기 (방법2) */
	create table river_AAA_2 as                             																	 /* 이 경우에도, 변수명은 바뀌지만, 변수의 레이블은 기존의 변수명이 된다.*/
	select var1 as river, var2 as x1, var3 as x2, var4 as x3, var5 as x4, var6 as y
	from river_AA ;
quit ;
/*따라서 엑셀에서 데이터를 불러올 때, 미리 변수명을 작성해두면 번거로운 작업을 할 필요가 없어진다.*/

proc import datafile="D:\NewYork_River.xlsx"  out=river_B  dbms=xlsx  replace  ;  /*SAS 9.3부터는 xlsx도 사용가능함.*/
	getnames=no;      /*첫번째 행이 변수명인 경우, getnames=yes*/
run;
proc import datafile="D:\NewYork_River.csv"   out=river_C  dbms=csv  replace  ;
	getnames=no;      /*첫번째 행이 변수명인 경우, getnames=yes*/
run;
/*이러한 import 기능은 SAS 메뉴에서 직접 클릭하여 사용할 수도 있다.*/


/*일부 관측치를 제외할 때, 회귀계수의 변화를 살펴보자.*/
/***********************************************************************************************************************/

proc reg data=river;
	model y= x1 x2  x3 x4;
run;

/*4번째 관측치 "Neversink"를 제외*/
proc sql ;
	create table river_delete_04_a as 
    select * 
	from river
    where river ^= "Neversink" ;
quit;
/*proc sql ;*/
/*   delete from river*/
/*      where river = "Neversink" ;*/
/*quit;*/
data river_delete_04_b ;
	set river ;
	if river="Neversink" then delete ;
run;

proc reg data=river_delete_04_b;
	model y= x1 x2  x3 x4;
run;


/*5번째 관측치 "Hackensack"를 제외*/
proc sql ;
	create table river_delete_05_a as 
    select * 
	from river
    where river ^= "Hackensack" ;
quit;
/*proc sql ;*/
/*   delete from river*/
/*      where river = "Hackensack" ;*/
/*quit;*/
data river_delete_05_b  ;
	set river ;
	if river="Hackensack" then delete ;
run;

proc reg data=river_delete_05_b;
	model y= x1 x2  x3 x4;
run;

/*4번째 관측치 "Neversink"와 5번째 관측치 "Hackensack"를 동시에 제외*/
proc sql ;
	create table river_delete_04_05_a as 
    select * 
	from river
    where river ^= "Neversink"  and river ^= "Hackensack"   ;
quit;
proc sql ;
	create table river_delete_04_05_b as 
    select * 
	from river
    where river not in ("Neversink", "Hackensack" )  ;
quit;
data river_delete_04_05_c  ;
	set river ;
	if river="Neversink" or river="Hackensack" then delete ;
run;
proc reg data=river_delete_04_05_b;
	model y= x1 x2  x3 x4/vif;
run;

/*일부 관측치를 뺌으로써, 회귀계수가 크게 변화함.*/
proc reg data=river ;
	model y = x1 x2 x3 x4 ;
quit ;
proc reg data=river_delete_04_a ;
	model y = x1 x2 x3 x4 ;
quit ;
proc reg data=river_delete_05_a ;
	model y = x1 x2 x3 x4 ;
quit ;
proc reg data=river_delete_04_05_a ;
	model y = x1 x2 x3 x4 ;
quit ;
