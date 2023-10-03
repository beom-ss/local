
/***************************** 이론편 *****************************/
data quartet;
	infile"D:\quartet.txt" expandtabs;
	input y1 x1 y2 x2 y3 x3 y4 x4;
run;

/*상관계수 확인*/
proc corr data=quartet cov; var y1 x1; run;
proc corr data=quartet cov; var y1 x1; run;
proc corr data=quartet cov; var y1 x1; run;
proc corr data=quartet cov; var y1 x1; run;

/*회귀모형 적합*/
proc reg data=quartet ;
	model y1 = x1 ;
	model y2 = x2 ;
	model y3 = x3 ;
	model y4 = x4 ;
quit;

/*산점도*/
proc plot data=quartet ;
	plot y1*x1 / vpos=30 hpos=60;
run;
proc plot data=quartet vpercent=50 hpercent=50;
	plot y1*x1 ; 	plot y2*x2 ; 	plot y3*x3 ; 	plot y4*x4 ;
run;

symbol1 color=black interpol=none value=dot;
symbol2 color=black interpol=rl value=none;
proc gplot data=quartet ;
	plot y1*x1=1 y1*x1=2 / overlay ;
	plot y2*x2=1 y1*x1=2 / overlay ;
	plot y3*x3=1 y1*x1=2 / overlay ;
	plot y4*x4=1 y1*x1=2 / overlay ;
run;quit;



/*예제 : computer repair*/
data repair;
	infile"D:\repair.txt";
	input minutes units;
run;

proc plot data=repair ;
	plot minutes * units /vpos=30 hpos=60 ;
run;


proc corr data=repair cov;
run;

proc reg data=repair ;
	model minutes = units ;
quit;

proc sql;
	create table temp1 as
	select minutes as y,	 units as x, 
	          avg(y) as ybar, avg(x) as xbar,  
              y-avg(y) as y_ybar, x-avg(x) as x_xbar,
              (y-avg(y))**2 as y_ybar2, 		
              (x-avg(x))**2 as x_xbar2,
              (y-avg(y))*(x-avg(x)) as xy
	from repair;
quit;
proc sql;
	create table temp2 as
	select distinct(ybar), sum(xy) as sxy, sum(x_xbar2) as sxx, 
              ybar-(sum(xy)/sum(x_xbar2) )*xbar as beta0, sum(xy)/sum(x_xbar2) as beta1
	from temp1;
quit;

data tvalue;
	alpha=0.05;
	df=(14-2);
	t=tinv(1-alpha/2,df);   
	put t=;
run;


proc reg data=repair;
	model minutes = units/i ; 
quit;
proc reg data=repair;
	model minutes = units/r ;   
quit;
proc reg data=repair;
	model minutes = units/influence;   
quit;
proc reg data=repair;
	model minutes = units/p;   
quit;
proc reg data=repair;
	model minutes = units/clm cli ;  
quit;
proc reg data=repair;
	model minutes = units/clm cli alpha=0.1; 
quit;

proc reg data=repair;
	model minutes = units / noint ;
quit;

proc univariate data=repair /*freq*/;
	var minutes units ;
	output out=result n=mean_m mean_u;
/*	probplot minutes;*/
run;


/***************************** 실천편 *****************************/
data news;
	infile"D:\newspapers.txt" dlm="," ;
	length newspaper$ 30 ;
	input newspaper$ daily sunday ;
run;
 

/*(a)*/
proc plot data=news;
	plot sunday * daily;
run;  

/*(b)*/
proc reg data=news;
	model sunday =  daily;
quit; 


/*(c)*/
data tvalue;
alpha=0.05;
df=34-2;
t=tinv(1-alpha/2,df);
put t= ;
run; 


/*(f), (g)*/
proc reg data=news;
	model sunday =  daily / clm cli ;
quit; 
proc print data=news;
run;
data news2;  
	input daily;
	cards;
500
2000
;
run;

data news3;  
	set news news2;
run;

proc reg data=news3; 
	model sunday=daily / clm cli;
	output out = temp p=yhat U95M=C_upper L95M=C_lower U95=P_upper L95=P_lower;
quit;

/* (h)*/
proc sql;
	create table interval as
	select newspaper, daily, sunday, yhat, (C_upper - C_lower) as C_interval, (P_upper - P_lower) as P_interval
	from temp;
quit;


/*그래프로 표현*/
goption reset=all ;                                      /*gplot의 옵션 초기화*/
symbol1 value=dot    color=black   interpol=none  ci=black   line=2 width=1 ;    /*관측치만  표시*/  
symbol2 value=none color=blue interpol=rlclm95    ci=blue   line=2  width=1 ;  /*95%신뢰구간 표시*/
symbol3 value=none color=red interpol=rlcli95    ci=red   line=2  width=1 ;       /*95%예측구간 표시*/
proc gplot data=news  ;                         
	plot  sunday*daily=1 sunday*daily=2 sunday*daily=3 / overlay ; 
run ; quit ;
