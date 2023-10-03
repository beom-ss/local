proc import datafile="D:\���п� �ڷ�\ȸ�ͺм��ǽ�\2015ȸ�ͺм��ǽ�\chap2. SAS �Լ�\example1.xlsx" out=example1 dbms=xlsx replace;
	getnames=yes;
run;

data test;
	set example1;
	if x1<x2 or x3>x4;
run;

data example2;
	infile "D:\���п� �ڷ�\ȸ�ͺм��ǽ�\2015ȸ�ͺм��ǽ�\chap2. SAS �Լ�\example2.txt" expandtabs;
	input name$ sex$ age height Weight;
run;

data class_final;
	set sashelp.class example2;
run;

data class_final1;
	set class_final;
	if weight>=110 then grade="����";
	else if weight>=100 then grade="��";
	else if weight>=90 then grade="��ü��";
	else if weight>=80 then grade="����";
	else grade="��ü��";
run;
