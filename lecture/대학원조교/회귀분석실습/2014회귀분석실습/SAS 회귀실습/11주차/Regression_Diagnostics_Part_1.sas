
/**************************************************************************************/
/* Ž���� ������ �м�(Exploratory Data Analysis)  - ���� ���� �� -                                                  */
/* ���� ���� ��, ������ Ž���� �������� �������� �׷����� �׷����ų�  ��跮�� Ȯ���� �� �ִ�.        */
/**************************************************************************************/


/* ��� : Ancombe's Quartet */
/* infile �� �ɼǿ��� expandtabs�� ������ ū ����ġ�� �������ִ� ������ �Ѵ�. */
/* infile �� �ɼǿ��� firstobs=2�� ���� ù ��° ���� �������� �����ϰ� �ִ� ��쿡 ����Ѵ�. */

data quartet;
	infile"C:\Users\kuksunghee\Desktop\Anscombe's_Data.txt" expandtabs firstobs=2 ;
	input y1 x1 y2 x2 y3 x3 y4 x4;
run;

proc plot data=quartet vpercent=33 hpercent=50 ;       /*  v = vertical axis(������)�� �ǹ�, h = horizontal axis(������)�� �ǹ�  */
	plot y1*x1 ; 	plot y2*x2 ; 	plot y3*x3 ; 	plot y4*x4 ;     /*  vpercent, hpercent�� �ϳ��� �׸��� ��üȭ�鿡���� ������ ����      */
run;quit;


symbol1	color=red		i=none	v=dot    ;      	/*  symbol 1�� ����ġ ���̸� ������� �ʰ� ������ ǥ��                         */
symbol2	color=blue 	i=rl			v=none ;    /*  symbol 2�� ����ġ ���̸� ȸ�� ���ռ����� ���.                               */
proc gplot data=quartet ;
	plot y1*x1=1 y1*x1=2 / overlay ;  	/*  y1 vs x1 : ���� ����(linear)                               */
	plot y2*x2=1 y2*x2=2 / overlay ;  	/*  y2 vs x2 : �� ���� ����(non-linear)                   */
	plot y3*x3=1 y3*x3=2 / overlay ;   /*  y3 vs x2 : Ư�̰�(outlier)                                   */
	plot y4*x4=1 y4*x4=2 / overlay ;   /*  y4 vs x2 : ����� �ִ� ����ġ(influential point)   */
run;quit;



/* ��� : Hamilton's Quartet */
/* infile �� �ɼǿ��� expandtabs�� ������ ū ����ġ�� �������ִ� ������ �Ѵ�. */
/* infile �� �ɼǿ��� firstobs=2�� ���� ù ��° ���� �������� �����ϰ� �ִ� ��쿡 ����Ѵ�. */


data hamilton ;
	infile"C:\Users\kuksunghee\Desktop\hamilton's_Data.txt" expandtabs firstobs=2 ;
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
proc plot data=hamilton vpercent=33 hpercent=50 ;
	plot y*x1;	plot y*x2 ; 	
run;

symbol1	color=red		i=none	v=dot    ;      /*  symbol 1�� ����ġ ���̸� ������� �ʰ� ������ ǥ��                         */
symbol2	color=blue 	i=rl			v=none ;      /*  symbol 2�� ����ġ ���̸� ȸ�� ���ռ����� ���.                               */
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
/************************************************************************************************************************/
/*  ��������(residual checking)  - ���� ���� �� -                                                                                                                                        */
/*  ������ ���� �̿����� ���ϹǷ�, ������ �������� ������ ������ ������ �� �����ϴ����� ���캻��.                                                              */
/*  ������ �̿��Ͽ�  �������� �׷����� �׷����ų�  ��跮�� Ȯ�������ν� �̸� �Ǵ��Ѵ�.                                                                             */
/*  ���� ���� ���� ����� ������ ������ ��ġ�� �Ϻ� ����ġ�� ���� �����ϰ�, ����� ���������ν� ������ ������ ���� �ִ�.                            */
/************************************************************************************************************************/


/************************************************************************************************************************/

/* ��� : NewYork River */

/***********************************************************************************************************************/


/*������ �Է� : ���ں����� ���忡 ������ ���� �����Ƿ�, infile������ �̸� �ذ��ϱ�� ���� �ʴ�.*/
/***********************************************************************************************************************/

/*�ذ��� 1*/
/*txt������ ���� �����Ѵ�. ��, ���ں��� �� ������ ���ְų� _�� �ٲ��ش�.*/

data river ;
	infile"C:\Users\kuksunghee\Desktop\NewYork_River_adjust.txt"  expandtabs firstobs=2 ;
	length river $ 15 ;
	input river $ x1 -x4 y ;
run ;


/*������ �� ����� ����ġ ���� �ſ� ���� ���� ����� �� ���ٴ� ������ �ִ�.*/

/*�ذ��� 2*/
/*�̴� �� �� ������ �������, ����ġ ���� �ſ� ���� ������ ����� �� �ִ� ����̴�.*/
/*txt������ �������� �ҷ��ͼ�, ��������(xlsx)�̳� csv���Ϸ� �����Ѵ�.*/


proc import datafile="D:\NewYork_River.xls"  out=river_A  dbms=xls  replace  ;
	getnames=yes ;    																										  /*ù��° ���� �������� ���, getnames=yes*/
run;

proc import datafile="D:\NewYork_River01.xls"  out=river_AA dbms=xls  replace;
	getnames=no ;     																											 /*ù��° ���� �������� �ƴ�  ���, getnames=no*/
run;                  /* �� ���, ������ �¿� ���� �������� �ڵ����� �Ҵ�ǹǷ�, �ٲ��־� �� */


data river_AAA_1;                                               								/* ������ �ٲ��ֱ� (���1) */
	set river_AA;
	rename var1=river var2=x1 var3=x2 var4=x3 var5=x4 var6=y;     	 /* �� ���, �������� �ٲ�����, ������ ���̺��� ������ �������� �ȴ�.*/
run;


proc reg data=river_AAA_1 ; model y = x1; run;  						


																											/* parameter estimates����� �� ������ ���̺��� ǥ�õ�. */
proc sql ;                                                            																/* ������ �ٲ��ֱ� (���2) */
	create table river_AAA_2 as                             																	 /* �� ��쿡��, �������� �ٲ�����, ������ ���̺��� ������ �������� �ȴ�.*/
	select var1 as river, var2 as x1, var3 as x2, var4 as x3, var5 as x4, var6 as y
	from river_AA ;
quit ;
/*���� �������� �����͸� �ҷ��� ��, �̸� �������� �ۼ��صθ� ���ŷο� �۾��� �� �ʿ䰡 ��������.*/

proc import datafile="D:\NewYork_River.xlsx"  out=river_B  dbms=xlsx  replace  ;  /*SAS 9.3���ʹ� xlsx�� ��밡����.*/
	getnames=no;      /*ù��° ���� �������� ���, getnames=yes*/
run;
proc import datafile="D:\NewYork_River.csv"   out=river_C  dbms=csv  replace  ;
	getnames=no;      /*ù��° ���� �������� ���, getnames=yes*/
run;
/*�̷��� import ����� SAS �޴����� ���� Ŭ���Ͽ� ����� ���� �ִ�.*/


/*�Ϻ� ����ġ�� ������ ��, ȸ�Ͱ���� ��ȭ�� ���캸��.*/
/***********************************************************************************************************************/

proc reg data=river;
	model y= x1 x2  x3 x4;
run;

/*4��° ����ġ "Neversink"�� ����*/
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


/*5��° ����ġ "Hackensack"�� ����*/
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

/*4��° ����ġ "Neversink"�� 5��° ����ġ "Hackensack"�� ���ÿ� ����*/
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

/*�Ϻ� ����ġ�� �����ν�, ȸ�Ͱ���� ũ�� ��ȭ��.*/
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
