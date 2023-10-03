/*����*/
/*1*/
data male female;
	set sashelp.class(firstobs=5 obs=15);
	if sex="��" then output male;
	else output female;
run;


/*2*/
proc import datafile="D:\���п� �ڷ�\ȸ�ͺм��ǽ�\2015ȸ�ͺм��ǽ�\chap3. SAS ������ �ٷ��\demog.xlsx" out=demog dbms=xlsx replace;
	getnames=yes;
run;

data visit;
	infile "D:\���п� �ڷ�\ȸ�ͺм��ǽ�\2015ȸ�ͺм��ǽ�\chap3. SAS ������ �ٷ��\visit.txt" expandtabs firstobs=2;
	input ID$ Visit SysBP DiasBP Weight Date$;
run;

proc sort data=demog; by id; run;
proc sort data=visit; by id; run;

data info;
	merge demog(rename=(date=BirthDate))
				visit(rename=(date=VisitDate));
	by id;
run;
/*��*/
data merge;
	merge demog visit;
	by id;
run;


/*3*/
data nvst;
	set sashelp.nvst1-sashelp.nvst5(where=(date='01JAN2000'd));
	retain total 0;
	total=total+amount;
	drop date;
run;
