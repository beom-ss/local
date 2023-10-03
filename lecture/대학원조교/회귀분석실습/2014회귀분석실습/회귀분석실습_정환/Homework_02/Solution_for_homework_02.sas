
/**********************************************************************************************************************/

/* exercise 4-3 */

/**********************************************************************************************************************/


/*������ �Է�*/
data repair ;
	infile "D:\Computer_Repair.txt"	expandtabs firstobs=2 ;
	input  Units	Minutes ;
run ;


/*(a)*/

/*������*/
goption reset=all ;
symbol1	color=red		interpol=none	value=dot     ;                    
symbol2	color=blue 	interpol=rl			value=none  ;                      
proc gplot data=repair ;                         
	plot  Minutes*Units=1 Minutes*Units=2 / overlay ; 
run ; quit ;

proc reg data=repair ;
	model Minutes=Units ;
quit ;


/*(b)*/
proc reg data=repair ;
	model Minutes=Units / r  influence vif  ;
	output out = residual_repair p=yhat Rstudent=ti  ; 
quit ;     /* �������� ��跮 ���� */

data residual_repair ;
	set residual_repair ;
	obs=_N_ ;
run;      /* ����ġ ��ȣ �߰� */

/*���Լ�*/
proc univariate data=residual_repair normal plot ;
	var ti ;
run;      
/*��л꼺�� ������*/
goption reset=all ;
symbol1	color=red		interpol=none	value=dot     ;                    
proc gplot data=residual_repair ;                        
	plot ti * Units ;     
    plot ti * obs ;
    plot ti * yhat ;      
run; quit ;     
/*���Լ��� �����ϴ� �� ����.*/
/*�������� ������ ��� ��Ÿ���� ������, ��л꼺�� ������ ��� �������� �ʴ� ������ ���� ���� Ÿ���� �� ����.*/
/*Hadi ���翡���� ������ �����̶�� �͵� �߰��� ���ϰ� �ִµ�, ��·�ų� �������� ������.*/


/**********************************************************************************************************************/

/* exercise 4-12 */

/**********************************************************************************************************************/


/*������ �Է�*/
data example ;
	infile "D:\Exercise_4.12-4.14.txt"  expandtabs firstobs=2 ;
	input  Y  	X1 	X2 	X3  	X4 	X5   	X6  ;
run ;


/*(a)*/

proc reg data=example ;
	model  Y = X1 	X2 	X3  	X4 	X5   	X6  / r influence vif ;
	output out=temp_1 p=yhat Residual=ei Student=ri Rstudent=ti Cookd=Ci DFFITS=DFi h=hii ;
quit ;
data temp_2 ;                 
	SET temp_1 ;
   	obs = _N_ ;  
run;
/*���Լ�*/
proc univariate data=temp_2 normal plot ;
	var ti ;
run;      
/*��л꼺�� ������*/
goption reset=all ;
symbol1	color=red		interpol=none	value=dot     ;                    
proc gplot data=temp_2 ;                        
	plot ti * X1 ;  plot ti * X2 ; plot ti * X3 ; plot ti * X4 ;	plot ti * X5 ; 	plot ti * X6 ;;
    plot ti * obs ;  plot ti * yhat ;      
run; quit ;     

/*���� 4.2��-"ȸ�ͺм��� ǥ������ ������"�� �����Ѵ�.*/
/*�켱, ������������ ���� ������ �ƴϴ�. (���߰������� �ǽɵ�)*/
/*���Լ��� �������� ������ ���� �� ����.*/
/*��л꼺�� ������ �ִ� �� ����. ǥ��ȭ ������ �ε��� �÷Կ��� ���� ������ ���°� ������.*/



/*(b),(c),(d)*/

data temp_3 ;                 
	SET temp_2 ;
   	di = (ei/sqrt(26813)) ;
    potential_Fuction = hii/(1-hii) ;
	residual_Function = ((1+6)/(1-hii))*((di*di)/(1-di*di)) ;
	Hi = potential_Fuction + residual_Function ;
RUN; 

goption reset=all ;
symbol1	color=red		interpol=none	value=dot     ;     
proc gplot data=temp_3 ;   
	plot ri * obs ;
	plot Ci * obs ;
	plot DFi * obs ;
	plot  Hi * obs ;                                                 
  	plot  potential_Fuction * residual_Function ;    
run; quit;
proc insight data=temp_3 ;
run ;

/*�Ϻ� Ƣ�� ����ġ�� ���δ�. proc insight�� ���� ����ġ ��ȣ�� ã�� �� �ִ�.*/
/*ri, hii, Ci, DFi, Hi �� index plot �� ���缺-���� �÷�, �� 6������ �÷����κ��� Ƣ�� ����ġ�� Ȯ���� �� �ִ�.*/


/**********************************************************************************************************************/
