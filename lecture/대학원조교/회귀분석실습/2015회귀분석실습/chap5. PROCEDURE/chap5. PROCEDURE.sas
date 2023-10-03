/*page 19*/
data gains; 
    input name $ sex $ height  weight  school $  time; 
cards; 
Alfred  M 69.0 122.5 AJH  1 
Alfred  M 71.0 130.5 AJH  2 
Alicia  F 56.5  84.0 BJH  1 
Alicia  F 60.5  86.9 BJH  2 
Benicia F 65.3  98.0 BJH  1 
Benicia F 69.3  99.1 BJH  2 
Bennett F 63.2  96.2 AJH  1 
Bennett F 69.2  98.2 AJH  2 
Carol   F 62.8 102.5 BJH  1 
Carol   F 65.3 105.4 BJH  2 
Carlos  M 63.7 102.9 AJH  1 
Carlos  M 70.3 106.9 AJH  2 
Henry   M 63.5 102.5 AJH  1 
Henry   M 68.9 108.6 AJH  2 
Jaime   M 57.3  86.0 BJH  1 
Jaime   M 62.9  90.0 BJH  2 
Janet   F 59.8  84.5 AJH  1 
Janet   F 62.5  86.5 AJH  2 
Jean    M 68.2 113.4 AJH  1 
Jean    M 70.3 116.0 AJH  2 
Joyce   M 51.3  50.5 BJH  1 
Joyce   M 55.5  53.5 BJH  2 
Luc     M 66.3  77.0 AJH  1 
Luc     M 69.3  82.9 AJH  2 
Marie   F 66.5 112.0 BJH  1 
Marie   F 69.5 114.9 BJH  2 
Medford M 64.9 114.0 AJH  1 
Medford M  .     .    .   . 
Philip  M 69.0 115.0 AJH  1 
Philip  M 70.0 118.0 AJH  2 
Robert  M 64.8 128.0 BJH  1 
Robert  M 68.3   .   BJH  2 
Thomas  M 57.5  85.0 AJH  1 
Thomas  M 59.1  92.3 AJH  2 
Wakana  F 61.3  99.0 AJH  1 
Wakana  F 63.8 102.9 AJH  2 
William M 66.5 112.0 BJH  1 
William M 68.3 118.2 BJH  2 
; 

proc means data=gains; 
   var height weight; 
   class sex; 
   output out=test 
			max=maxht maxwght;
run; 
proc print data=test; 
run;

/*page 20*/
proc sort data=gains; 
   by school time; 
run; 
proc means data=gains maxdec=3 fw=10; 
   by school time; 
   var height weight; 
   output out=new mean=hmean wmean stderr=hse wse;
   title 'Statistics With Two By Variables'; 
run; 

/*page 21*/
proc print data=new;
	var school time hmean wmean hse wse;
	sum hmean wmean hse wse;
run;



/*page 22*/
data new; 
   input a b @@; 
   cards; 
1 2    2 1    . 2    . .    1 1    2 1
;
proc print data=new;
run;

proc freq; 
   title 'NO TABLES STATEMENT';
run;
proc freq; 
   tables a / missprint; 
   title '1-WAY FREQUENCY TABLE WITH MISSPRINT OPTION'; 
run;

/*page 23*/
proc freq; 
   tables a*b; 
   title '2-WAY CONTINGENCY TABLE'; 
run;
proc freq; 
   tables a*b / missprint; 
   title '2-WAY CONTINGENCY TABLE WITH MISSPRINT OPTION'; 
run;

/*page 24*/
proc freq; 
   tables a*b / missing; 
   title '2-WAY CONTINGENCY TABLE WITH MISSING OPTION'; 
run;
proc freq; 
   tables a*b / list; 
   title '2-WAY FREQUENCY TABLE'; 
run;

/*page 25*/
proc freq; 
   tables a*b / list missing; 
   title '2-WAY FREQUENCY TABLE WITH MISSING OPTION'; 
run;
proc freq; 
   tables a*b / list sparse; 
   title '2-WAY FREQUENCY TABLE WITH SPARSE OPTION'; 
run;

/*page 26*/
proc freq order=data; 
   tables a*b / list; 
   title '2-WAY FREQUENCY TABLE, ORDER=DATA'; 
run;

/*page 27*/
data newspapers;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap5. PROCEDURE\newspapers.txt" dlm=',' missover dsd;
	input name$ x1 x2;
run;
proc print data=newspapers;
run;

proc gplot data=newspapers;
	title "x1 vs x2 plot";
	plot x1*x2;
run;

