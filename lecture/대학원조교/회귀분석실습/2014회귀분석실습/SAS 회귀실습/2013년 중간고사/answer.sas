proc sql;
    select grade,count(grade) as count, avg(kor) as avg
    from score3
    group by grade
;
quit;
data score;
	infile 'C:\Users\kuksunghee\Desktop\test1.txt';
	input no c1 c2 c3;
run;

proc means data=score;
	var c1 c2 c3;
run;
proc means data=score;
run;

data score;
	set score;
	max=max(c1,c2,c3);
run;


data score2;
	set score;
	kor=c1; output;
	kor=c2; output;
	kor=c3; output;

	keep kor;
run;

proc means data=score2;
	var kor;
run;

data score3;
	set score2;
	if kor>=80 then grade='A';
	else if kor>=50 then grade='B';
	else grade='C';
run;


proc sql;
create table score4 as
	select grade,count(grade) as count, avg(kor) as avg
	from score3
	group by grade
;
quit;

proc sort data=score3;
	by grade;
run;

proc sql ;
create table score3 as
	select *
	from score3
	order by grade;
quit;

libname data 'C:\Users\kuk\Desktop\data';
/* beta0, beta1±¸ÇÏ±â */
data testset;
	set data.testset;
run;


proc reg data=testset;
	model brain_weight=body_weight;
run;

proc sql;
	create table result as
	select brain_weight as y, body_weight as x, avg(y) as ybar, avg(x) as xbar,
			(y-avg(y))**2 as sy, (x-avg(x))**2 as sx, (y-avg(y))*(x-avg(x)) as xy
	from testset;
quit;

proc sql; 
	create table result2 as
	select distinct sum(sy) as syy, sum(sx) as sxx, sum(xy) as sxy, ybar-(sum(xy)/sum(sx))*xbar as beta0, (sum(xy)/sum(sx)) as beta1
	from result;
quit;
 

