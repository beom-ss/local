data table319;
infile "C:\Users\student\Desktop\ciga.txt";
input age hs income black female price sales;
run;

/*a��*/
proc reg data=table319;
model sales=age hs income black female price ;
quit;

proc reg data=table319;
model sales=age hs income black price ;
quit;

/*b��*/
proc reg data=table319;
model sales=age hs income black female price ;
quit;

proc reg data=table319;
model sales=age income black price ;
quit;
/*c��*//*23.18059 +- t*28.17396*/
data tvalue;
alpha = 0.05 ; df=51-1-6;
t=tinv(1-alpha/2,df);
run;

/*d��*//*0.2265*/
proc reg data=table319;
model sales=age black female price ;
quit;

/*e��*/ /*0.3032*/
proc reg data=table319;
model sales=age income  price ;
quit;

/*f��*//* 0.1063*/
proc reg data=table319;
model sales=income ;
quit;

/*����ȣ - ������ copy*/
