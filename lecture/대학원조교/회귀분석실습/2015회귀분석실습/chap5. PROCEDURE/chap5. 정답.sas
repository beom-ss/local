/*1��*/
data homes;
	infile "D:\���п� �ڷ�\ȸ�ͺм��ǽ�\2015ȸ�ͺм��ǽ�\chap5. PROCEDURE\homes.txt" firstobs=2;
	input name$ homeown$ age income;
run;
proc means data=homes mean stderr max min;
	class age homeown;
run;

/*2��*/
proc import datafile="D:\���п� �ڷ�\ȸ�ͺм��ǽ�\2015ȸ�ͺм��ǽ�\chap5. PROCEDURE\rawdata.xlsx" out=rawdata dbms=xlsx replace;
getnames=yes;
run;

proc sort data=rawdata out=sorted; 
   by region state month; 
run; 

/*3��*/
proc print data=sorted; 
   by region; 
run; 
 
/*4��*/
proc freq data=rawdata;
	table state*month;
run;

proc freq data=rawdata;
	table state*month / list;
run;
