/*답지*/
/*1*/
data male female;
	set sashelp.class(firstobs=5 obs=15);
	if sex="남" then output male;
	else output female;
run;


/*2*/
proc import datafile="D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap3. SAS 데이터 다루기\demog.xlsx" out=demog dbms=xlsx replace;
	getnames=yes;
run;

data visit;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap3. SAS 데이터 다루기\visit.txt" expandtabs firstobs=2;
	input ID$ Visit SysBP DiasBP Weight Date$;
run;

proc sort data=demog; by id; run;
proc sort data=visit; by id; run;

data info;
	merge demog(rename=(date=BirthDate))
				visit(rename=(date=VisitDate));
	by id;
run;
/*비교*/
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
