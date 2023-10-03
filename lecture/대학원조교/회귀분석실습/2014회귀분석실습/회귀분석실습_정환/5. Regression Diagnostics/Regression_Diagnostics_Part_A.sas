
/**************************************************************************************/
/* Ž���� ������ �м�(Exploratory Data Analysis)  - ���� ���� �� -                                                  */
/* ���� ���� ��, ������ Ž���� �������� �������� �׷����� �׷����ų�  ��跮�� Ȯ���� �� �ִ�.        */
/**************************************************************************************/


/* ��� : Ancombe's Quartet */
/* infile �� �ɼǿ��� expandtabs�� ������ ū ����ġ�� �������ִ� ������ �Ѵ�. */
/* infile �� �ɼǿ��� firstobs=2�� ���� ù ��° ���� �������� �����ϰ� �ִ� ��쿡 ����Ѵ�. */
data quartet;
	infile"D:\Anscombe's_Data.txt" expandtabs firstobs=2 ;
	input y1 x1 y2 x2 y3 x3 y4 x4;
run;

proc plot data=quartet vpercent=50 hpercent=50 ;       /*  v = vertical axis(������)�� �ǹ�, h = horizontal axis(������)�� �ǹ�  */
	plot y1*x1 ; 	plot y2*x2 ; 	plot y3*x3 ; 	plot y4*x4 ;     /*  vpercent, hpercent�� �ϳ��� �׸��� ��üȭ�鿡���� ������ ����      */
run;quit;
symbol1	color=red		interpol=none	value=dot    ;      /*  symbol 1�� ����ġ ���̸� ������� �ʰ� ������ ǥ��                         */
symbol2	color=blue 	interpol=rl			value=none ;      /*  symbol 2�� ����ġ ���̸� ȸ�� ���ռ����� ���.                               */
proc gplot data=quartet ;
	plot y1*x1=1 y1*x1=2 / overlay ;   /*  y1 vs x1 : ���� ����(linear)                               */
	plot y2*x2=1 y1*x1=2 / overlay ;   /*  y2 vs x2 : �� ���� ����(non-linear)                   */
	plot y3*x3=1 y1*x1=2 / overlay ;   /*  y3 vs x2 : Ư�̰�(outlier)                                   */
	plot y4*x4=1 y1*x1=2 / overlay ;   /*  y4 vs x2 : ����� �ִ� ����ġ(influential point)   */
run;quit;


/* ��� : Hamilton's Quartet */
/* infile �� �ɼǿ��� expandtabs�� ������ ū ����ġ�� �������ִ� ������ �Ѵ�. */
/* infile �� �ɼǿ��� firstobs=2�� ���� ù ��° ���� �������� �����ϰ� �ִ� ��쿡 ����Ѵ�. */
data hamilton ;
	infile"D:\hamilton's_Data.txt" expandtabs firstobs=2 ;
	input y	x1	x2 ;
run;

/* 1. proc insight ����� �̿��ϴ� ��� */
proc insight data=hamilton;
run;

/* 2. proc univariate ����� �̿��ϴ� ��� */
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

/* y �� x1, y�� x2, x1 �� x2������ �ƹ��� �������谡 ������ ����. */
/* �׷���  y �� x1, x2 ������ ���� �Ϻ��� ���հ���� ����. */
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

/* 3D plot�� �̿��ؼ�, ������ 3�������� ��쿡 ���Ͽ� ��������� �ڼ��� �� �� �ִ�. */
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

