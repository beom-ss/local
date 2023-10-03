    
 
data one;
infile"C:\Users\aa\Desktop\test.txt";
input $student $section $test1$test2 $test3 $test4;
run;

data one_1;
if section=1 then output (test1-10 test2-14);
else if section=2 then output (test1+3 test2+5);
run;

data one_2;
if section=2 then output &test1+$test2+$test3+&test4+&test5+$test6;
array{6};
do=1-6;
run;

data preg;
infile"C:\Users\aa\Desktop\preg.txt" expantabs;
input $name $preg_num $date;
run;

data expo;
infile"C:\Users\aa\Desktop\expo.txt" expantabs;
input $name $data $exposlvl;
run;

proc import datafile="C:\Users\aa\Desktop\timerec.xlsx" out=timerec.xlsx dbms=xlsx.replace;
getname=yes;

data label;
label employee="고용인";
        phase="분석단계";
        hours="시간";
 run;

 data gplot;
 do 1-20;
 nor_pdf=pdf("normal",5,4);
 run;
