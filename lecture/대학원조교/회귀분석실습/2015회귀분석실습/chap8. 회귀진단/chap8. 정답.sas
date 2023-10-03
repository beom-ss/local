data exam;
	infile "D:\���п� �ڷ�\ȸ�ͺм��ǽ�\2015ȸ�ͺм��ǽ�\chap8. ȸ������\t4_8.txt"  expandtabs firstobs=2 ;
	input  y x1-x6;
run ;


proc reg data=exam ;
	model  y =x1-x6 / r influence vif ;
	output out=exam_out p=yhat Residual=ei Student=ri Rstudent=ti Cookd=Ci DFFITS=DFFITSi h=hii ;
quit ;

proc sgscatter data=exam_out;
  matrix y x1-x6;
run;

data exam_out;
	SET exam_out;
   	id= _N_;  
run;

/*1*/
/*���Լ�*/
proc univariate data=exam_out normal plot ;
	var ti;
run;
/*��л꼺�� ������*/

symbol i=none v=dot;
proc gplot data=exam_out ;                        
	plot ti*X1;
	plot ti*X2;
	plot ti*X3;
	plot ti*X4;
	plot ti*X5;
	plot ti*X6;
    plot ti*id;
	plot ti*yhat;
run;

/*���� 4.2��-"ȸ�ͺм��� ǥ������ ������"�� �����Ѵ�.*/
/*�켱, ������������ ���� ������ �ƴϴ�. (���߰������� �ǽɵ�)*/
/*���Լ��� �������� ������ ���� �� ����.*/
/*��л꼺�� ������ �ִ� �� ����. ǥ��ȭ ������ �ε��� �÷Կ��� ���� ������ ���°� ������.*/




/*2*/
data exam_out2;
	set exam_out;
   	di = (ei/sqrt(26813)) ;
    potential_function = hii/(1-hii) ;
	residual_function = ((1+6)/(1-hii))*((di**2)/(1-di**2)) ;
	Hi = potential_function + residual_function ;
run; 
/*3*/
symbol i=none v=dot;
proc gplot data=exam_out2;
	plot ri*id;
	plot Ci*id;
	plot DFFITSi*id;
	plot  Hi*id;                                                 
  	plot  potential_function*residual_function ;    
run;

/*�Ϻ� Ƣ�� ����ġ�� ���δ�.
ri, hii, Ci, DFi, Hi �� index plot �� ���缺-���� �÷�, �� 6������ �÷����κ��� Ƣ�� ����ġ�� Ȯ���� �� �ִ�.*/

