proc sql;
    create table dataset21 as
    select team, name, posi,
              (freeth*1 + suc2p*2 + suc3p*3) as score label='ÃÑ µæÁ¡',
              (freeth*1 + suc2p*2 + suc3p*3)/(freetry+try2p+try3p) as exact format 4.2 label='½¸ Á¤È®µµ'
    from MIDTEST.basket;
quit;

/***************************************************************************************************/
/*¹®Á¦1 : ¼ºÀû  µ¥ÀÌÅÍ*/
/***************************************************************************************************/
/*1¹ø Á¤´ä ÄÚµå*/
data temp_dataset1;
	input  name	$ id exam1 exam2 hw check;
	cards;
Tom 1001 83.11 80.11 9 10 
Will 1002 52.33 55.33 7 6 
Gray 1003 60.22 61.22 7	9	
Maria 1004 92.33 95.33 10 10	
Julia 1005 74.77 73.22 8	9	
;
run;
data dataset1;
	set temp_dataset1;
	score = exam1*0.3 + exam2*0.5 + hw + check ;
	if score >=90 then grade='A';
	else if score >=80 then grade='B';
	else if score >=70 then grade='C';
	else if score >=60 then grade='D';
	else grade='F';
    label exam1 = 'Áß°£°í»ç'  exam2 = '±â¸»°í»ç'    
            hw = '°úÁ¦' check = 'Ãâ¼®' score = 'ÃÖÁ¾¼ºÀû' grade = 'µî±Þ';
run; 
/***************************************************************************************************/

/***************************************************************************************************/
/*°°Àº °á°ú, ´Ù¸¥ ÄÚµåÀÇ »ç·Ê*/
/***************************************************************************************************/
data dataset1;
	set temp_dataset1;
	score = exam1*0.3 + exam2*0.5 + hw + check ;
	 label exam1 = 'Áß°£°í»ç'  exam2 = '±â¸»°í»ç'    
            hw = '°úÁ¦' check = 'Ãâ¼®' score = 'ÃÖÁ¾¼ºÀû' grade = 'µî±Þ';
	if score >=90 then grade='A';
	else if score >=80 then grade='B';
	else if score >=70 then grade='C';
	else if score >=60 then grade='D';
	else grade='F';
run; 
/***************************************************************************************************/
data dataset11;
	input  name	$ id exam1 exam2 hw check;
	score = exam1*0.3 + exam2*0.5 + hw + check ;
		else grade='F';
    label exam1 = 'Áß°£°í»ç'  exam2 = '±â¸»°í»ç'    
            hw = '°úÁ¦' check = 'Ãâ¼®' score = 'ÃÖÁ¾¼ºÀû' grade = 'µî±Þ';
	if score >=90 then grade='A';
	else if score >=80 then grade='B';
	else if score >=70 then grade='C';
	else if score >=60 then grade='D';

	cards;
Tom 1001 83.11 80.11 9 10 
Will 1002 52.33 55.33 7 6 
Gray 1003 60.22 61.22 7	9	
Maria 1004 92.33 95.33 10 10	
Julia 1005 74.77 73.22 8	9	
;
run; 
/***************************************************************************************************/

/***************************************************************************************************/
/*¹®Á¦2 : ³ó±¸ °æ±â  µ¥ÀÌÅÍ*/
/***************************************************************************************************/
/*µ¥ÀÌÅÍ ÀÐ±â*/
libname MIDTEST 'D:\MIDTEST'; 
/*°³ÀÎº° ÃÑ µæÁ¡*/  
proc sql;
	create table temp_dataset2 as
	select *, (freeth*1 + suc2p*2 + suc3p*3) as score label='ÃÑ µæÁ¡'
	from MIDTEST.basket;
quit;
 /*½¸ Á¤È®µµ*/
proc sql;
	create table dataset2 as
	select team, name, posi, score, score/(freetry+try2p+try3p) as exact format 4.2 label='½¸ Á¤È®µµ'
	from temp_dataset2 ;
quit;
/***************************************************************************************************/

/***************************************************************************************************/
/*°°Àº °á°ú, ´Ù¸¥ ÄÚµåÀÇ »ç·Ê*/
/***************************************************************************************************/
proc sql;
	create table dataset21 as
	select team, name, posi, 
              (freeth*1 + suc2p*2 + suc3p*3) as score label='ÃÑ µæÁ¡',
              (freeth*1 + suc2p*2 + suc3p*3)/(freetry+try2p+try3p) as exact format 4.2 label='½¸ Á¤È®µµ'
	from MIDTEST.basket;
quit;
/***************************************************************************************************/
proc sql;
	create table dataset211 as
	select team, name, posi, 
              (freeth*1 + suc2p*2 + suc3p*3) as score 'ÃÑ µæÁ¡',
              (freeth*1 + suc2p*2 + suc3p*3)/(freetry+try2p+try3p) as exact format 4.2 '½¸ Á¤È®µµ'
	from MIDTEST.basket;
quit;
/***************************************************************************************************/
proc sql;
	create table dataset25 as
	select team, name, posi, 
              sum(freeth*1, suc2p*2, suc3p*3) as score label='ÃÑ µæÁ¡',
              calculated score/sum(freetry, try2p, try3p) as exact format 4.2 label='½¸ Á¤È®µµ'
	from MIDTEST.basket;
quit;
/***************************************************************************************************/
proc sql;
	create table dataset26 as
	select team, name, posi, 
              sum(freeth*1, suc2p*2, suc3p*3) as score label='ÃÑ µæÁ¡',
              calculated score/(freetry+ try2p+ try3p) as exact format 4.2 label='½¸ Á¤È®µµ'
	from MIDTEST.basket;
quit;


proc sql;
	create table dataset237 as
	select team, name, posi, 
              sum(freeth*1+ suc2p*2 + suc3p*3) as score label='ÃÑ µæÁ¡',
              calculated score/(freetry+ try2p+ try3p) as exact format 4.2 label='½¸ Á¤È®µµ'
	from MIDTEST.basket;
	group by name;
quit;



/*°³ÀÎº° ÃÑ µæÁ¡*/  
proc sql;
	create table temp_dataset222 as
	select *, sum(freeth*1 + suc2p*2 + suc3p*3) as score label='ÃÑ µæÁ¡'
	from MIDTEST.basket
	group by name;
quit;
 /*½¸ Á¤È®µµ*/
proc sql;
	create table dataset234242 as
	select team, name, posi, score, sum(score/(freetry+try2p+try3p)) as exact format 4.2 label='½¸ Á¤È®µµ'
	from temp_dataset222  
	group by team, name;
quit;



/***************************************************************************************************/
proc sql;
	create table dataset22 as
	select team, name, posi, 
              sum(freeth*1, suc2p*2, suc3p*3) as score label='ÃÑ µæÁ¡',
              sum(freeth*1, suc2p*2, suc3p*3)/sum(freetry, try2p, try3p) as exact format 4.2 label='½¸ Á¤È®µµ'
	from MIDTEST.basket;
quit;
/***************************************************************************************************/
proc sql;
	create table dataset23 as
	select team, name, posi, (freeth*1 + suc2p*2 + suc3p*3) as score label='ÃÑ µæÁ¡',
                                            calculated score/(freetry+try2p+try3p) as exact format 4.2 label='½¸ Á¤È®µµ'
	from MIDTEST.basket;
quit;
proc sql;
	create table dataset22 as
	select team, name, posi, 
              sum(freeth*1, suc2p*2, suc3p*3) as score,
              sum(freeth*1, suc2p*2, suc3p*3)/sum(freetry, try2p, try3p) as exact format 4.2 
	from MIDTEST.basket;
 label score='ÃÑ µæÁ¡', exact='½¸ Á¤È®µµ';
quit;
/***************************************************************************************************/
/***************************************************************************************************/


/***************************************************************************************************/
/*°ÅÁþ ÄÚµå »ç·Ê*/
/***************************************************************************************************/
proc sql;
	create table dataset22 as
	select team, name, posi, sum(freeth*1, suc2p*2, suc3p*3) as total,
                  sum(calculated total)/sum(freetry, try2p, try3p) as exact format 4.2
				  	from MIDTEST.basket;
                  label total='ÃÑµæÁ¡';
                  label exact='ÃÑ µæÁ¡' ;
quit;
/***************************************************************************************************/
proc sql;
	create table dataset23 as
	select team, name, posi, (freeth*1 + suc2p*2 + suc3p*3) as score label='ÃÑ µæÁ¡',
                                            score/(freetry+try2p+try3p) as exact format 4.2 label='½¸ Á¤È®µµ'
	from MIDTEST.basket;
quit;
/***************************************************************************************************/
proc sql;
	create table dataset2 as
	select team, name, posi,  sum(score)/(freetry+try2p+try3p) as exact format 4.2 label='½¸ Á¤È®µµ'
	from temp_dataset2 ;
quit;
/***************************************************************************************************/

/***************************************************************************************************/
/*¹®Á¦3 : ÀÇ·á±â°ü Á¤º¸ µ¥ÀÌÅÍ*/
/***************************************************************************************************/
/*µ¥ÀÌÅÍ ÀÐ±â*/
libname MIDTEST 'D:\MIDTEST'; 
/*¿ä¾ç±â°ü º° ÀÇ»ç 1ÀÎ´ç ÁøÂûºñ Æò±Õ*/
proc sql;
	create table dataset3 as
	select distinct t1.YNO, avg(t1.MONEY/t2.DOCTOR) as AVG_MON_DOC label='Æò±Õ ÀÇ»ç 1ÀÎ´ç ÁøÂûºñ'  
	from MIDTEST.medical_a as t1, MIDTEST.medical_b as t2
	where t1.YNO = t2.YNO
	group by t1.YNO;
quit;
/***************************************************************************************************/

proc sql;
	create table dataset31 as
	select t1.YNO, avg(t1.MONEY/t2.DOCTOR) as AVG_MON_DOC label='Æò±Õ ÀÇ»ç 1ÀÎ´ç ÁøÂûºñ'  
	from MIDTEST.medical_a as t1, MIDTEST.medical_b as t2
	where t1.YNO = t2.YNO
	group by t1.YNO;
quit;


proc sql;
	create table dataset32 as
	select t2.YNO, avg(t1.MONEY/t2.DOCTOR) as AVG_MON_DOC label='Æò±Õ ÀÇ»ç 1ÀÎ´ç ÁøÂûºñ'  
	from MIDTEST.medical_a as t1, MIDTEST.medical_b as t2
	where t1.YNO = t2.YNO
	group by t2.YNO;
quit;

proc sql;
	create table dataset33 as
	select t2.YNO, sum(t1.MONEY)/sum(t2.DOCTOR) as AVG_MON_DOC label='Æò±Õ ÀÇ»ç 1ÀÎ´ç ÁøÂûºñ'  
	from MIDTEST.medical_a as t1, MIDTEST.medical_b as t2
	where t1.YNO = t2.YNO
	group by t2.YNO;
quit;

proc sql;
	create table totm as
	select yno, sum(money) as a
	from midtest.medical_a
	group by yno;
quit;
proc sql;
	create table dod as
	select *
	from midtest.medical_b;
quit;
proc sql;
	create table arg as
	select  yno, a/doctor label='Æò±ÕÀÇ»çÁøÂûºñ'
	where totm.yno=dod.yno
	from totm, dod;
	quit;



proc sql;
	create table dataset31 as
	select t1.YNO, avg(t1.MONEY/t2.DOCTOR) as AVG_MON_DOC label='Æò±Õ ÀÇ»ç 1ÀÎ´ç ÁøÂûºñ'  
	from MIDTEST.medical_a as t1, MIDTEST.medical_b as t2
	where t1.YNO = t2.YNO
	group by t1.YNO;
quit;


proc sql;
	create table me_a as
	select medical_a.yno, medical_b.doctor, medical_a.money from midtest.medical_a, midtest.medical_b
	where medical_a.yno=medical_b.yno;
quit;
proc sql;
	create table med as
	select yno, (sum(money)/doctor)/count(doctor) as sam from me_a group by yno;
proc sql;
	create table medical as
	select mean(yno) as yno1, mean(sam) as sam1 from med
	group by yno;
quit;


proc sql;
	create table table3 as 
	select medical_a.yno, sum(medical_a.money) as sum
	from midtest.medical_a;
quit ;
proc sql ;
	create table table_3 as
	select medical_a.yno , (sum/medical_b.doctor) as avg
	from table3, midtest.medical_b ;
quit ;

proc sql;
	create table table3 as 
	select medical_a.yno, sum(medical_a.money) as sum
	from midtest.medical_a
	group by medical_a.yno;
quit ;
proc sql ;
	create table table_32 as
	select table3.yno,  table3.sum/sum(medical_b.doctor) as avg
	from table3, midtest.medical_b 
	where table3.yno=medical_b.yno
	group by medical_b.yno;
quit ;



proc sql;
	create table aaa as
	select t1.yno, sum(t1.money) as asd
	from midtest.medical_A as t1
	group by t1.yno ;
quit;
proc sql ;
	create table ag as
	select t1.yno, t1.asd/sum(t2.doctor) as ff
	from aaa as t1, midtest.medical_b as t2
	where t1.yno=t2.yno
	group by t2.yno;
quit;

proc sql;
	create table three as 
	select m1.yno, m2.yno, m1.money, m2.doctor
	from midtest.medical_a as m1, midtest.medical_b as m2
	where m1.yno=m2.yno;
quit;
proc sql;
	create table three1 as
	select yno, (sum(money)/sum(doctor)) as mean
	from three
	group by yno;
quit;

proc sql;
	create table ace1234 as
	select distinct t1.YNO, (sum(t1.MONEY)/t2.DOCTOR) as AVG_MON_DOC label='Æò±Õ ÀÇ»ç 1ÀÎ´ç ÁøÂûºñ'  
	from MIDTEST.medical_a as t1, MIDTEST.medical_b as t2
	where t1.YNO = t2.YNO
	group by t1.YNO;
quit;

proc sql;
	create table dataset3343 as
	select distinct t1.YNO, sum(t1.MONEY)/sum(t2.DOCTOR) as AVG_MON_DOC label='Æò±Õ ÀÇ»ç 1ÀÎ´ç ÁøÂûºñ'  
	from MIDTEST.medical_a as t1, MIDTEST.medical_b as t2
	where t1.YNO = t2.YNO
	group by t1.YNO;
quit;

proc sql;
	create table dataset3343 as
	select distinct t1.YNO, sum(t1.MONEY)/count(t2.DOCTOR) as AVG_MON_DOC label='Æò±Õ ÀÇ»ç 1ÀÎ´ç ÁøÂûºñ'  
	from MIDTEST.medical_a as t1, MIDTEST.medical_b as t2
	where t1.YNO = t2.YNO
	group by t1.YNO;
quit;

proc sql;
	create table dataset3555 as
	select distinct t1.YNO, sum(t1.MONEY from group by t1.yno)/t2.DOCTOR as AVG_MON_DOC label='Æò±Õ ÀÇ»ç 1ÀÎ´ç ÁøÂûºñ'  
	from MIDTEST.medical_a = t1, MIDTEST.medical_b = t2
	where t1.YNO = t2.YNO ;
quit;

proc sql;
	create table dataset333 as
	select distinct YNO, avg(count(no)*money/doctor) 'Æò±Õ ÀÇ»ç 1ÀÎ´ç ÁøÂûºñ'
	from MIDTEST.medical_a , MIDTEST.medical_b 
	where MIDTEST.medical_a.yno = MIDTEST.medical_b.yno ;
quit;

proc sql;
	create table dataset444 as
	select midtest.medical_a.yno=yn1, midtest.medical_b.yno=yn2
	 		money, doctor, (money/doctor) as aw
			from midtest.medical_a, midtest.medical_b
			where yno and calculated aw on yn1=yn2
			group by yno;
quit;

proc sql;
	create table dataset33 as
	select medical_a.yno, medical_b.yno, avg(MONEY/DOCTOR) as AVG_MON_DOC label='Æò±Õ ÀÇ»ç 1ÀÎ´ç ÁøÂûºñ'  

	from MIDTEST.medical_a , MIDTEST.medical_b
		where medical_a.yno= medical_b.yno;
	quit;

proc sql;
create table mm as
select medical_a.yno as t1, medical_b.yno as y2, avg(money/doctor)  as avgper
from midtest.medical_a, midtest.medical_b
where y1=y2;
quit;




/***************************************************************************************************/
/*¹®Á¦4 : °í°´ ±¸¸Å ±â·Ï µ¥ÀÌÅÍ*/
/***************************************************************************************************/
/*µ¥ÀÌÅÍ ÀÐ±â*/
libname MIDTEST 'D:\MIDTEST'; 
/*°í°´ º° ±¸¸Å¾× Æò±Õ*/
proc sql;
	create table temp1_dataset4 as	
	select DISTINCT CUST_ID, AGE, avg(PRICE) as AVG_PRICE
	from MIDTEST.item
	group by CUST_ID;
quit;
/*¿ì¼ö °í°´¸¸ ÃßÃâ*/
proc sql;
	create table temp2_dataset4 as
	select *
	from temp1_dataset4
	where AVG_PRICE >= 30000;
quit;
/*¿ì¼ö °í°´ÀÇ ¿ä¾àÅë°è·® °è»ê*/
proc sql;
	create table dataset4 as
	select N(CUST_ID) as N_CUST label='¿ì¼ö °í°´ÀÇ ÀÎ¿ø ¼ö',  
              avg(AGE) as AVG_AGE format 4.1 label='¿ì¼ö °í°´ÀÇ Æò±Õ ¿¬·É' 
	from temp2_dataset4;
quit;
/***************************************************************************************************/



/***************************************************************************************************/
proc sql;
	create table m1 as	
	select CUST_ID, AGE, avg(PRICE) as avg_1
	from MIDTEST.item
	group by CUST_ID, age 
	having avg_1>=30000;
quit;
proc sql;
	create table m2 as
	select count(CUST_ID) as N_CUST label='¿ì¼ö °í°´ÀÇ ÀÎ¿ø ¼ö',  
              avg(AGE) as AVG_AGE format 4.1 label='¿ì¼ö °í°´ÀÇ Æò±Õ ¿¬·É' 
	from m1;
quit;


proc sql;
	create table table4 as	
	select CUST_ID, AGE, sum(PRICE) as sumprice
	from MIDTEST.item
	group by CUST_ID ;
quit;
proc sql;
	create table table5 as
	select count(CUST_ID) as N_CUST label='¿ì¼ö °í°´ÀÇ ÀÎ¿ø ¼ö',  
              avg(AGE) as AVG_AGE format 4.1 label='¿ì¼ö °í°´ÀÇ Æò±Õ ¿¬·É' 
	from table4 
	having sumprice >= 30000;
quit;


proc sql;
	create table s4 as	
	select DISTINCT CUST_ID, AGE, avg(PRICE) as AVG_PRICE
	from MIDTEST.item
	group by CUST_ID;
quit;
proc sql;
	create table s5 as
	select n(CUST_ID) as N_CUST label='¿ì¼ö °í°´ÀÇ ÀÎ¿ø ¼ö',  
              avg(AGE) as AVG_AGE format 4.1 label='¿ì¼ö °í°´ÀÇ Æò±Õ ¿¬·É' 
	from s4
	where AVG_PRICE >= 30000 ;
quit;


proc sql;
	create table table4 as	
	select DISTINCT CUST_ID, AGE, avg(PRICE) as avp
	from MIDTEST.item
	group by CUST_ID;
quit;
proc sql;
	create table table5 as
	select count(avp) as vipnum, age
	from table4
	where avp >= 30000;
quit;
proc sql;
	create table table6 as
	select vipnum label='¿ì¼ö °í°´ÀÇ ÀÎ¿ø ¼ö',  
              sum(age)/vipnum as AVG_AGE format 4.1 label='¿ì¼ö °í°´ÀÇ Æò±Õ ¿¬·É' 
	from table5
	group by vipnum;
quit;


proc sql;
	create table cc as
	select price>=30000 as vip
	from midtest.item;
quit;


proc sql;
	create table final as	
	select DISTINCT N(CUST_ID) as N_CUST label='¿ì¼ö °í°´ÀÇ ÀÎ¿ø ¼ö',  avg(AGE)  as AVG_AGE format 4.1 label='¿ì¼ö °í°´ÀÇ Æò±Õ ¿¬·É'      
	from MIDTEST.item 
	where price >=30000;
quit;

proc sql;
	create table vip as	
	select *, avg(PRICE) as avg
	from MIDTEST.item
	group by CUST_ID;
quit;

/*¿ì¼ö °í°´¸¸ ÃßÃâ*/
data vvip;
	set vip;
	if avg>=30000 then output vvip;
run;
/*¿ì¼ö °í°´ÀÇ ¿ä¾àÅë°è·® °è»ê*/
proc sql;
	create table vvvip as
	select N(CUST_ID) as N_CUST label='¿ì¼ö °í°´ÀÇ ÀÎ¿ø ¼ö',  
              avg(AGE) as AVG_AGE format 4.1 label='¿ì¼ö °í°´ÀÇ Æò±Õ ¿¬·É' 
	from vvip;
quit;

proc sql;
	create table exam4 as	
	select CUST_ID, AGE, sum(PRICE) as one
	from MIDTEST.item
	group by CUST_ID ;
quit;
proc sql;
	create table exam4_2 as
	select distinct *, (one>30000) as two
	from exam4;
quit;


proc sql;
	create table item1 as
	select * 
	from midtest.item
	where price>=30000;
quit;
proc sql;
	create table item2 as
	select count(item_cate) as bb,
			  avg(age) as cc format=4.1
	from item1
	group by cust_id;
quit;


proc sql;
	create table vvvip as
	select N(CUST_ID) as N_CUST label='¿ì¼ö °í°´ÀÇ ÀÎ¿ø ¼ö',  
              avg(AGE) as AVG_AGE format 4.1 label='¿ì¼ö °í°´ÀÇ Æò±Õ ¿¬·É' 
	from midtest.item
	where price>=30000
	having count;
quit;

proc sql;
	create table ex as	
	select distinct CUST_ID, AGE, price, avg(price) as ddd
	from MIDTEST.item
	having ddd>=30000;
quit;



proc sql;
	create table ex2 as
	select count(CUST_ID) as N_CUST label='¿ì¼ö °í°´ÀÇ ÀÎ¿ø ¼ö',  
              avg(AGE) as AVG_AGE format 4.1 label='¿ì¼ö °í°´ÀÇ Æò±Õ ¿¬·É' 
	from ex;
quit;

proc sql;
	create table item1 as
	select *, sum(price) as pr 
	from midtest.item
	group by cust_id;
quit;
proc sql;
	create table item2 as
	select *, (pr/count(cust_id)) as pr_mean
	from item1;
quit;


/*°í°´ º° ±¸¸Å¾× Æò±Õ*/
proc sql;
	create table temp_sup as	
	select CUST_ID, sum(price)/count(cust_id) as sum, sum(age)/count(cust_id) as age2
    from MIDTEST.item
	group by CUST_ID;
quit;
data temp_sup2;
	set temp_sup;
	if sum>=30000 then cust_id=1;
	else delete;
run;
proc sql;
	create table sup as
	select count(cust_id) as custss label='¿ì¼ö °í°´ÀÇ ÀÎ¿ø ¼ö',   avg(age2) as dddd format 4.1 label='¿ì¼ö °í°´ÀÇ Æò±Õ ¿¬·É' 
	from temp_sup2;
	quit;

proc sql;
	create table dataset4 as
	select N(CUST_ID) as N_CUST label='¿ì¼ö °í°´ÀÇ ÀÎ¿ø ¼ö',  
              avg(AGE) as AVG_AGE format 4.1 label='¿ì¼ö °í°´ÀÇ Æò±Õ ¿¬·É' 
	from temp2_dataset4;
quit;

proc sql;
	create table abc as
	select *
	from midtest.item
	having price>=30000;
quit;
proc sql;
	create table www as
	select count(cust_id) as pp,
	sum(age)/calculated pp as gg 
	from abc;
quit;

proc sql;
	create table t1 as
	select cust_id, avg(price) as sss
	from midtest.item
		group by cust_id
	having sss >= 30000;
quit;

proc sql;
	create table sale as;
	select count(cust_id) as "¿ì¼ö °í°´ÀÇ ÀÎ¿ø¼ö", price, age, sum(age)/count(cust_id) format=4.1 as "¿ì¼ö °í°´ÀÇ Æò±Õ¿¬·É"
	from midtest.item
	where price having per >=30000;
	group by count(cust_id), sum(age)/count(cust_id);
quit;

proc sql;
	create table a1 as
	select *
	from midtest.item
		group by cust_id
	having avg(price)>=30000;

quit;
proc sql;
	create table a2 as
	select count(cust_id) as countc label='¿ì¼ö °í°´ÀÇ ÀÎ¿ø ¼ö',  
	avg(age) as avgc format=4.1 label="¿ì¼ö °í°´ÀÇ Æò±Õ¿¬·É"
	from a1;
quit;



data medical_a;
set midtest.medical_a;
run;
data medical_b;
set midtest.medical_b;
run;



proc sql;
	create table ab as
	select medical_a.yno, medical_a.money/medical_b.doctor as abc from midtest.medical_a, midtest.medical_b
	where medical_a.yno=medical_b.yno;
quit;


data table8;
	set midtest.item;
	if mean(price)>=30000 then g='¿ì¼ö°í°´' ;
	else h='ÀÏ¹Ý°í°´' ;
run;
proc sql;
	create table table9 as
	select count(g) as count, mean(age) as mean format=4.2
	from table8;
quit;
			











/***************************************************************************************************/
/*The End*/
/***************************************************************************************************/
