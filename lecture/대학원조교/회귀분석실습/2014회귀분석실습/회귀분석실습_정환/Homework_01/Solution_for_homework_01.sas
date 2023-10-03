
/**********************************************************************************************************************/

/* exercise 2-10 */
data height ;
	infile "D:\height_of_husband_and_wife.txt"	expandtabs firstobs=2 ;
	input Husband	Wife ;
run ;

/*(a),(b),(c),(d)*/
proc corr data=height cov ;
run ;
proc sql;
	create table height_meter as
	select Husband/100 as Husband_m,  Wife/100 as Wife_m 
	from height ;
run;
proc corr data=height_meter cov ;
run ;

/*(e)*/
proc sql;
	create table height_another as
	select Husband, Husband-5 as Husband_a
	from height;
run;
proc corr data=height_another cov ;
run ;

/*(f)*/
proc reg data=height ;
	model Wife = Husband ;
	model Husband = Wife ;
quit ;

/*  ���� ���� ������ ���� ��������, MSE�� (adj)R-square�� ���� ��찡 ������, �̴� ���������� ���� ��쿡 �ش��Ѵ�.            */
/*  ��, SST�� ���� ���� �Ͽ��� MSE�� (adj)R-square ���� �������� ���� �� ���� ������ ������ ���� �ִ�.                                */
/*  �� ������ ��� ���������� �޶����� ������ �̷��� ������ Ÿ������ ���� ���̴�. ����  (adj)R-square���� ����.                    */

/* ���� �� ������ ��쿡�� beta�� standard error(ǥ�ؿ���)�� ���� �� �۰� ���� ������ ������ ������ ���� �ִ�.       .           */

/*Model 1 : Wife = 41.93015 + 0.69965  * Husband + error */
/*Model 2 : Husband = 37.81005 + 0.83292 *  Wife + error*/

/*���� ǥ�ؿ����� ������� �鿡�� ����, ���������� wife��, �������� Husband�� �δ� ���� �� �� ���� �� ����.                     */


/*plot*/
proc plot data=height vpercent=50 hpercent=50 ;        /*  v = vertical axis(������)�� �ǹ�, h = horizontal axis(������)�� �ǹ�  */
	plot Wife*Husband ;  plot Husband*Wife ;                  /*  vpercent, hpercent�� �ϳ��� �׸��� ��üȭ�鿡���� ������ ����      */
run;

symbol1	color=red		interpol=none	value=dot    ;      /*  symbol 1�� ����ġ ���̸� ������� �ʰ� ������ ǥ��                         */
symbol2	color=blue 	interpol=rl			value=none ;      /*  symbol 2�� ����ġ ���̸� ȸ�� ���ռ����� ���.                               */
proc gplot data=height ;
	plot Wife*Husband =1 Wife*Husband =2 / overlay ;   /*  y1 vs x1 : ���� ����(linear)                               */
	plot Husband*Wife=1 Husband*Wife=2 / overlay ;   /*  y2 vs x2 : �� ���� ����(non-linear)                   */
run;quit;


/*(g),(h) : ���� ���� */
proc reg data=height ;
	model Wife = Husband ;
quit ;


/*(j),(k)*/
proc reg data=height ;
	model Wife = Husband ;
	model Husband = Wife ;
	model Wife = Husband / noint ;
	model Husband = Wife / noint ;
quit ;
/*Model 1 :         Wife = 41.93015 + 0.69965*Husband + error */
/*Model 2 : Husband = 37.81005 + 0.83292*Wife + error*/
/*Model 3 :         Wife =                  0.93941*Husband + error*/
/*Model 4 : Husband =                  1.06291*Wife + error*/

/* ���� Ű ū ������ ���� ������ ������ Ŀ���� ��κ��̹Ƿ�, ���� 1�� ���� 3�� ���� �´� �� ����.*/
/* ����  �����Ϳ���, ������ ���� ������ Ű�� ū ���� 2���� �ۿ� ����. (39��, 78�� ����ġ)*/
/*�׷��� ���� 1�� �´ٰ� ���� ��, �ܼ��� ������ ��ġ�� �ٲ� ���� 2�� �������� ����� �����Ƿ�, ����1�� �ǽɽ�����. */
/*���� 2�� beta_1 >1 �̾�� �̰��� ���� 1�� ���� �¾� ��������. �׷��� beta1 < 1 �� ����� ���´� */

/*�̴� ������ ���� ���� ���� ����ġ�� �۱� ������ �̷� ����� ������ ���� �ƴұ� �Ǵܵȴ�.*/
/*������ ����, ���� 3, 4�� ������� ������ R-square���� SAS������ �ŷ��� �� ���� ������ �˷����ִ�. (�̴��ǿ����� �ƿ� ��� X )*/

/*��·�ų� �� ������ ��쿡�� ������ ���� ���� �� ���� �𵨸��� �ƴұ� �Ǵܵȴ�.*/
/*�������� �����ϰ� ��������, ������ ������ ������ ���� �����ϴ� ������ �����Ѵٸ�, �� ��쿡�� ������ ���� ���� �� �ٶ����� �� ����.*/


/**********************************************************************************************************************/


/* exercise 3-14 */
data cigarette ;
	infile "D:\cigarette_consumption.txt"  expandtabs firstobs=2 ;
	input State $ Age HS Income Black Female Price Sales ;
run ;

/*(a)*/
proc reg data=cigarette ;
	model Sales = Age HS Income Black Female Price ;
	test Female = 0 ;
quit ;

data pvalue1 ;
  df=51-6-1 ; 
  p =  2*(1-probt(1.40, df) ;
  put p = ;
run ; 

data pvalue2 ;
  alpha = 0.05 ; df1=1  ; df2=51-6-1 ;
  f0 = finv(1-alpha, df1, df2) ;
  p = 1 - probf(0.04, df1, df2) ;
  put f0 =  ;
  put p = ;
run ; 

/*(b)*/
proc reg data=cigarette ;
	model Sales = Age HS Income Black Female Price ;
	test Female = HS = 0 ;
quit ;

/*(c)*/
proc reg data=cigarette ;
	model Sales = Age Income Black Price ;
quit ;
data pvalue ;
  alpha = 0.05 ; df=51-4-1 ;
  t0 = tinv(1-alpha, df) ;
  p = 1 - probt(2.75, df) ;
  put t0 =  ;
  put p = ;
run ; 

/*(d)*/
proc reg data=cigarette ;
	model Sales = Age Black Price ;
quit ;

/*(e)*/
proc reg data=cigarette ;
	model Sales = Price Age Income ;
quit ;

/*(f)*/
proc reg data=cigarette ;
	model Sales = Income ;
quit ;
proc corr data=cigarette;
	var Sales Income;
run;


/**********************************************************************************************************************/
