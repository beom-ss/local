/*page 2*/

/*���� �⺻���� ����*/
data sample;
	input x y z;
	cards;
8 2 1
5 34 14
41 3 12
;
run;

/*txt ���Ϸκ����� ȣ��(�������� ���Ե��� ���� ���)*/
data sample;
	infile "C:\Users\Dharma\Desktop\sample.txt";
	input x y z;
run;
data temp.sample;
	infile "C:\Users\Dharma\Desktop\sample.txt";
	input x y z;
run;

/*txt���Ϸκ����� ȣ�� �� sas �������Ϸ� ����*/
Libname temp 'D:\' ;
data temp.sample;
	infile "C:\Users\Dharma\Desktop\sample.txt";
	input x y z;
run;

/* sas �������� �о���� */
Libname temp 'D:\' ;
