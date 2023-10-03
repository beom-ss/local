data table319;
infile "C:\Users\student\Desktop\ciga.txt";
input age hs income black female price sales;
run;

/*a번*/
proc reg data=table319;
model sales=age hs income black female price ;
quit;

proc reg data=table319;
model sales=age hs income black price ;
quit;

/*b번*/
proc reg data=table319;
model sales=age hs income black female price ;
quit;

proc reg data=table319;
model sales=age income black price ;
quit;
/*c번*//*23.18059 +- t*28.17396*/
data tvalue;
alpha = 0.05 ; df=51-1-6;
t=tinv(1-alpha/2,df);
run;

/*d번*//*0.2265*/
proc reg data=table319;
model sales=age black female price ;
quit;

/*e번*/ /*0.3032*/
proc reg data=table319;
model sales=age income  price ;
quit;

/*f번*//* 0.1063*/
proc reg data=table319;
model sales=income ;
quit;

/*전태호 - 문영기 copy*/
