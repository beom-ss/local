/*������ �б�*/
data multireg;
	infile 'C:\Users\kuksunghee\Desktop\multireg.txt' expandtabs ;
	input y x1 x2;
run;

/*�׷��� �׸��� */
proc plot data=mulireg vpercent=33 hpercent=50;
	plot y=x1; plot y=x2;
run;

/* �������*/
proc corr data=multireg;
	var y x1 x2;
run;

/*ȸ�ͺм� �� �ŷڱ��� ���ϱ� */
proc reg data=multireg;
	model y=x1 x2/clm cli;
run;

/*ȸ�ͺм� ����� ������ ������ ���� ���*/
proc reg data=multireg outest=result;
	model y=x1 x2/clm cli;
quit;run;

/*beta���� �ŷڱ����� ���ϱ� ���� beta�� parameta estimate, se �� �Է�*/
data beta_cl;
input beta se;
cards;
2.34123 1.09673
1.61591 0.17073
0.01438 0.00361
;
run;

/* beta���� �ŷڱ��� ���ϱ�*/
data cl;
set beta_cl;
up=beta+se*tinv(0.975,22);
low=beta-se*tinv(0.975,22);
run;

/* ���ο� ���� �ŷڱ����� ���ϱ� ���� �� �Է�*/
data test;
input x1 x2;
cards;
8 200
;
run;
/* ������ �����Ϳ� ��ġ��*/
data test2;
	set test multireg;
run;

/* proc reg ���� �̿��Ͽ� �ŷڱ��� ���ϱ� */
proc reg data=test2;
	model y=x1 x2/clm cli;
run;



