data newyork;
	infile "C:\Users\kuk\Desktop\NewYork_River_adjust.txt" expandtabs firstobs=2;
	length river$ 15;
	input River$ x1-x4 y;
run;

symbol1 color=black i=none v=dot;
symbol2 color=blue i=rl v=none;

proc gplot data=newyork;
	plot y*x4=1 y*x4=2/overlay;
run;

proc reg data=newyork;
	model y=x4;
	plot y*x4;
run;

data newriver;
	set newyork;
	if river='Neversink' then delete;
	if river='Hackensack' then delete;
run;

symbol1 color=black i=none v=dot;
symbol2 color=blue i=rl v=none;

proc gplot data=newriver;
	plot y*x4=1 y*x4=2/overlay haxis=0 to 3.5 by 0.5;
run;

proc reg data=newriver;
	model y=x4;
	plot y*x4/haxis=0 to 3.5 by 0.5;
run;

proc reg data=newyork ;
	model y = x4 / r ;
	output out=out1
		p=yhat	Residual=ei  Student=ri  Cookd=Ci;
quit;

proc reg data=newyork ;
	model y = x4  /influence ;
	output out=out2
		p=yhat	Residual=ei Student=ri Cookd=cooki Rstudent=ti h=hii COVRATIO=cov DFFITS=df_fit PRESS=press ;
quit;

/*����θ� �˷��ֱ�*/
proc reg data=newyork ;
	model y = x4 / r influence vif ;
	ods output outputstatistics = outall;
quit;

proc reg data=river ;
	model y = x4 / cli clm;
	ods output outputstatistics = outcl ;
quit;

/*(1) ������ ������ ���� ����*/
/***********************************************************************************************************************/
/*���� �߿��� ������, ������ ������ ����Ǹ�, ���� �Ͽ� ���� ȸ�͸����� �������� ���� ���� �ȴ�.*/

/*���Լ�*/
proc univariate data=out2 normal plot;    /*(ǥ��ȭ)���� ����Ȯ���÷�*/
	VAR ti ;
	QQPLOT ti  / NORMAL(MU=EST SIGMA=EST COLOR=RED L=1) ;
	HISTOGRAM / NORMAL(COLOR=MAROON W=4) CFILL = BLUE CFRAME = LIGR ;
		INSET MEAN STD / CFILL=BLANK FORMAT=5.2 ;
run;
/* color,w�� ���Լ��� */
/*CFILL = BLUE CFRAME = LIGR  �̰� ���� �����, ����*/
/* INSET MEAN STD / CFILL=BLANK FORMAT=5.2 �� ����...�� �����....*/
/*	PPPLOT ti  / NORMAL(MU=EST SIGMA=EST COLOR=RED L=1) ;*/


/*����*/
proc kde data=out2 out=density; 
  var ti;
run;
proc sort data=density;
  by ti;
run;
goptions reset=all;
symbol1 c=blue i=join v=none height=1;
proc gplot data=density;
  plot density*ti = 1;
run; quit;
/* ���� �׸� �׸��� ����..*/


/*��л꼺, ������*/
/***********************************************************************************************************************/
/*����ġ ��ȣ�� �Ҵ�*/

data test ;                 
	SET out2 ;
    	id = _N_ ;  
run;

proc plot data=test ;                         		/* v = vertical axis(������)�� �ǹ�, h = horizontal axis(������)�� �ǹ�  */
	plot ti * id      /vpos=30 hpos=120 ;       /*(ǥ��ȭ)������ �ε��� �÷� -> ��л꼺 �� ������ üũ*/ 
    plot ti * x4     /vpos=30 hpos=120 ;       /*(ǥ��ȭ)���� �� ������ -> ������ ������ ������ ����� üũ*/
    plot ti * yhat  /vpos=30 hpos=120 ;       /*(ǥ��ȭ)���� �� ���հ� -> ������ ���հ� ������ ����� üũ*/
run;                                                          /* vpos : ������ ����, hpos : ������ ���� */
/* proc insight�� �׷��� ����� �̿��ϸ�, �������̰� �����ϰ� ���캼 �� ����. * /
/* SAS 9.3���ʹ� �� ����� ���� �� �ϴ�. */

proc insight data=test;
run; 

/*(2) ���� ������(high leverage point), ����� �ִ� ����ġ(influential point), Ư��ġ(outlier)�� ���� ����*/
proc plot data=test ;   
	plot  hii * id /vpos=30 hpos=120 ;                    /*������(leverage value)�� �ε��� �÷�*/
  	plot  cooki * id /vpos=30 hpos=120 ;               /*Cook's Distance �ε��� �÷�*/
	plot  df_fit * id /vpos=30 hpos=120 ;                /*DFITS���� �ε��� �÷�*/
run;

proc insight data=test;
run;



/*Hadi�� ����� ����*/

proc reg data=newyork ;
	model y = x4  ;
run;

data test2 ;
	set test ;
	di = (ei/sqrt(2.59540)) ;															/*di=ei/sqrt(sse)*/
    potential_Fuction = hii/(1-hii) ;
	residual_Function = ((1+1)/(1-hii))*((di*di)/(1-di*di)) ;
	hadi = potential_Fuction + residual_Function ;
run;

proc plot data=test2;   
	plot  hadi * id /vpos=30 hpos=120 ;                                                 		/*hadi�� ����� ������ �ε��� �÷�*/
  	plot  potential_Fuction * residual_Function /vpos=30 hpos=120 ;    			/*���缺 - ���� �÷�*/
run;

/*proc insight�� �׷��� ����� �̿��ϸ�, �������̰� �����ϰ� ���캼 �� ����.*/

proc insight data=test2; 
run;

goptions reset=all;
symbol color=black i=none v=dot;
proc gplot data=test2;
	plot potential_Fuction * residual_Function;
run;


/* �������� 4.12*/
/*������ �Է�*/

data example ;
	infile "C:\Users\kuksunghee\Desktop\���п�\����\2�б� ȸ�ͽ�\ȸ�ͽ�\12����\Exercise_4.12-4.14.txt"  expandtabs firstobs=2 ;
	input  Y  	X1 	X2 	X3  	X4 	X5   	X6  ;
run ;


/*(a)*/

proc reg data=example ;
	model  Y = X1 	X2 	X3  	X4 	X5   	X6  / r influence vif ;
	output out=temp1 p=yhat Residual=ei Student=ri Rstudent=ti Cookd=Ci DFFITS=DFi h=hii ;
quit ;

proc sgscatter data=temp1 ;
  matrix y x1-x6 ;
run;

data temp2 ;                 
	SET temp1 ;
   	obs = _N_ ;  
run;

/*���Լ�*/
proc univariate data=temp2 normal plot ;
	var ti ;
run;      
/*��л꼺�� ������*/

goption reset=all ;
symbol1	color=black	i=none	v=dot     ;                    
proc gplot data=temp2 ;                        
	plot ti * X1 ;  plot ti * X2 ; plot ti * X3 ; plot ti * X4 ;	plot ti * X5 ; 	plot ti * X6 ;
    plot ti * obs ;  plot ti * yhat ;      
run;



/*���� 4.2��-"ȸ�ͺм��� ǥ������ ������"�� �����Ѵ�.*/
/*�켱, ������������ ���� ������ �ƴϴ�. (���߰������� �ǽɵ�)*/
/*���Լ��� �������� ������ ���� �� ����.*/
/*��л꼺�� ������ �ִ� �� ����. ǥ��ȭ ������ �ε��� �÷Կ��� ���� ������ ���°� ������.*/



/*(b),(c),(d)*/

data temp3 ;                 
	SET temp2 ;
   	di = (ei/sqrt(26813)) ;
    potential_Fuction = hii/(1-hii) ;
	residual_Function = ((1+6)/(1-hii))*((di*di)/(1-di*di)) ;
	Hi = potential_Fuction + residual_Function ;
run; 

goption reset=all ;
symbol1	color=black		interpol=none	value=dot     ;     
proc gplot data=temp3 ;   
	plot ri * obs ;
	plot Ci * obs ;
	plot DFi * obs ;
	plot  Hi * obs ;                                                 
  	plot  potential_Fuction * residual_Function ;    
run;
proc insight data=temp3 ;
run ;

/*�Ϻ� Ƣ�� ����ġ�� ���δ�. proc insight�� ���� ����ġ ��ȣ�� ã�� �� �ִ�.*/
/*ri, hii, Ci, DFi, Hi �� index plot �� ���缺-���� �÷�, �� 6������ �÷����κ��� Ƣ�� ����ġ�� Ȯ���� �� �ִ�.*/


/**********************************************************************************************************************/
