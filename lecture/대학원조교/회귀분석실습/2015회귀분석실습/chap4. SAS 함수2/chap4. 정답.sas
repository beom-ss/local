
/*1��*/
data class;
	set sashelp.class;
	if sex="��" then do;
			height=height*1.2;
			weight=weight*1.1;
			end;
	else do;
			height=height*0.9;
			weight=weight*0.8;
			end;
run;
/*2��*/
data fish(keep=species length1-length3 total);
	set sashelp.fish;
	array length{3} length1-length3;
	total=0;
	do i=1 to 3;
		total=total+length{i};
	end;
	label species='����'
			length1='����1'
			length2='����2'
			length3='����3'
			total='����';
run;

/*3��*/
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
