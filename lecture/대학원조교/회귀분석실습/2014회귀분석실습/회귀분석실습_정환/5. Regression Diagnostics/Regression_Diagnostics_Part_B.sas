
/***********************************************************************************************************************/
/* ��� : NewYork River */
/***********************************************************************************************************************/

/*data�Է�*/
data river ;
	infile"D:\NewYork_River.txt"  expandtabs firstobs=2 ;
	length river $ 15 ;
	input river $ x1 -x4 y ;
run;
data river;
	set river;
	obs_num = _N_ ; 	  /* ����ġ��ȣ */ 
run;
/*�����Ϳ� ����ġ ��ȣ�� �߰�����(���� �м��� ���Ǹ� ���ؼ�)*/

/*�������� �� ������Ž��*/
proc insight data=river;
run;
/*���� ���� �� ������ ���� ���� & ����� �ִ� ������ü Ž��*/
proc reg data = river;
	model y = x4 /r influence vif;
	output out = river_stat
    p=yhat Residual=ei RStudent=ti Cookd=cooki h=hii DFFITS=df_fit; 
/*p�� ��������, Residual�� ������, Rstudent�� ����ǥ��ȭ������, Cookd�� Cook�� �Ÿ���, h�� ��������, DFFITS�� DFFits���� �ǹ���*/
quit;
/*Hadi�� �����ϴ� ��跮�� ���*/
data river_stat; 
	set river_stat;
 	di = (ei/sqrt(2.59540)) ;             /* ����ȭ���� = ����/sqrt(���յ� ������ SSE) */
    potential_Fuction = hii/(1-hii) ;   /* ���缺 �Լ� */
    residual_Function = ((1+1)/(1-hii))*((di*di)/(1-di*di)) ;  /* ���� �Լ� */
    hadi = potential_Fuction + residual_Function ;   /* Hadi�� ����� ���� */
run;
proc insight data=river_stat;
run;

/*������ �ܰ��Ű�� �Ϻ� ����ġ ���� ��, �ٽ� ������ ���� ���� & ����� �ִ� ������ü Ž��*/
proc sql ;
	create table river_delete as 
    select * 
 	from river
    where obs_num not in (4, 5) ;	  /* ����ġ��ȣ�� 4, 5���� �� ����ġ�� ����*/     
quit;
proc reg data = river_delete;
	model y = x4 /r influence vif;      /*R-square�� adjusted R-square�� ���� ������.*/
	output out = river_delete_stat
    p=yhat Residual=ei RStudent=ti h=hii Cookd=cooki DFFITS=df_fit;
quit;
data river_delete_stat;
	set river_delete_stat;
 	observation_number = _N_ ; 	  /* ����ġ��ȣ */ 
    di = (ei/sqrt(1.37579)) ;             /* ����ȭ���� = ����/sqrt(���յ� ������ SSE) */
    potential_Fuction = hii/(1-hii) ;   /* ���缺 �Լ� */
    residual_Function = ((1+1)/(1-hii))*((di*di)/(1-di*di)) ;  /* ���� �Լ� */
    hadi = potential_Fuction + residual_Function ;   /* Hadi�� ����� ���� */
run;
proc insight data=river_delete_stat;
run;
/*����� �ִ� ������ü�� ������ �����ϴ� ���� �ƴ�. ���հ���� �ְ��Ų�ٰ� Ȯ���� �ǴܵǴ� �Ϳ� ���ؼ� ���������� ������ �� �ִ�.*/


/*�������� ȿ���� ���� �����÷�*/
/*÷�������÷�(Added Variable Plot) - ������ ������ Ȯ���� �� ����*/
proc reg data=river ;
	model y = x1 x2 x3 x4 / partial  ;  
quit;
/************************************************************************************************************************/



/************************************************************************************************************************/
/* ��� : Scottish Hills Races */
/***********************************************************************************************************************/

/*data�Է�*/
data hill ;
    infile "D:\Scottish_Hills_Races.txt" expandtabs firstobs=2;
	length hill_race$ 30 ;
	input hill_race$ Time Distance Climb ;
run;
data hill;
	set hill;
	obs_num = _N_ ; 	  /* ����ġ��ȣ */ 
run;
/*�������� �� ������Ž��*/
proc insight data=hill;
run;
/*���� ���� �� ������ ���� ���� & ����� �ִ� ������ü Ž��*/
proc reg data=hill ;
	model Time = Distance Climb  / r influence vif ;
	output out=hill_stat
	p=yhat	Residual=ei  Rstudent=ti h=hii Cookd=cooki DFFITS=df_fit ;
quit;
/*Hadi�� �����ϴ� ��跮�� ���*/
data hill_stat; 
	set hill_stat;
 	di = (ei/sqrt(24810082)) ;          /* ����ȭ���� = ����/sqrt(���յ� ������ SSE) */
    potential_Fuction = hii/(1-hii) ;   /* ���缺 �Լ� */
    residual_Function = ((1+1)/(1-hii))*((di*di)/(1-di*di)) ;  /* ���� �Լ� */
    hadi = potential_Fuction + residual_Function ;   /* Hadi�� ����� ���� */
run;
proc insight data=hill_stat;
run;


/***********************************************************************************************************************/
/*���� ���� �� ������ ���� ���� & ����� �ִ� ������ü Ž�� (command)*/
/***********************************************************************************************************************/
proc univariate data=hill_stat normal plot;    /*������ ����-���Լ�*/
	VAR ti ; 
	QQPLOT ti  / NORMAL(MU=EST SIGMA=EST COLOR=RED L=1) ;
run;
/***********************************************************************************************************************/
proc sgplot data=hill_stat ;		scatter x=yhat y=ti                 / datalabel=obs_num;	  run;     /*������ ����-��л꼺*/
proc sgplot data=hill_stat ;		scatter x=Distance y=ti          / datalabel=obs_num;	  run;     /*������ ����-������*/ 
proc sgplot data=hill_stat ;		scatter x=Climb y=ti               / datalabel=obs_num;  run;      /*������ ����-������*/ 
proc sgplot data=hill_stat ;		scatter x=obs_num y=ti         / datalabel=obs_num;   run;     /*Ư�̰�, ������ ����-��л꼺 & (������)*/ 
proc sgplot data=hill_stat ;		scatter x=obs_num y=hii       / datalabel=obs_num;   run;     /*������*/ 
proc sgplot data=hill_stat ;		scatter x=obs_num y=cooki  / datalabel=obs_num;   run;     /*�����*/
proc sgplot data=hill_stat ;		scatter x=obs_num y=df_fit    / datalabel=obs_num;  run;      /*�����*/
proc sgplot data=hill_stat ;		scatter x=obs_num y=hadi    / datalabel=obs_num;  run;      /*�����*/
proc sgplot data=hill_stat ;		scatter x=residual_Function y=potential_Fuction / datalabel=obs_num; run;  /*�����*/
/***********************************************************************************************************************/


/*������ �ܰ��Ű�� �Ϻ� ����ġ ���� ��, �ٽ� ������ ���� ���� & ����� �ִ� ������ü Ž��*/
proc sql ;
	create table hill_delete as 
    select * 
 	from hill
    where obs_num not in (7, 18) ;	  /* ����ġ��ȣ�� 7, 18���� �� ����ġ�� ����*/     
quit;
proc reg data=hill_delete ;
	model Time = Distance Climb  / r influence vif ;  /*adj_R square�� 91%���� 98%�� �޻�� */
	output out=hill_delete_stat
	p=yhat	Residual=ei  Rstudent=ti h=hii Cookd=cooki DFFITS=df_fit ;
quit;
/*Hadi�� �����ϴ� ��跮�� ���*/
data hill_delete_stat; 
	set hill_delete_stat;
 	di = (ei/sqrt(3958172)) ;            /* ����ȭ���� = ����/sqrt(���յ� ������ SSE) */
    potential_Fuction = hii/(1-hii) ;   /* ���缺 �Լ� */
    residual_Function = ((1+1)/(1-hii))*((di*di)/(1-di*di)) ;  /* ���� �Լ� */
    hadi = potential_Fuction + residual_Function ;   /* Hadi�� ����� ���� */
run;
proc insight data=hill_delete_stat;
run;
/*�Ϻ� ����� ���� ����ġ�� �����ϸ�, ������ ������ �����Ǵ� ������ ���δ�.*/
/**********************************************************************************************************************/



/**********************************************************************************************************************/
/* exercise 4-3 */
/**********************************************************************************************************************/

/*������ �Է�*/
data repair ;
	infile "D:\Computer_Repair.txt"	expandtabs firstobs=2 ;
	input Units Minutes ;
run ;
data repair ;
	set repair ;
	obs_num=_N_ ;
run;    
/*�������� �� ������Ž��*/
proc insight data=repair;
run;
/*��������*/
proc reg data=repair;
	model minutes = units/partial; /*÷�������÷�(Added Variable Plot) - ������ ������ Ȯ���� �� ����*/
run;

/*����� �������κ��� X^2���� �߰�*/
data repair ;
	set repair ;
	Units2 = Units * Units ;
run;
proc reg data=repair ;
	model Minutes=Units Units2 / vif  ;
quit ;    
/*X�� X^2 ������ �������� ���� - Centering */
proc sql ;
	create table repair as
	select *, (Units - avg(Units)) as Centered_Units
	from repair;
quit ;
proc sql ;
	create table repair as
	select *, (Centered_Units*Centered_Units) as Centered_Units2
	from repair;
quit ;
/*Centering �Ŀ� ���� vif ��ġ�� ����*/
proc reg data=repair ;
	model Minutes=Centered_Units Centered_Units2 /vif  ;
quit ;    
/*Centering�� ȿ���� ���� �÷�*/
proc sgplot data=repair ;
	scatter x=Units y=Units2 / datalabel=obs_num;
run;     
proc sgplot data=repair ;
	scatter x=Centered_Units y=Centered_Units2 / datalabel=obs_num;
run;    
/**********************************************************************************************************************/



/**********************************************************************************************************************/
/* exercise 4-12 */
/**********************************************************************************************************************/

/*������ �Է�*/
data example ;
	infile "D:\Exercise_4.12-4.14.txt"  expandtabs firstobs=2 ;
	input  Y  	X1 	X2 	X3  	X4 	X5   	X6  ;
run ;
data example;
	set example;
	obs_num = _N_ ; 	  /* ����ġ��ȣ */ 
run;

/*�������� �� ������Ž��*/
proc insight data=example;
run;
/*���� ���� �� ������ ���� ���� & ����� �ִ� ������ü Ž��*/
proc reg data = example;
	model Y = X1 X2 X3 X4 X5 X6 /r influence vif;
	output out = example_stat
    p=yhat Residual=ei RStudent=ti Cookd=cooki h=hii DFFITS=df_fit; 
quit;
/*Hadi�� �����ϴ� ��跮�� ���*/
data example_stat; 
	set example_stat;
 	di = (ei/sqrt(26813)) ;             /* ����ȭ���� = ����/sqrt(���յ� ������ SSE) */
    potential_Fuction = hii/(1-hii) ;   /* ���缺 �Լ� */
    residual_Function = ((1+1)/(1-hii))*((di*di)/(1-di*di)) ;  /* ���� �Լ� */
    hadi = potential_Fuction + residual_Function ;   /* Hadi�� ����� ���� */
run;
proc insight data=example_stat;     
run;
/*ǥ��ȭ������ �÷Կ��� �������� ������ ������ �����ǹǷ�, ��л꼺�� ����Ǵ� ������ �Ǵܵ�.*/
/**********************************************************************************************************************/


