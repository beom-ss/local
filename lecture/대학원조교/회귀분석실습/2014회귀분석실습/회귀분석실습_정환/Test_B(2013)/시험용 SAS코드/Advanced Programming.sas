

/*The Beginning of Advanced Programming*/

/************************ �����ͼ�************************/
libname sql 'D:\' ;

data sql.kbl1 ;
	input team $ name $ posi $ backn score freeth freetry reb assist foult time ;
	cards;
��� ���� F 7 24 1 2 1 4 3 38
��� ������ F 10 22 7 8 8 2 2 36
��� ������ G 5 14 5 6 2 7 0 32
��� ���� C 22 27 5 9 19 1 4 35
�Ｚ ������ F 14 37 9 11 2 3 2 40
�Ｚ ��Ʈ���� C 55 45 5 9 14 1 4 40
���� ���α� G 5 28 8 10 2 2 2 36
���� ������ G 15 11 1 1 2 2 5 38
���� ����  G 9 23 7 9 2 4 0 34
���� �̹��� F 14 14 2 3 3 3 0 36
���� �׷��� G 9 33 1 3 14 1 2 40
���� ����ö F 13 16 3 6 8 1 2 32
;
run;

data sql.kbl2 ;
	input name $ backn suc2p try2p suc3p try3p ;
	cards;
���� 7 10 11 1 4
������ 10 6 10 1 4
������ 5 3 6 1 3
���� 22 11 15 0 1
������ 14 5 11 6 11
��Ʈ���� 55 20 31 0 0
���α� 5 4 7 4 12
������ 15 5 6 0 0
����  9 5 8 2 8
�̹��� 14 3 6 2 5
�׷��� 9 14 18 1 3
����ö 13 2 7 3 6
;
run ;

data sql.kbl3 ;
	input team $ name $ posi $ backnum score freeth freetry reb assist foul time ;
	cards;
��� ���̺� F 44 21 1 2 7 2 1 35
��� ������ F 10 22 3 4 3 2 4 37
��� ���� G 9 24 4 4 7 2 3 38
��� �迵�� F 11 18 4 4 3 3 2 36
�Ｚ ������ F 14 16 9 11 5 4 2 40
�Ｚ ��Ʈ���� C 55 27 5 5 12 0 1 34
���� ������ F 13 18 3 3 6 1 3 27
���� �������� C 22 22 1 4 16 1 3 38
���� ���� G 9 28 5 13 3 3 0 40
���� �̹��� F 14 21 1 1 5 0 3 38
���� �׷��� G 9 21 2 4 3 2 4 38
���� �躴ö G 10 23 5 6 8 6 3 40
;
run ;

/************************ �����ͼ�************************/

/*sql�� ����� ���*/  /*page 04*/
proc sql ; 
    create table sql.sumscore_1 as 
	select team, sum(score) as totscore from sql.kbl1
	where posi="G"
	group by team
	order by totscore ;
quit ;

/*������ sas ���α׷�*/  /*page 05*/
proc summary data=sql.kbl1 ;
	where posi="G" ;
	class team ;
	var score ;
	output out=sql.sumscore_2 sum=totscore ;
run ;
proc sort data=sql.sumscore_2  ;
	by totscore ;
run ;
data sql.sumscore_3 ;
   set sql.sumscore_2 ;
   if team ='' then delete;
   drop _type_  _freq_ ;
run;


/* ********************** SQL �⺻ ��� ********************** */

/*select��*/  /*page 07*/   /* �ּ��� �ش� ��ġ���� ���� ctrl + ������ /Ű , �ּ������� �ش� ��ġ���� ���� ctrl + ���� shift + ������ /Ű */
proc sql;
	create table table1 as 
	select * from sql.kbl1 ;  /*��� ���� ����*/
quit;
proc sql;
	create table table1 as
	select team, name        /*�Ϻ� ������ ����*/
	from sql.kbl1;               
quit;

/* distinct�ɼǿ� ���� �ߺ��Ǵ� ���� ���Ű��� */  /*page 08*/
proc sql;
	create table table2 as
/*	select team, posi*/
	select distinct team, posi
	from sql.kbl1;
quit;

/*����*/  /*page 09*/
proc sql;
	create table table3 as
	select name, posi, score from sql.kbl1 ;
quit;

proc sql;
	create table table3 as
	select name, posi, score from sql.kbl1
	order by posi, score;
quit;

/*�����跮*/  /*page 10*/
proc sql;
	create table table4 as
	select posi, avg(freeth/freetry*100) as avgper format=4.1 label='��� ������ ������'
	from sql.kbl1
	group by posi;
quit;

proc sql;
	create table table5 as
	select posi, count(posi) as countnum label='�����Ǻ� ���� ��' 
	from sql.kbl1
	group by posi;
quit;

/*���ǹ�*/  /*page 11*/
proc sql;
	create table table6 as
	select posi, name, (freeth/freetry*100) as per  format=4.1 label='������ ������'
	from sql.kbl1
	where posi='G'
	order by per ;
quit;

proc sql;
	create table table7 as
	select posi, name, (freeth/freetry*100) as per  format=4.1 label='������ ������'
	from sql.kbl1
	where posi='G' and calculated per > 70
	order by per ;
quit;
/* ���� ���� ������ ���ǹ��� ����� ���, ���� �տ� calculated �� ����� �νĵ�.*/

proc sql;
	create table table8 as
	select team, avg(freeth/freetry*100) as avgper  format=4.1 label='��� ������ ������'
	from sql.kbl1 
	where posi='G' 
	group by team 
	having avgper >70 ;  
quit;
/* �����跮�� ����� ��쿡�� calculated ���� ������ ������ �����Ƿ� ��� having�� ���ǹ����� ���*/


/* ********************** �������� ���� ********************** */

/*inner join�� ��*/  /*page 19*/
proc sql;
	create table join_1A as
	select kbl1.team, kbl1.name, kbl1.posi, kbl2.suc3p, 
			  kbl1.score as score1, kbl3.score as score2
	from sql.kbl1, sql.kbl2, sql.kbl3
	where kbl1.name = kbl2.name = kbl3.name and kbl3.posi="G" ;
quit;
/*page20*/
proc sql;
	create table join_1B as
	select t1.team, t1.name, t1.posi, t2.suc3p,
			  t1.score as score1, t3.score as score2
	from sql.kbl1 as t1, sql.kbl2 as t2, sql.kbl3 as t3 
	where t1.name = t2.name = t3.name and t3.posi="G" ;
quit;

/*4���� join�� ��*/
/*���ظ� ���� ���� ���� ����*/
proc sort data=sql.kbl1;
	by name;
run;
proc sort data=sql.kbl3;
	by name;
run;

/*1.Inner join*/  /*page 21*/
proc sql;
	create table join_2A as
	select t1.name, t1.posi, t1.reb as reb1, t3.reb as reb2
	from sql.kbl1 as t1, sql.kbl3 as t3
	where t1.name = t3.name;
quit;

/*2.Left join*/  /*page 22*/
proc sql;
	create table join_2B as
	select t1.name, t1.posi, t1.reb as reb1, t3.reb as reb2
	from sql.kbl1 as t1 left join sql.kbl3 as t3
	on t1.name = t3.name;
quit;

/*3.Right join*/  /*page 23*/
proc sql;
	create table join_2C as
	select t3.name, t1.posi, t1.reb as reb1, t3.reb as reb2
	from sql.kbl1 as t1 right join sql.kbl3 as t3
	on t1.name = t3.name;
quit;

/*4.Outer join*/  /*page 24*/
proc sql;
	create table join_2D as
	select t1.name, t1.posi, t1.reb as reb1, t3.reb as reb2
	from sql.kbl1 as t1 full join sql.kbl3 as t3
	on t1.name = t3.name;
quit;
/*page 25*/
proc sql;
	create table join_2D_rep as
	select coalesce(t1.name, t3.name) as name, t1.posi, t1.reb as reb1, t3.reb as reb2
	from sql.kbl1 as t1 full join sql.kbl3 as t3
	on t1.name = t3.name;
quit;


/*The End of Advanced Programming*/
