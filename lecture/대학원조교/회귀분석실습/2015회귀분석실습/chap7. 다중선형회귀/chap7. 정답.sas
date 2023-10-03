/*1*/
data fish;
	set sashelp.fish;
	if species="Perch";
run;

/*2*/
proc reg data=fish plots=none;
	model weight=length1 length2 length3 height width;
run;

/*3*/
data add2;
	input length1-length3 height width;
	cards;
15 20 20 5 3
;
run;

data fish2;
	set add2 fish;
run;

proc reg data=fish2 plots=none;
	model weight=length1 length2 length3 height width / cli clm;
run;

/*4*/
proc reg data=fish plots=none;
	model weight=height width;
	test height=0;
run;

/*5*/
proc reg data=fish plots=none;
	model weight=length2 length3 height width;
	test length2=length3, length2+length3=20;
	test length2=length3=10;
run;
