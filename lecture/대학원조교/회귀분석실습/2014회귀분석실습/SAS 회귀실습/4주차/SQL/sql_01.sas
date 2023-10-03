libname sql 'C:\Users\kuksunghee\Desktop\sqlex';

/*테이블의 전체 칼럼 선택*/
proc sql;
select *
from sql.kbl1;
quit;



/*테이블의 일부 칼럼만 선택*/
/*테이블의 칼럼 정보를 로그창에 표시*/
proc sql;
describe table sql.kbl1;
select team,score
from sql.kbl1;
quit;


/*계산된 새로운 칼럼 생성*/
proc sql;
create table sql.aa as 
select team,score,time*60 as time2,TODAY() as today
from sql.kbl1;
quit;

/*날짜 확인*/
data aa1;
set sql.aa;
format today yymmdd10.;
run;


/* 조건부를 이용한 계산된 새로운 칼럼 생성 (case 이용) */
proc sql;
select team,score,posi,backn,
	case(posi)
		when('F') then backn+1
		when('G') then backn+2
		else backn
	end as newbackn
from sql.kbl1;
quit;


/* 중복 행 제거 */
proc sql;
	create table sql.team2 as
	/*	select team,posi*/
	select distinct team,posi
	from sql.kbl1;
quit;

proc sql;
	create table sql.team3 as
	select name,posi,score
	from sql.kbl1;
quit;


/*order by절을 이용하여 데이터 정렬하기*/
proc sql;
	create table sql.team3 as
	select name,posi,score
	from sql.kbl1;
	order by name /*desc*/;
quit;

/* group by절을 이용하여 데이터 그룹화하기*/
proc sql;
	create table posi2 as
	select posi,avg(freeth) as avgposi
	label='평균 득점'
	from sql.kbl1
	group by posi;
quit;

proc sql;
	create table posi3 as
	select posi,count(freetry) as countposi
	label='자유투 시도횟수'
	from sql.kbl1
	group by posi;
quit;

/* having절을 이용하여 조건주기*/
proc sql;
	create table posi4 as
	select posi,avg(freeth) as avgposi
	label='평균 득점'
	from sql.kbl1
	group by posi
	having avgposi >=4.5;
quit;

/* where문을 이용하여 조건주기*/
proc sql;
	create table posi5 as
	select team,avg(freeth) as avgposi
	label='평균 득점'
	from sql.kbl1
	where posi='G'
	group by team;
quit;
