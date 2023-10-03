
/**************************************************************************************/
/* 탐색적 데이터 분석(Exploratory Data Analysis)  - 모형 적합 전 -                                                  */
/* 모형 적합 전, 데이터 탐색의 목적으로 여러가지 그래프를 그려보거나  통계량을 확인할 수 있다.        */
/**************************************************************************************/


/* 사례 : Ancombe's Quartet */
/* infile 의 옵션에서 expandtabs는 공백이 큰 관측치를 구별해주는 역할을 한다. */
/* infile 의 옵션에서 firstobs=2는 파일 첫 번째 줄이 변수명을 포함하고 있는 경우에 사용한다. */
data quartet;
	infile"D:\Anscombe's_Data.txt" expandtabs firstobs=2 ;
	input y1 x1 y2 x2 y3 x3 y4 x4;
run;

proc plot data=quartet vpercent=50 hpercent=50 ;       /*  v = vertical axis(세로축)을 의미, h = horizontal axis(가로축)을 의미  */
	plot y1*x1 ; 	plot y2*x2 ; 	plot y3*x3 ; 	plot y4*x4 ;     /*  vpercent, hpercent는 하나의 그림의 전체화면에서의 비율을 설정      */
run;quit;
symbol1	color=red		interpol=none	value=dot    ;      /*  symbol 1은 관측치 사이를 통과하지 않고 점으로 표시                         */
symbol2	color=blue 	interpol=rl			value=none ;      /*  symbol 2는 관측치 사이를 회귀 적합선으로 통과.                               */
proc gplot data=quartet ;
	plot y1*x1=1 y1*x1=2 / overlay ;   /*  y1 vs x1 : 선형 관계(linear)                               */
	plot y2*x2=1 y1*x1=2 / overlay ;   /*  y2 vs x2 : 비 선형 관계(non-linear)                   */
	plot y3*x3=1 y1*x1=2 / overlay ;   /*  y3 vs x2 : 특이값(outlier)                                   */
	plot y4*x4=1 y1*x1=2 / overlay ;   /*  y4 vs x2 : 영향력 있는 관측치(influential point)   */
run;quit;


/* 사례 : Hamilton's Quartet */
/* infile 의 옵션에서 expandtabs는 공백이 큰 관측치를 구별해주는 역할을 한다. */
/* infile 의 옵션에서 firstobs=2는 파일 첫 번째 줄이 변수명을 포함하고 있는 경우에 사용한다. */
data hamilton ;
	infile"D:\hamilton's_Data.txt" expandtabs firstobs=2 ;
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
proc plot data=hamilton vpercent=50 hpercent=50 ;
	plot y*x1;	plot y*x2 ; 	
run;
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

