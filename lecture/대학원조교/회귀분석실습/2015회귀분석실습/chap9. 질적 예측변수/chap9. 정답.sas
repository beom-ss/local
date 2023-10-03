/*������ �Է�*/
data class;
	infile "D:\���п� �ڷ�\ȸ�ͺм��ǽ�\2015ȸ�ͺм��ǽ�\chap9. ���� ��������\class_data.txt" expandtabs firstobs=2 ;
	input Age Height Weight Sex ;
run;

/*1*/
/*������*/
goption reset=all;
symbol v=dot i=r;
proc gplot data=class;
	plot  Weight*Height;
run;

/*�׷캰 ������*/
goption reset=all;
symbol v=dot i=r;
proc gplot data=class;
	plot Weight*Height=Sex;
run;

/*2*/
/*�⺻ ȸ�͸��� ����*/
proc reg data=class plots=none;
	model Weight=Height Sex;
	output out=class_out student=ri;
run;

/*3*/
/*���� Ž��*/
goption reset=all;
symbol v=dot  h=1;
proc gplot data=class_out;
	plot ri*Height=Sex;            /*������ ���� �����Ǿ� �ִ� ���� Ȯ��*/
	plot ri*Sex;                       /*���ڿ� ������ ��� ������ �л꿡 ���̰� ������ Ȯ�� ->�̴� 7�忡�� �ٷ絵�� ��*/
run;

/*4*/
/*interaction term�� ����� ���� ���� �� ����*/
data class1;
	set class;
	HS=Sex*Height;
run;
proc reg data=class1 plots=none;
	model Weight = Height Sex HS;
run;
/* �������� ���� HS�� ���� */

proc reg data=class1 plots=none;
	model Weight=Height Sex;
run;

/*5*/
proc reg data=class1 plots=none;
	model Weight=Age Height Sex;
	test Age=0;
	output out=class1_out student=ri;
run;
/*Age�� �������� �ʴ�. �� �����Կ� ������ ��ġ�� �ʴ´�*/

