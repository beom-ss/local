DATA KUK1; 
INPUT NAME $ KEY; 
CARDS; 
박헌진 150
이우주 176
김진경 140
황진수 155
;

DATA KUK2; 
INPUT NAME $ JUMSU; 
CARDS; 
이우주 55
김진경 140
전홍석 150
;

DATA KUK11; 
INPUT NAME $ KEY; 
CARDS; 
박헌진 150
이우주 176
김진경 140
김진경 140
김진경 140
김진경 140
황진수 155
;

DATA KUK22; 
INPUT NAME $ JUMSU; 
CARDS; 
이우주 55
김진경 140
김진경 140
전홍석 150
;

*********************************************;
* 2. 교차조인(Cross Join);
*********************************************;
* KUK1테이블과 KUK2테이블의 모든 관측치를 기준 변수 없이 모두 조인.;
PROC SQL;
  CREATE TABLE CROSS1 AS
    SELECT A.NAME AS NAME1,
           B.NAME AS NAME2,
           A.KEY,B.JUMSU
   FROM KUK1 A 
        CROSS JOIN KUK2 B;
QUIT;

PROC SQL;
  CREATE TABLE CROSS2 AS
    SELECT A.NAME AS NAME1,
           B.NAME AS NAME2,
           A.KEY,B.JUMSU
   FROM KUK1 A,
        KUK2 B;
QUIT;

* 데이터 스텝;
DATA CROSS3;
     RETAIN NAME1 NAME2 KEY JUMSU;
 SET KUK1(RENAME=(NAME=NAME1));
     DO I=1 TO KOBS;
        SET KUK2(RENAME=(NAME=NAME2))  
                 NOBS=KOBS POINT=I;
        OUTPUT;
     END;
RUN;

*********************************************;
* 3. 내부 결합(Inner Join);
*********************************************;
PROC SQL;
  CREATE TABLE INNER1 AS
    SELECT A.NAME,
           A.KEY,
           B.JUMSU
    FROM   KUK1 A
           INNER JOIN KUK2 B
                 ON A.NAME = B.NAME;
QUIT;

PROC SQL;
  CREATE TABLE INNER2 AS
    SELECT A.NAME,
           A.KEY,
           B.JUMSU
    FROM   KUK1 A, KUK2 B
    WHERE  A.NAME = B.NAME;
QUIT;

* 데이터 스텝;
PROC SORT DATA=KUK1;
     BY NAME;
RUN;

PROC SORT DATA=KUK2;
     BY NAME;
RUN;

DATA INNER3;
 MERGE KUK1(IN=A) KUK2(IN=B);
     BY NAME;
     IF A AND B;
RUN;

*********************************************;
* 내부 결합(1:N);
*********************************************;
DATA KUK_1N_1; 
INPUT NAME $ KEY; 
CARDS; 
박헌진 150
이우주 176
김진경 140
황진수 155
;

DATA KUK_1N_2; 
INPUT NAME $ JUMSU SEQ; 
CARDS; 
이우주 55  1
이우주 65  2
이우주 75  3
김진경 140 1
김진경 150 2
김진경 160 3
전홍석 150 1
;

PROC SQL;
  CREATE TABLE INNER_1N_1 AS
    SELECT A.NAME,
           A.KEY,
           B.JUMSU,
           B.SEQ
    FROM   KUK_1N_1 A, KUK_1N_2 B
    WHERE  A.NAME = B.NAME;
QUIT;


* 데이터 스텝;
PROC SORT DATA=KUK_1N_1;
     BY NAME;
RUN;

PROC SORT DATA=KUK_1N_2;
     BY NAME;
RUN;

DATA INNER_1N_2;
 MERGE KUK_1N_1(IN=A) KUK_1N_2(IN=B);
     BY NAME;
     IF A AND B;
RUN;


*********************************************;
* 내부 결합(N:N);
*********************************************;
DATA KUK_NN_1; 
     INPUT NAME $ KEY SEQ1; 
CARDS; 
박헌진 150 1
이우주 176 1
이우주 186 2
김진경 140 1
김진경 180 2
황진수 155 1
;

DATA KUK_NN_2;
     INPUT NAME $ JUMSU SEQ; 
CARDS; 
이우주 55  1
이우주 65  2
이우주 75  3
김진경 140 1
김진경 150 2
김진경 160 3
전홍석 150 1
;

* PROC SQL;
PROC SQL;
  CREATE TABLE INNER_NN_1 AS
    SELECT A.NAME,
           A.KEY,
           A.SEQ1,
           B.JUMSU,
           B.SEQ
    FROM   KUK_NN_1 A, KUK_NN_2 B
    WHERE  A.NAME = B.NAME;
QUIT;

* 데이터 스텝;
PROC SORT DATA=KUK_NN_1;
     BY NAME;
RUN;

PROC SORT DATA=KUK_NN_2;
     BY NAME;
RUN;

DATA INNER_NN_2;
 MERGE KUK_NN_1(IN=A) KUK_NN_2(IN=B);
     BY NAME;
     IF A AND B;
RUN;

*********************************************;
* 4. 외부조인(Left Join);
*********************************************;
PROC SQL;
  CREATE TABLE LEFT1 AS
    SELECT A.NAME,
           A.KEY,
           B.JUMSU
    FROM   KUK1 A
           LEFT JOIN KUK2 B
                 ON A.NAME = B.NAME;
QUIT;

* 데이터 스텝;
PROC SORT DATA=KUK1;
     BY NAME;
RUN;

PROC SORT DATA=KUK2;
     BY NAME;
RUN;

DATA LEFT2;
 MERGE KUK1(IN=A) KUK2(IN=B);
     BY NAME;
     IF A;
RUN;


*********************************************;
* LEFT 결합(WHERE절)-1;
*********************************************;
* 4.2 PROC SQL과 데이터 스텝(WHERE 절);

* KUK1테이블에 단독으로 존재하는 데이터 출력.;
PROC SQL;
  CREATE TABLE LEFT3 AS
    SELECT A.NAME,A.KEY,B.JUMSU
    FROM   KUK1 A
           LEFT JOIN KUK2 B
                ON A.NAME = B.NAME
    WHERE  B.NAME IS NULL;
QUIT; 

* 데이터 스텝;
DATA LEFT4;
 MERGE KUK1(IN=A) KUK2(IN=B);
     BY NAME;
     IF A AND B NE 1;  * IF A AND B=0;
RUN;

*********************************************;
* LEFT 결합(WHERE절)-2;
*********************************************;
* KUK1테이블을 기준으로 이름이 '백'으로 시작하는 사람;
PROC SQL;
  CREATE TABLE LEFT5 AS
    SELECT A.NAME,A.KEY,B.JUMSU
    FROM   KUK1 A
           LEFT JOIN KUK2 B
                ON A.NAME = B.NAME
    WHERE A.NAME LIKE '백%';
QUIT;

* 데이터 스텝;
DATA LEFT6;
 MERGE KUK1(IN=A WHERE=(NAME LIKE '백%')) 
       KUK2(IN=B);
     BY NAME;
     IF A; 
RUN;

*********************************************;
* LEFT 결합(ON절);
*********************************************;
* 4.2 PROC SQL과 데이터 스텝(ON 절);
* * KUK1테이블에서 150 미만을 대상으로 결합 작업 수행;
PROC SQL;
  CREATE TABLE LEFT7_1 AS
    SELECT A.NAME,A.KEY,B.JUMSU
    FROM KUK1 A
         LEFT JOIN KUK2 B
              ON  A.NAME = B.NAME
              AND A.KEY < 150;
QUIT;


* KUK1테이블을 기준으로 KUK2테이블에서 '이우주'의 값을 조인;
PROC SQL;
  CREATE TABLE LEFT7_2 AS
    SELECT A.NAME,A.KEY,B.JUMSU
    FROM   KUK1 A
           LEFT JOIN KUK2 B
                ON  A.NAME = B.NAME
                AND B.NAME = '이우주';
QUIT;

*********************************************;
* LEFT 결합(WHERE/ON절);
*********************************************;
PROC SQL;
  CREATE TABLE LEFT9 AS
    SELECT A.NAME,A.KEY,B.JUMSU
    FROM   KUK1 A
           LEFT JOIN KUK2 B
                ON A.NAME  = B.NAME
                AND A.NAME = '이우주'
    WHERE A.KEY >= 155;
QUIT;

* 데이터 스텝;
DATA LEFT10;
 MERGE KUK1(IN=A WHERE=(KEY>=155)) 
       KUK2(IN=B WHERE=(NAME LIKE '이우주'));
     BY NAME;
     IF A;
RUN;


*********************************************;
* 오른쪽 외부 결합;
*********************************************;
PROC SQL;
  CREATE TABLE RIGHT1 AS
    SELECT B.NAME,
           A.KEY,B.JUMSU
    FROM   KUK1 A
           RIGHT JOIN KUK2 B
                 ON A.NAME = B.NAME;
QUIT;

DATA RIGHT2;
 MERGE KUK1(IN=A) KUK2(IN=B);
     BY NAME;
     IF B;
RUN;


*********************************************;
* 5. 전체 외부 조인(Full Join);
*********************************************;
* 5.2 PROC SQL과 데이터 스텝;

* KUK1 T과 KUK2 T에 대하여 LEFT JOIN과 RIGHT JOIN을 수행
* 단, KUK1을 기준으로 수행하였기 때문에 KUK1 T의 NAME을 기준이 되어,;
* KUK2 T의 NAME변수의 전홍석은 NULL .;

PROC SQL;
  CREATE TABLE FULL1 AS
    SELECT A.NAME,A.KEY,B.JUMSU
    FROM   KUK1 A 
           FULL JOIN KUK2 B
                ON A.NAME = B.NAME;
QUIT; 


*********************************************;
* FULL 결합(COALESCE 함수);
*********************************************;
PROC SQL;
  CREATE TABLE FULL3 AS
    SELECT COALESCE(A.NAME,B.NAME) AS NAME,
           A.KEY,B.JUMSU
    FROM   KUK1 A 
           FULL JOIN KUK2 B
                ON A.NAME = B.NAME;
QUIT; 

* 데이터 스텝;
DATA FULL4;
 MERGE KUK1(IN=A) KUK2(IN=B);
     BY NAME;
RUN; 

*********************************************;
* FULL 결합-1(COALESCE 함수) : 공통 존재하는 건 제외;
*********************************************;
* FULL조인 결과 중에 양쪽 테이블에 공통으로 존재하는 '이우주'과 '김진경'는 제외.;

PROC SQL;
  CREATE TABLE FULL5 AS
    SELECT COALESCE(A.NAME,B.NAME) AS NAME, 
           A.KEY,B.JUMSU
    FROM   KUK1 A
           FULL JOIN KUK2 B
                ON A.NAME = B.NAME
    WHERE A.NAME IS NULL
       OR B.NAME IS NULL;
QUIT;

* 데이터 스텝;
DATA FULL6;
 MERGE KUK1(IN=A) KUK2(IN=B);
     BY NAME;
     IF A NE 1 OR B NE 1;
RUN;

*********************************************;
* 합집합-1(UNION);
*********************************************;
PROC SQL;
  CREATE TABLE UNION1 AS
    SELECT * FROM KUK1
    UNION
    SELECT * FROM KUK2;
QUIT;

DATA UNION2;
 SET KUK1 KUK2(RENAME=(JUMSU=KEY));
     BY NAME KEY;
     IF LAST.KEY;
RUN;

*********************************************;
* 합집합-1(UNION CORR);
*********************************************;
* 두 개 테이블에서 공통변수 NAME에 대하여 세로결합.;
* NAME변수의 중복 관측치 '이우주','김진경'의 중복값 제거;

PROC SQL;
  CREATE TABLE UNION1_1 AS
    SELECT * FROM KUK1
    UNION CORR
    SELECT * FROM KUK2;
QUIT;

*********************************************;
* 합집합-2(UNION);
*********************************************;
* KUK1테이블 과 KUK2테이블을 세로 결합 시 NAME 변수값이 공통으로 중복되는 
* '이우주','김진경'의 값은 한번 출력. 
* 단, KUK2테이블의 JUMSU변수는 KEY변수와 동일하게 취급.;

PROC SQL;
  CREATE TABLE UNION3 AS
    SELECT A.NAME FROM KUK1 A
    UNION
    SELECT B.NAME FROM KUK2 B;
QUIT;

* 데이터 스텝;
DATA UNION4;
 SET KUK1(KEEP=NAME) KUK2(KEEP=NAME);
     BY NAME;
     IF LAST.NAME;
RUN;

*********************************************;
* 합집합-3(UNION);
*********************************************;
* UNION과 같으나 두 테이블의 중복되는 값까지 반환 합니다.;
* KUK1테이블 과 KUK2테이블을 세로 결합 시 모든 변수의 관측값을 중복 제거 없이 출력.;

PROC SQL;
  CREATE TABLE UNION_ALL1 AS
    SELECT * FROM KUK1 A
    UNION ALL
    SELECT * FROM KUK2 B;
QUIT;

* 데이터 스텝;
DATA UNION_ALL2;
 SET KUK1 KUK2(RENAME=(JUMSU=KEY));
RUN;

*********************************************;
* 합집합-3(UNION);
*********************************************;
* 두 개 테이블에서 공통변수 NAME에 대하여 세로결합. ;
* NAME변수의 모든 관측치 출력;

PROC SQL;
  CREATE TABLE UNION_ALL3 AS
    SELECT * FROM KUK1 A
    UNION ALL CORR
    SELECT * FROM KUK2 B;
QUIT;

* 데이터 스텝;
DATA UNION_ALL4;
 SET KUK1 KUK2(RENAME=(JUMSU=KEY));
     BY NAME;
RUN;

*********************************************;
* 교집합;
*********************************************;
* KUK1테이블 과 KUK2테이블의 세로 결합시 모든 관측치가 공통된 값 출력.;
PROC SQL;
  CREATE TABLE INTERSECT1 AS
    SELECT * FROM KUK1 A
    INTERSECT
    SELECT * FROM KUK2 B;
QUIT;

* 두개 테이블에서 공통변수 NAME에 대하여 교집합. ;
* NAME변수의 공통 교집합 '이우주','김진경' 출력;
PROC SQL;
  CREATE TABLE INTERSECT2 AS
    SELECT * FROM KUK1 A
    INTERSECT CORR
    SELECT * FROM KUK2 B;
QUIT;

* 두개 테이블에서 세로 교집합 출력시 중복 제거 없이 출력. ;
DATA KUK11; 
input name $ key; 
cards; 
박헌진 150
이우주 176
김진경 140
김진경 140
김진경 140
김진경 140
황진수 155
;


DATA KUK22; 
INPUT NAME $ JUMSU;
CARDS; 
이우주 55
김진경 140
김진경 140
전홍석 150
;

* 두 개 테이블에서 세로 교집합 출력 시 중복 제거 없이 출력. ;
PROC SQL;
  CREATE TABLE INTERSECT3 AS
    SELECT * FROM KUK11 A
    INTERSECT ALL
    SELECT * FROM KUK22 B;
QUIT;

* - 두개 테이블에서 세로 교집합 출력시 공통된 변수 NAME기준으로 중복 제거 없이 출력.;
PROC SQL;
  CREATE TABLE INTERSECT4 AS
    SELECT * FROM KUK1 A
    INTERSECT ALL CORR
    SELECT * FROM KUK2 B;
QUIT;

DATA INTERSECT5;
 SET KUK1 KUK2(RENAME=(JUMSU=KEY));
     BY NAME KEY;
     IF FIRST.KEY NE 1 AND LAST.KEY;
RUN;

*********************************************;
* 8. 차집합 세로결합(MINUS) ;
* - KUK1테이블에서 KUK2에 존재하는 관측치 제거;
*********************************************;
* KUK1테이블에서 KUK2에 존재하는 관측치 제거;
PROC SQL;
  CREATE TABLE MINU1 AS
    SELECT * FROM KUK1 A
    EXCEPT
    SELECT * FROM KUK2 B;
RUN;


* KUK1테이블에서 KUK2에 존재하는 관측치 제거.;
* 양쪽 테이블에서 공통 변수 'NAME'에 대하여 차집합 수행.;
PROC SQL;
  CREATE TABLE MINU2 AS
    SELECT * FROM KUK1 A
    EXCEPT CORR
    SELECT * FROM KUK2 B;
RUN;

* 차집합 수행시 중복 관측치에 대하여 중복 제거 없이 출력.;
PROC SQL;
  CREATE TABLE MINU3 AS
    SELECT * FROM KUK11 A
    EXCEPT ALL
    SELECT * FROM KUK22 B;
RUN;

* 두개 테이블에서 세로 차집합 수행시 공통된 변수 NAME기준으로 중복 제거 없이 수행. ;
PROC SQL;
  CREATE TABLE MINU4 AS
    SELECT * FROM KUK11 A
    EXCEPT ALL CORR
    SELECT * FROM KUK22 B;
RUN;

* 데이터 스텝;
DATA MINUS2;
 MERGE KUK1(IN=A) 
       KUK2(IN=B RENAME=(JUMSU=KEY));
     BY NAME KEY;
     IF A AND B NE 1;
RUN;

*********************************************;
* 9. 외부합집합(OUTER UNION);
*********************************************;
* - 두개 테이블에서 세로결합시 모든 변수에 대하여 수행한다.
* - 단, 양테이블에서 공통된 변수는 상위 테이블 우선하여 출력.;

PROC SQL;
  CREATE TABLE OUTER_UNION1 AS
    SELECT * FROM KUK1
    OUTER UNION
    SELECT NAME AS NAME1,JUMSU FROM KUK2;
QUIT;

* 두개 테이블에서 세로결합시 공통 변수에 대하여 수행.;
PROC SQL;
  CREATE TABLE OUTER_UNION2 AS
    SELECT * FROM KUK1
    OUTER UNION CORR
    SELECT * FROM KUK2;
QUIT;

*********************************************;
* 배반 합집합 세로결합(EXCLUSIVE UNION) ;
*********************************************;
* - 공통된 관측치 '김진경'의 관측치 제외하고 세로결합.;
PROC SQL;
  CREATE TABLE EXCLUSIVE_UNION1 AS
    ( SELECT * FROM KUK1
      EXCEPT
      SELECT * FROM KUK2 )
    UNION
    ( SELECT * FROM KUK2
      EXCEPT
      SELECT * FROM KUK1 );
QUIT;
