/*2.10*/
/* 2.10�� �����ͼ� �Է�*/
data huswife;
	infile "C:\Users\inha\Desktop\huswife.txt";
	input husband wife;
run; 
/*��ġ������ ȸ�ͺм�*/
proc reg data=huswife;
	model husband=wife;
run;
/*(a)*/
/*��ġ������ ���л�м�*/

proc corr data=huswife cov;
	var husband ;
	with wife;
run;
/* ����� �Ƴ��� Ű ������ ���л��� 69.41293860*/
/*(b)*/ 
/*��ġ���͸� ���ͷ� ȯ���Ͽ� ������ �Է�*/
data huswife2;
	infile "C:\Users\inha\Desktop\huswife.txt";
	input husband 3.2  wife 4.2;
run;
/*���ʹ����� ȸ�ͺм�*/
proc reg data=huswife2;
	model husband=wife;
run;
/*���ʹ����� ���л�м�*/
/* (b)Ű�� ��Ƽ���Ͱ� �ƴ� ���ͷ� �����Ǿ����� ���л��� 0.0069412939
    (c)�������� 0.76339 
	(d)Ű�� ��Ƽ���ͷ� �������� ���ͷ� �������� �������� ����. �ֳ��ϸ� �������� ���� ������ ������� �����ϱ� �����̴�. */
proc corr data=huswife2 cov;
	var husband;
	with wife;
run;
/*���ڵ��� �ڽź��� ��Ȯ�� 5��Ƽ���� ���� ���ڿ� ��ȥ��������  �����ͼ�*/
data huswife3;
	infile "C:\Users\inha\Desktop\huswife.txt";
	input husband wife;
	wife2= husband-5;
	keep husband wife2;
run;
/*���ڵ��� �ڽź��� ��Ȯ�� 5��Ƽ���� ���� ���ڿ� ��ȥ�������� �����ͼ��� ȸ�ͺм�*/
proc reg data=huswife3;
	model husband=wife2;
run;
/*���ڵ��� �ڽź��� ��Ȯ�� 5��Ƽ���� ���� ���ڿ� ��ȥ�������� �����ͼ��� ���л�м�*/
proc corr data=huswife3 cov;
	var husband;
	with wife2;
run;
/*(e) �������� 1�̴�.*/
/*����� �Ƴ��� Ű �� ������� ���������� �������� �˾ƺ��� ���� �� ���� ��� ���� ������ �ξ�Ҵ�*/
proc reg data=huswife;
	model husband=wife;
run;
proc reg data=huswife;
	model wife=husband;
run;
/*(f) ���� �� ������� ��������� ���̰� ����. ���� �� ������ ��� ���� ���������� �ص� ����� ���ٰ� �Ҽ��ִ�. 
		������ ������ ���Ǹ� ���� ������Ű�� ���������� ���Ѵ�.*/
proc reg data=huswife;
	model husband=wife;
run;
/*(g)		H0: ��1=0 vs H1:��1=0�̶�� �� �� ����
		t-value�� ���� 11.46�̰�, p-value <0.0001�̹Ƿ� ���Ǽ��� 0.05�Ͽ��� �͹������� �Ⱒ�Ѵ�. 
		���� ���Ⱑ 0�̶�� �� �� ���� */
/*(h)		H0::��0=0 vs H1:��0=0�̶�� �� �� ����
		t-value�� ���� 3.17�̰�, p-value <0.0021�̹Ƿ� ���Ǽ��� 0.05�Ͽ��� �͹������� �Ⱒ�Ѵ�
		���� �������� 0�̶�� �� �� ����*/

/*(j)		����� Ű�� ���� ����� ���� ��ȥ�ϴ� ������ �ִ����� �����ϱ� ���ؼ��� ��0(������)�� 0�̸� ��1(����)�� ����̿��� �Ұ��̴�. �̷��� ������ �����ϱ� ���ؼ��� 
		�̷��� ������ �����ϱ� ���ؼ� ��0=0�ΰ��� Ȯ���ϴ� �� �������� 0�ΰ� �ƴѰ��� Ȯ���ϴ� (h)�� ������ ������ �����Ͽ��� �Ѵ�.
		(g)������ ������ ��1�� ���� 0������ Ȯ���ϴ� �� ���Ⱑ 0���� Ȯ���ϴ� �����̴�. ������ ����� Ű�� ���� ����鳢��
		��ȥ�Ѵٴ� ������ Ȯ���ϴ� ���������� ��1�� ���� 0������ �Ǵ��ϴ� �� ���ٴ� ��1�� ������� �Ǵ��ϴ� ������ �ʿ��ϴ�.*/
		
/*(k)		����� Ű�� ���� ����鳢�� ��ȥ�ϴ� ������ Ȯ���ϱ� ���ؼ��� ��1�� ���� ��������� Ȯ���ϴ� ������ �ʿ��ϴ�. 
		H0:��1>0 vs H1:��1>0�̶�� �� �� ����. ��� �͹������� �븳������ ������ ������ �ʿ��ϴ�. 
		�������� 0.76339�̹Ƿ� ����� �Ƴ��� Ű������ ������ �������谡 �ѷ��ϴٰ� �� �� �ִ�. 
		���� ���л��� ��� �̹Ƿ� x�� ���� �Ҷ� y�� ���� �ϰԵǹǷ� ��>0�̶�� ���� �����ϴ�*/








/*3.14*/
/* ���Һ� �����ͼ� �Է�*/
data ciga;
	infile "C:\Users\inha\Desktop\ciga.txt" expandtabs firstobs=2;
	input age hs income black female price sales;
run; 
/*(a)*/
/*full model*/
proc reg data=ciga;
	model sales = age hs income black female price;
quit;
/*reduced model*/
proc reg data=ciga;
	model sales = age hs income black price;
quit;
/* H0: female=0 vs H1: female=0�̶�� �� �� ����
		��� �͹������� �븳������ ����*/
proc reg data=ciga ;
	model sales = age hs income black female price ;  
	test female=0 ;
quit;
/* �̶� p-value�� 0.8507 �̰� ���Ǽ��� 0.05������  H0�� �Ⱒ�������Ѵ�.
	���� ���� female�� sales�� �����ϴµ�  �ʿ��ϴٰ� ���Ҽ� ����*/
/*(b)*/
/*full mode*/
proc reg data=ciga;
	model sales = age hs income black female price;
quit;
/*reduced model*/
proc reg data=ciga;
	model sales = age income black price;
quit;
/* H0: HS=female=0vs H1:HS=female=0�̶�� �� �� ����  ��� �͹������� �븳������ ����*/
proc reg data=ciga ;
	model sales = age hs income black female price ;  
	test female=hs=0 ;
quit;
/*p-value�� 0.9789 �̰� ���Ǽ��� 0.05������  H0�� �Ⱒ���� ���Ѵ�.
	����  female,hs�� �ʿ��ϴٰ� ���Ҽ� ����*/
/*(c)*/
proc reg data=ciga;
	model sales = age hs income black female price/i;
quit;
 /*t-value �� ���*/
data tvalue ;
	alpha=0.05 ; df=50-6-1 ;
	t=tinv(1-alpha/2,df) ;
run ;
/*(c) income�� ����ġ�� 0.01895 �̰� ǥ�ؿ����� 0.01022 �̴�.
	�ŷڱ����� 0.01895 ��  t(0.025, 51-7)*(0.01022)�̴�*/

/*(d)*/
/*full model*/
proc reg data=ciga;
	model sales = age hs income black female price;
quit;
/*reduced model*/
proc reg data=ciga;
	model sales = age hs black female price;
quit;
/*(d) income�� �����Ͽ����� R-Squar�� 0.2678�� ��Ÿ����.
	�׷��Ƿ� ȸ�ͽĿ��� income�� ���� �Ͽ�����, ȸ�ͽĿ� �Ǿƿ� ����Ǵ� sales�� ���̴� 0.2678%�̴�.*/

/*(e)*/
/*full model*/
proc reg data=ciga;
	model sales = age hs income black female price;
quit;
/*reduced model*/
proc reg data=ciga;
	model sales = price age income;
quit;
/*(e) price,age,income�� �������� �Ͽ����� R-Squar�� 0.3032�� ��Ÿ����.
	�׷��Ƿ� ȸ�ͽĿ��� price,age,income�� ���Ͽ� ����Ǵ� sales�� ���̴� 0.3032%�̴�.*/                      

/*(f)*/
proc reg data=ciga;
	model sales = income;
quit;
/*(f) income�� ��������  R-Squar�� 0.1063 �̹Ƿ� income�� ���Ͽ� ����Ǵ� sales�� ���̴� 10.63%�̴�.*/
