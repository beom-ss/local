/*6��*/
/*2 page*/
data bacteria;
	infile "D:\���п� �ڷ�\ȸ�ͺм��ǽ�\2015ȸ�ͺм��ǽ�\chap10. ��Ÿ ȸ��\bacteria.txt" expandtabs;
	input t n;
run;
/*�⺻ �� ����*/
proc reg data=bacteria plots=none;
	model n=t;
	output out=bacteria_out student=ri;
run;

/*3 page*/
/*n�� t�� �������ٴ� �ణ�� �������� �ִ� ������ �Ǵ�*/
/*������ ���캻 ��� �߼��� �������� Ȯ��*/
symbol v=dot h=1;
proc gplot data=bacteria_out;
	plot n*t;
	plot ri*t;
run;
goption reset=all;


/*4 page*/
/*�α׺�ȯ*/
data bacteria2;
	set bacteria;
	lnn=log(n);
run;
/*�α׺�ȯ ����*/
proc reg data=bacteria2 plots=none;
	model lnn=t;
	output out=bacteria2_out student=ri;
run;

/*5 page*/
/*log(n)�� t������ ���谡 ������ �̷�*/
/*��ȯ �� ���� Ȯ��->������ �� ��������*/
symbol v=dot h=1;
proc gplot data=bacteria2_out;
	plot lnn*t;
	plot ri*t;
run;
goption reset=all;


/*6 page*/
data industrial;
	infile "D:\���п� �ڷ�\ȸ�ͺм��ǽ�\2015ȸ�ͺм��ǽ�\chap10. ��Ÿ ȸ��\industrial.txt" expandtabs firstobs=2;
	input row X Y;
run;
/*�⺻ȸ������*/
proc reg data=industrial plots=none;
	model Y=X;
	output out=industrial_out student=ri;
run;

/*7 page*/
/*�̺л꼺�� �������� �ľ�*/
symbol v=dot h=1;
proc gplot data=industrial_out;
	plot y*x;
	plot ri*x;
run;
goption reset=all;

/*8 page*/
/*����ġ�� �ֱ����� ���� ����*/
data industrial2;
	set industrial;
	Y_X=Y/X;
	one_X=1/X;
	X2=X**2;
	one_X2=1/X2;
run;
/*������ ���� �𵨸� ����*/
proc reg data=industrial2 plots=none;
	model Y_X=one_X;
	output out=industrial2_out student=ri;
run;

/*9 page*/
/*������ ���� �̺л꼺�� �ؼҵ� ���� Ȯ��*/
symbol v=dot h=1;
proc gplot data=industrial2_out;
	plot ri*one_X;
run;
goption reset=all;

/*10 page*/
/*weighted reg�� ���ؼ��� ���� ����*/
proc reg data=industrial2 plots=none;
	weight one_X2;
	model Y=X;
run;
quit;

/*11 page*/
/*�̺л꼺�� �ؼ��ϴ� ������� �����װ� log��ȯ�� ���*/
data industrial3;
	set industrial;
	lnY=log(Y);
	X2=X**2;
run;
/*�Ϲ� log ��ȯ ����*/
proc reg data=industrial3 plots=none;
	model lnY=X;
	output out=industrial3_out student=ri;
run;

/*12 page*/
/*log��ȯ �Ŀ��� �̺л꼺�� �����ϴ� ���� Ȯ��*/
symbol v=dot h=1;
proc gplot data=industrial3_out;
	plot lnY*X;
	plot ri*X;
run;

/*13 page*/
/*������ �߰�*/
proc reg data=industrial3 plots=none;
	model lnY=X X2;
	output out=industrial4_out p=pred student=ri;
run;

/*14-15 page*/
/*������ �߰� �� �̺л꼺�� �ؼҵ� ���� Ȯ��*/
symbol v=dot h=1;
proc gplot data=industrial4_out;
	plot ri*pred;
	plot ri*X;
	plot ri*X2;
run;




/*7��*/

/*16 page*/
data education;
	infile "D:\���п� �ڷ�\ȸ�ͺм��ǽ�\2015ȸ�ͺм��ǽ�\chap10. ��Ÿ ȸ��\education.txt" expandtabs firstobs=2;
	input State$ Y X1 X2 X3 Region;
	id=_n_;
run;
/*�Ϲ� ���� ����*/
proc reg data=education plots=none;
	model Y=X1 X2 X3;
	output out=education_out r=ei p=pred student=ri 
						cookd=cookd DFFITS=DFFITS h=hi;
run;
/*�׶��� plot�� ���캻 ��� �̺л꼺 ����*/
symbol v=dot h=1;
proc gplot data=education_out;
	plot ri*pred / haxis=190 to 490 by 50;
	plot ri*Region;
run;
/*X1�� ���� Ư�� �̺л꼺�� ���ϰ� ��Ÿ��*/
proc gplot data=education_out;
	plot ri*X1;
	plot ri*X2;
	plot ri*X3;
run;
/*Ư�̰� ����*/
proc gplot data=education_out;
	plot cookd*id;
	plot DFFITS*id;
	plot hi*id;
run;


/*Ư�̰� ���� �� ȸ�ͺм�*/
data education2;
	set education;
	if state='AK' then delete;
run;

proc reg data=education2 plots=none;
	model Y=X1 X2 X3;
	output out=education2_out r=ei p=pred student=ri
							cookd=cookd DFFITS=DFFITS h=hi;
run;
/*Ư�̰� ���� �Ŀ��� ��л꼺�� �������� ����*/
proc gplot data=education2_out;
	plot ri*pred;
	plot ri*Region;
run;
/* Ư�̰� ���� ���� ��
proc gplot data=education2_out;
	plot ri*X1;
	plot ri*X2;
	plot ri*X3;

	plot cookd*id / vaxis=0 to 3 by 1;
	plot DFFITS*id / vaxis=-1 to 4 by 1;
	plot hi*id / vaxis=0 to 0.46 by 0.02;
run;
*/

/*�����ּ������� ���� ���߰� ���*/
data edu_weight;
	set education2_out;
	ei2=ei**2;
run;
proc means data=edu_weight noprint;
	by region;
	var ei2;
	output out=edu_weight2 sum=ei2_sum;
run;
data edu_weight2;
	set edu_weight2;
	sigma2=ei2_sum/(_FREQ_-1);
	rename _FREQ_=n;
run;
proc means data=edu_weight noprint;
	var ei2;
	output out=edu_weight3 sum=ei2_sum_all;
run;
data edu_weight3;
	set edu_weight3;
	ei2_stand=ei2_sum_all/_FREQ_;
	drop _FREQ_;
run;
data edu_weight4;
	merge edu_weight2 edu_weight3;
	by _TYPE_;
	cj2=sigma2/ei2_stand;
	keep Region n sigma2 cj2;
run;
proc print data=edu_weight4;
run;

/* sql���� �̿��� �����ּ������� ���߰� ���
proc sql;
	create table test as
	select region, count(region) as n, sum(ei**2) as ei2, sum(ei**2)/(count(region)-1) as sigma2, 
				(select sum(ei**2)/count(region) from education2_out) as ei2_stand
	from education2_out
	group by region;

	create table test2 as
	select region, n, sigma2, sigma2/ei2_stand as cj2
	from test;
quit;
*/

/*����ġ�� �̿��Ͽ� weighted regression�� ����*/
data education3;
	merge education2 edu_weight4(keep=region cj2);
	by region;
	one_cj2=1/cj2;
run;

proc reg data=education3 plots=none;
	weight one_cj2;
	model Y=X1 X2 X3;
	output out=education3_out p=pred student=ri;
run;
/*����ġȸ�͸� ���ս�Ų �� ��л꼺�� �����ϴ� ���� Ȯ��*/
symbol v=dot h=1;
proc gplot data=education3_out;
	plot ri*pred;
	plot ri*Region;
run;



/*9��*/
data import;
	infile "D:\���п� �ڷ�\ȸ�ͺм��ǽ�\2015ȸ�ͺм��ǽ�\chap10. ��Ÿ ȸ��\import.txt" expandtabs firstobs=2;
	input YEAR IMPORT DOPROD STOCK CONSUM;
	id=_N_;
run;

/*���߰������� �ִ°�� ȸ�ͺм����� �߻��ϴ� ���� �ľ�*/
/*Rsquare�� �ſ� ������ t���� ����->���߰����� �ǽ�*/
proc reg data=import plots=none;
	model IMPORT=DOPROD STOCK CONSUM / vif;
	output out=import_out student=ri;
run;

/*�����÷��� ������ ��Ÿ��������->������ ����� ���� ����*/
symbol i=join v=dot h=1;
proc gplot data=import_out;
	plot ri*id / href=12;
run;

/*������ ����� 59�⵵������ �����͸� ������ �ٽ��ѹ� �𵨸�*/
proc reg data=import plots=none;
	where year<=59;
	model IMPORT=DOPROD STOCK CONSUM / vif;
	output out=import2_out student=ri;
run;
/*������ ������ ������ ���� Ȯ��*/
symbol i=join v=dot h=1;
proc gplot data=import2_out;
	plot ri*id;
run;

/*CONSUM�� DOPROD ������ ���� Ȯ��*/
/*����� ������ ���谡 ������ Ȯ��->���߰����� ����*/
proc reg data=import plots=none;
	where year<=59;
	model CONSUM=DOPROD;
run;

/*���л� ��İ� ������ ��� ���ϱ�*/
proc corr data=import cov noprob outp=import_corr;
	where year<=59;
	var DOPROD STOCK CONSUM;
run;

/*�߽�ȭ�� ô��ȭ ->ǥ��ȭ���*/
proc standard data=import mean=0 std=1 out=import_stand;
	where year<=59;
	var IMPORT DOPROD STOCK CONSUM;
run;
/*������ ��*/
proc print data=import;
	where year<=59;
	var IMPORT DOPROD STOCK CONSUM;
run;
proc print data=import_stand;
	var IMPORT DOPROD STOCK CONSUM;
run;

/*ǥ��ȭ��Ų �����͸� ���� Principal components*/
proc princomp data=import_stand out=import_pc;
	var DOPROD STOCK CONSUM;
run;
proc print data=import_pc;
	var prin1-prin3;
run;



/*10��*/
/*ǥ��ȭ��Ų �� ����*/
proc reg data=import_stand plots=none;
	model IMPORT=DOPROD STOCK CONSUM;
run;
/*PC���� ���� ����*/
proc reg data=import_pc plots=none;
	model IMPORT=Prin1 Prin2 Prin3;
run;


/*11��*/
data supervisor;
	infile "D:\���п� �ڷ�\ȸ�ͺм��ǽ�\2015ȸ�ͺм��ǽ�\chap10. ��Ÿ ȸ��\supervisor.txt" expandtabs firstobs=2;
	input Y X1-X6;
run;
/*selection����� ���� �� ��*/
proc reg data=supervisor plots=none;
	model Y=X1-X6 / selection=forward;
	model Y=X1-X6 / selection=backward;
	model Y=X1-X6 / selection=stepwise;
run;

/*CP���� ���� selection*/
proc reg data=supervisor plots=none outest=supervisor_est;
	model Y=X1-X6 / selection=CP RMSE CP AIC BIC ;
run;
quit;


/*12��*/
data financial;
	infile "D:\���п� �ڷ�\ȸ�ͺм��ǽ�\2015ȸ�ͺм��ǽ�\chap10. ��Ÿ ȸ��\financial.txt" expandtabs firstobs=2;
	input Y X1 X2 X3;
	id=_n_;
run;

/*������ƽ ȸ�� ����*/
proc logistic data=financial;
	model Y(event='1')=X1 X2 X3;
	output out=financial_out resdev=resdev dfbetas=dfbetas difchisq=difchisq h=hi p=pred;
run;

/*������ƽ ȸ���� index plot*/
symbol i=none v=dot h=1;
proc gplot data=financial_out;
	plot resdev*id;
	plot dfbetas*id;
	plot difchisq*id;
run;

/*������ƽ ȸ���� selection*/
proc logistic data=financial;
	model Y(event='1')=X1 X2 X3 / selection=stepwise;
proc logistic data=financial;
	model Y(event='1')=X1 X2 X3 / selection=backward;
proc logistic data=financial;
	model Y(event='1')=X1 X2 X3 / selection=forward;
run;
