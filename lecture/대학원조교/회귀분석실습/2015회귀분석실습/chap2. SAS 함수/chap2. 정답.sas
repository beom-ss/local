proc import datafile="D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap2. SAS 함수\example1.xlsx" out=example1 dbms=xlsx replace;
	getnames=yes;
run;

data test;
	set example1;
	if x1<x2 or x3>x4;
run;

data example2;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap2. SAS 함수\example2.txt" expandtabs;
	input name$ sex$ age height Weight;
run;

data class_final;
	set sashelp.class example2;
run;

data class_final1;
	set class_final;
	if weight>=110 then grade="고도비만";
	else if weight>=100 then grade="비만";
	else if weight>=90 then grade="과체중";
	else if weight>=80 then grade="정상";
	else grade="저체중";
run;
