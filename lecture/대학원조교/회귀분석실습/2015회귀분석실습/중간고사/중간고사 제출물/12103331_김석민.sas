data preg;
	infile "D\SAS\preg.txt"  firstobs=2;
run;

data expo;
	infile "D\SAS\expo.txt"  firstobs=2;
run;

data timerec;
	import datafile="D:\SAS\timerec.xlsx"  dbms=xlsx replace;  
run;

data grunfeld;
	infile "D\SAS\grunfeld.txt" firstobs=2 expandtabs;
run;

data test;
	infile "D\SAS\test.txt" firstobs=2;
run;

