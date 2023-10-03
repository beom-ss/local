/*1번*/
data homes;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap5. PROCEDURE\homes.txt" firstobs=2;
	input name$ homeown$ age income;
run;
proc means data=homes mean stderr max min;
	class age homeown;
run;

/*2번*/
proc import datafile="D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap5. PROCEDURE\rawdata.xlsx" out=rawdata dbms=xlsx replace;
getnames=yes;
run;

proc sort data=rawdata out=sorted; 
   by region state month; 
run; 

/*3번*/
proc print data=sorted; 
   by region; 
run; 
 
/*4번*/
proc freq data=rawdata;
	table state*month;
run;

proc freq data=rawdata;
	table state*month / list;
run;
