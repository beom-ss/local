data table21;
infile "C:\Users\student\Desktop\data2.txt";
input Row H W;
run;
/*a��*/
proc corr;
variable h w;
run;
/*c�� g��*/
proc reg data=table21;
model h=w;
quit;
proc reg data=table21;
model h=;
quit;

/*h��*/

/*j��-NO*/
proc plot;
plot h*w;
quit;

/*K�� - �𸣰���*/
