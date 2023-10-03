
/*1번*/
data class;
	set sashelp.class;
	if sex="남" then do;
			height=height*1.2;
			weight=weight*1.1;
			end;
	else do;
			height=height*0.9;
			weight=weight*0.8;
			end;
run;
/*2번*/
data fish(keep=species length1-length3 total);
	set sashelp.fish;
	array length{3} length1-length3;
	total=0;
	do i=1 to 3;
		total=total+length{i};
	end;
	label species='종류'
			length1='길이1'
			length2='길이2'
			length3='길이3'
			total='총합';
run;

/*3번*/
data normal;
	do x=-5 to 15;
	nor_pdf=pdf("normal",x,5,4);
	nor_cdf=cdf("normal",x,5,4);
	output;
	end;
run;

proc gplot data=normal;
	symbol1 i=spline v=none c=blue;
	symbol2 i=spline v=none c=red;
	plot (nor_pdf nor_cdf)*x / overlay legend;
run;
