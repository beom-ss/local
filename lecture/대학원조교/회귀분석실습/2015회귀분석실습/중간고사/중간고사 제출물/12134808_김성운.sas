
#####1번;
data test;
	infile"D:\test.txt" dlm="/" ;
	input student section test1 test2 test3 test4;
run;

data test1;
	set test;
		input student section test1 test2 test3 test4;
			if section=1 then do;
					test1=test1-10
					test2=test2-14;
				end;
			if section=2 then do;
					test5 = test5+3
					test6 = test6+5;
				end;
run;

data test2;
	set test;
		input student section test1 test2 test3 test4;
			if section1=1;
 				array test{6} test1-test6;
					total=0;
					do i= 1 to 6;
					total=total+test{i};
			end;
		run;


####2번;

data preg;
	infile"D:\preg.txt" expandtabs;
		input name$ preg_num date;
 run;

data exop;
	infile"D:\expo.txt" expandtabs;
	input name$ date exposlvl;
run;


data bothid;
 set preg exop; by name;
	merge preg(rename=(preg=PREG_DATE))
				expo(rename=(expo=EXPO_DATE));
			by name;
run;


data bothid2;
	set PREG_DATE EXPO_DATE ;
 dsd;

run;




#####3번;
proc import datafile="D:\timerec.xlsx" out=timerec dbms=xlsx replace;
					getnames=yes;
	run;

data timerec1;
	set timerec;
			label employee="고용인"  phase="분석단계"  hours="시간";
run;


data timerec2;
	set timerec;
		if employee = Chen then output emp1;
		else output emp2;
	drop employee;
run;



#######4번;

data grunfel;
	infile"D:\grunfeld.txt";
	input sort invest stock value;
run;


########5번;

data normal;
	do x{i} = 1 to 20;
		nor_pdf=pdf('normal',x,10,4);
	end;
	output;
run;

proc plot data=normal ;
 		symbol i spline v=none;
 		plot nor_pdf;
run;


