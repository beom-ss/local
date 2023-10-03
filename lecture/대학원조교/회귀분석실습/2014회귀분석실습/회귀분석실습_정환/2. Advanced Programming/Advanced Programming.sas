

/*The Beginning of Advanced Programming*/

/************************ 데이터셋************************/
libname sql 'D:\' ;

data sql.kbl1 ;
	input team $ name $ posi $ backn score freeth freetry reb assist foult time ;
	cards;
대우 김훈 F 7 24 1 2 1 4 3 38
대우 우지원 F 10 22 7 8 8 2 2 36
기아 강동희 G 5 14 5 6 2 7 0 32
기아 리드 C 22 27 5 9 19 1 4 35
삼성 문경은 F 14 37 9 11 2 3 2 40
삼성 스트릭랜 C 55 45 5 9 14 1 4 40
나래 정인교 G 5 28 8 10 2 2 2 36
나래 주희정 G 15 11 1 1 2 2 5 38
나산 조던  G 9 23 7 9 2 4 0 34
나산 이민형 F 14 14 2 3 3 3 0 36
동양 그레이 G 9 33 1 3 14 1 2 40
동양 전희철 F 13 16 3 6 8 1 2 32
;
run;

data sql.kbl2 ;
	input name $ backn suc2p try2p suc3p try3p ;
	cards;
김훈 7 10 11 1 4
우지원 10 6 10 1 4
강동희 5 3 6 1 3
리드 22 11 15 0 1
문경은 14 5 11 6 11
스트릭랜 55 20 31 0 0
정인교 5 4 7 4 12
주희정 15 5 6 0 0
조던  9 5 8 2 8
이민형 14 3 6 2 5
그레이 9 14 18 1 3
전희철 13 2 7 3 6
;
run ;

data sql.kbl3 ;
	input team $ name $ posi $ backnum score freeth freetry reb assist foul time ;
	cards;
대우 데이비스 F 44 21 1 2 7 2 1 35
대우 우지원 F 10 22 3 4 3 2 4 37
기아 허재 G 9 24 4 4 7 2 3 38
기아 김영만 F 11 18 4 4 3 3 2 36
삼성 문경은 F 14 16 9 11 5 4 2 40
삼성 스트릭랜 C 55 27 5 5 12 0 1 34
나래 장윤섭 F 13 18 3 3 6 1 3 27
나래 윌리포드 C 22 22 1 4 16 1 3 38
나산 조던 G 9 28 5 13 3 3 0 40
나산 이민형 F 14 21 1 1 5 0 3 38
동양 그레이 G 9 21 2 4 3 2 4 38
동양 김병철 G 10 23 5 6 8 6 3 40
;
run ;

/************************ 데이터셋************************/

/*sql을 사용할 경우*/  /*page 04*/
proc sql ; 
    create table sql.sumscore_1 as 
	select team, sum(score) as totscore from sql.kbl1
	where posi="G"
	group by team
	order by totscore ;
quit ;

/*기존의 sas 프로그램*/  /*page 05*/
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


/* ********************** SQL 기본 사용 ********************** */

/*select문*/  /*page 07*/   /* 주석은 해당 위치에서 왼쪽 ctrl + 오른쪽 /키 , 주석해제는 해당 위치에서 왼쪽 ctrl + 왼쪽 shift + 오른쪽 /키 */
proc sql;
	create table table1 as 
	select * from sql.kbl1 ;  /*모든 변수 선택*/
quit;
proc sql;
	create table table1 as
	select team, name        /*일부 변수만 선택*/
	from sql.kbl1;               
quit;

/* distinct옵션에 의해 중복되는 행을 제거가능 */  /*page 08*/
proc sql;
	create table table2 as
/*	select team, posi*/
	select distinct team, posi
	from sql.kbl1;
quit;

/*정렬*/  /*page 09*/
proc sql;
	create table table3 as
	select name, posi, score from sql.kbl1 ;
quit;

proc sql;
	create table table3 as
	select name, posi, score from sql.kbl1
	order by posi, score;
quit;

/*요약통계량*/  /*page 10*/
proc sql;
	create table table4 as
	select posi, avg(freeth/freetry*100) as avgper format=4.1 label='평균 자유투 성공률'
	from sql.kbl1
	group by posi;
quit;

proc sql;
	create table table5 as
	select posi, count(posi) as countnum label='포지션별 선수 수' 
	from sql.kbl1
	group by posi;
quit;

/*조건문*/  /*page 11*/
proc sql;
	create table table6 as
	select posi, name, (freeth/freetry*100) as per  format=4.1 label='자유투 성공률'
	from sql.kbl1
	where posi='G'
	order by per ;
quit;

proc sql;
	create table table7 as
	select posi, name, (freeth/freetry*100) as per  format=4.1 label='자유투 성공률'
	from sql.kbl1
	where posi='G' and calculated per > 70
	order by per ;
quit;
/* 새로 계산된 변수를 조건문에 사용할 경우, 변수 앞에 calculated 를 써줘야 인식됨.*/

proc sql;
	create table table8 as
	select team, avg(freeth/freetry*100) as avgper  format=4.1 label='평균 자유투 성공률'
	from sql.kbl1 
	where posi='G' 
	group by team 
	having avgper >70 ;  
quit;
/* 요약통계량을 사용할 경우에는 calculated 변수 구문이 통하지 않으므로 대신 having을 조건문으로 사용*/


/* ********************** 데이터의 결합 ********************** */

/*inner join의 예*/  /*page 19*/
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

/*4가지 join을 비교*/
/*이해를 돕기 위해 먼저 정렬*/
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
