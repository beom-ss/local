DATA KUK1; 
INPUT NAME $ KEY; 
CARDS; 
������ 150
�̿��� 176
������ 140
Ȳ���� 155
;

DATA KUK2; 
INPUT NAME $ JUMSU; 
CARDS; 
�̿��� 55
������ 140
��ȫ�� 150
;

DATA KUK11; 
INPUT NAME $ KEY; 
CARDS; 
������ 150
�̿��� 176
������ 140
������ 140
������ 140
������ 140
Ȳ���� 155
;

DATA KUK22; 
INPUT NAME $ JUMSU; 
CARDS; 
�̿��� 55
������ 140
������ 140
��ȫ�� 150
;

*********************************************;
* 2. ��������(Cross Join);
*********************************************;
* KUK1���̺�� KUK2���̺��� ��� ����ġ�� ���� ���� ���� ��� ����.;
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

* ������ ����;
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
* 3. ���� ����(Inner Join);
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

* ������ ����;
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
* ���� ����(1:N);
*********************************************;
DATA KUK_1N_1; 
INPUT NAME $ KEY; 
CARDS; 
������ 150
�̿��� 176
������ 140
Ȳ���� 155
;

DATA KUK_1N_2; 
INPUT NAME $ JUMSU SEQ; 
CARDS; 
�̿��� 55  1
�̿��� 65  2
�̿��� 75  3
������ 140 1
������ 150 2
������ 160 3
��ȫ�� 150 1
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


* ������ ����;
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
* ���� ����(N:N);
*********************************************;
DATA KUK_NN_1; 
     INPUT NAME $ KEY SEQ1; 
CARDS; 
������ 150 1
�̿��� 176 1
�̿��� 186 2
������ 140 1
������ 180 2
Ȳ���� 155 1
;

DATA KUK_NN_2;
     INPUT NAME $ JUMSU SEQ; 
CARDS; 
�̿��� 55  1
�̿��� 65  2
�̿��� 75  3
������ 140 1
������ 150 2
������ 160 3
��ȫ�� 150 1
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

* ������ ����;
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
* 4. �ܺ�����(Left Join);
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

* ������ ����;
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
* LEFT ����(WHERE��)-1;
*********************************************;
* 4.2 PROC SQL�� ������ ����(WHERE ��);

* KUK1���̺� �ܵ����� �����ϴ� ������ ���.;
PROC SQL;
  CREATE TABLE LEFT3 AS
    SELECT A.NAME,A.KEY,B.JUMSU
    FROM   KUK1 A
           LEFT JOIN KUK2 B
                ON A.NAME = B.NAME
    WHERE  B.NAME IS NULL;
QUIT; 

* ������ ����;
DATA LEFT4;
 MERGE KUK1(IN=A) KUK2(IN=B);
     BY NAME;
     IF A AND B NE 1;  * IF A AND B=0;
RUN;

*********************************************;
* LEFT ����(WHERE��)-2;
*********************************************;
* KUK1���̺��� �������� �̸��� '��'���� �����ϴ� ���;
PROC SQL;
  CREATE TABLE LEFT5 AS
    SELECT A.NAME,A.KEY,B.JUMSU
    FROM   KUK1 A
           LEFT JOIN KUK2 B
                ON A.NAME = B.NAME
    WHERE A.NAME LIKE '��%';
QUIT;

* ������ ����;
DATA LEFT6;
 MERGE KUK1(IN=A WHERE=(NAME LIKE '��%')) 
       KUK2(IN=B);
     BY NAME;
     IF A; 
RUN;

*********************************************;
* LEFT ����(ON��);
*********************************************;
* 4.2 PROC SQL�� ������ ����(ON ��);
* * KUK1���̺��� 150 �̸��� ������� ���� �۾� ����;
PROC SQL;
  CREATE TABLE LEFT7_1 AS
    SELECT A.NAME,A.KEY,B.JUMSU
    FROM KUK1 A
         LEFT JOIN KUK2 B
              ON  A.NAME = B.NAME
              AND A.KEY < 150;
QUIT;


* KUK1���̺��� �������� KUK2���̺��� '�̿���'�� ���� ����;
PROC SQL;
  CREATE TABLE LEFT7_2 AS
    SELECT A.NAME,A.KEY,B.JUMSU
    FROM   KUK1 A
           LEFT JOIN KUK2 B
                ON  A.NAME = B.NAME
                AND B.NAME = '�̿���';
QUIT;

*********************************************;
* LEFT ����(WHERE/ON��);
*********************************************;
PROC SQL;
  CREATE TABLE LEFT9 AS
    SELECT A.NAME,A.KEY,B.JUMSU
    FROM   KUK1 A
           LEFT JOIN KUK2 B
                ON A.NAME  = B.NAME
                AND A.NAME = '�̿���'
    WHERE A.KEY >= 155;
QUIT;

* ������ ����;
DATA LEFT10;
 MERGE KUK1(IN=A WHERE=(KEY>=155)) 
       KUK2(IN=B WHERE=(NAME LIKE '�̿���'));
     BY NAME;
     IF A;
RUN;


*********************************************;
* ������ �ܺ� ����;
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
* 5. ��ü �ܺ� ����(Full Join);
*********************************************;
* 5.2 PROC SQL�� ������ ����;

* KUK1 T�� KUK2 T�� ���Ͽ� LEFT JOIN�� RIGHT JOIN�� ����
* ��, KUK1�� �������� �����Ͽ��� ������ KUK1 T�� NAME�� ������ �Ǿ�,;
* KUK2 T�� NAME������ ��ȫ���� NULL .;

PROC SQL;
  CREATE TABLE FULL1 AS
    SELECT A.NAME,A.KEY,B.JUMSU
    FROM   KUK1 A 
           FULL JOIN KUK2 B
                ON A.NAME = B.NAME;
QUIT; 


*********************************************;
* FULL ����(COALESCE �Լ�);
*********************************************;
PROC SQL;
  CREATE TABLE FULL3 AS
    SELECT COALESCE(A.NAME,B.NAME) AS NAME,
           A.KEY,B.JUMSU
    FROM   KUK1 A 
           FULL JOIN KUK2 B
                ON A.NAME = B.NAME;
QUIT; 

* ������ ����;
DATA FULL4;
 MERGE KUK1(IN=A) KUK2(IN=B);
     BY NAME;
RUN; 

*********************************************;
* FULL ����-1(COALESCE �Լ�) : ���� �����ϴ� �� ����;
*********************************************;
* FULL���� ��� �߿� ���� ���̺� �������� �����ϴ� '�̿���'�� '������'�� ����.;

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

* ������ ����;
DATA FULL6;
 MERGE KUK1(IN=A) KUK2(IN=B);
     BY NAME;
     IF A NE 1 OR B NE 1;
RUN;

*********************************************;
* ������-1(UNION);
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
* ������-1(UNION CORR);
*********************************************;
* �� �� ���̺��� ���뺯�� NAME�� ���Ͽ� ���ΰ���.;
* NAME������ �ߺ� ����ġ '�̿���','������'�� �ߺ��� ����;

PROC SQL;
  CREATE TABLE UNION1_1 AS
    SELECT * FROM KUK1
    UNION CORR
    SELECT * FROM KUK2;
QUIT;

*********************************************;
* ������-2(UNION);
*********************************************;
* KUK1���̺� �� KUK2���̺��� ���� ���� �� NAME �������� �������� �ߺ��Ǵ� 
* '�̿���','������'�� ���� �ѹ� ���. 
* ��, KUK2���̺��� JUMSU������ KEY������ �����ϰ� ���.;

PROC SQL;
  CREATE TABLE UNION3 AS
    SELECT A.NAME FROM KUK1 A
    UNION
    SELECT B.NAME FROM KUK2 B;
QUIT;

* ������ ����;
DATA UNION4;
 SET KUK1(KEEP=NAME) KUK2(KEEP=NAME);
     BY NAME;
     IF LAST.NAME;
RUN;

*********************************************;
* ������-3(UNION);
*********************************************;
* UNION�� ������ �� ���̺��� �ߺ��Ǵ� ������ ��ȯ �մϴ�.;
* KUK1���̺� �� KUK2���̺��� ���� ���� �� ��� ������ �������� �ߺ� ���� ���� ���.;

PROC SQL;
  CREATE TABLE UNION_ALL1 AS
    SELECT * FROM KUK1 A
    UNION ALL
    SELECT * FROM KUK2 B;
QUIT;

* ������ ����;
DATA UNION_ALL2;
 SET KUK1 KUK2(RENAME=(JUMSU=KEY));
RUN;

*********************************************;
* ������-3(UNION);
*********************************************;
* �� �� ���̺��� ���뺯�� NAME�� ���Ͽ� ���ΰ���. ;
* NAME������ ��� ����ġ ���;

PROC SQL;
  CREATE TABLE UNION_ALL3 AS
    SELECT * FROM KUK1 A
    UNION ALL CORR
    SELECT * FROM KUK2 B;
QUIT;

* ������ ����;
DATA UNION_ALL4;
 SET KUK1 KUK2(RENAME=(JUMSU=KEY));
     BY NAME;
RUN;

*********************************************;
* ������;
*********************************************;
* KUK1���̺� �� KUK2���̺��� ���� ���ս� ��� ����ġ�� ����� �� ���.;
PROC SQL;
  CREATE TABLE INTERSECT1 AS
    SELECT * FROM KUK1 A
    INTERSECT
    SELECT * FROM KUK2 B;
QUIT;

* �ΰ� ���̺��� ���뺯�� NAME�� ���Ͽ� ������. ;
* NAME������ ���� ������ '�̿���','������' ���;
PROC SQL;
  CREATE TABLE INTERSECT2 AS
    SELECT * FROM KUK1 A
    INTERSECT CORR
    SELECT * FROM KUK2 B;
QUIT;

* �ΰ� ���̺��� ���� ������ ��½� �ߺ� ���� ���� ���. ;
DATA KUK11; 
input name $ key; 
cards; 
������ 150
�̿��� 176
������ 140
������ 140
������ 140
������ 140
Ȳ���� 155
;


DATA KUK22; 
INPUT NAME $ JUMSU;
CARDS; 
�̿��� 55
������ 140
������ 140
��ȫ�� 150
;

* �� �� ���̺��� ���� ������ ��� �� �ߺ� ���� ���� ���. ;
PROC SQL;
  CREATE TABLE INTERSECT3 AS
    SELECT * FROM KUK11 A
    INTERSECT ALL
    SELECT * FROM KUK22 B;
QUIT;

* - �ΰ� ���̺��� ���� ������ ��½� ����� ���� NAME�������� �ߺ� ���� ���� ���.;
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
* 8. ������ ���ΰ���(MINUS) ;
* - KUK1���̺��� KUK2�� �����ϴ� ����ġ ����;
*********************************************;
* KUK1���̺��� KUK2�� �����ϴ� ����ġ ����;
PROC SQL;
  CREATE TABLE MINU1 AS
    SELECT * FROM KUK1 A
    EXCEPT
    SELECT * FROM KUK2 B;
RUN;


* KUK1���̺��� KUK2�� �����ϴ� ����ġ ����.;
* ���� ���̺��� ���� ���� 'NAME'�� ���Ͽ� ������ ����.;
PROC SQL;
  CREATE TABLE MINU2 AS
    SELECT * FROM KUK1 A
    EXCEPT CORR
    SELECT * FROM KUK2 B;
RUN;

* ������ ����� �ߺ� ����ġ�� ���Ͽ� �ߺ� ���� ���� ���.;
PROC SQL;
  CREATE TABLE MINU3 AS
    SELECT * FROM KUK11 A
    EXCEPT ALL
    SELECT * FROM KUK22 B;
RUN;

* �ΰ� ���̺��� ���� ������ ����� ����� ���� NAME�������� �ߺ� ���� ���� ����. ;
PROC SQL;
  CREATE TABLE MINU4 AS
    SELECT * FROM KUK11 A
    EXCEPT ALL CORR
    SELECT * FROM KUK22 B;
RUN;

* ������ ����;
DATA MINUS2;
 MERGE KUK1(IN=A) 
       KUK2(IN=B RENAME=(JUMSU=KEY));
     BY NAME KEY;
     IF A AND B NE 1;
RUN;

*********************************************;
* 9. �ܺ�������(OUTER UNION);
*********************************************;
* - �ΰ� ���̺��� ���ΰ��ս� ��� ������ ���Ͽ� �����Ѵ�.
* - ��, �����̺��� ����� ������ ���� ���̺� �켱�Ͽ� ���.;

PROC SQL;
  CREATE TABLE OUTER_UNION1 AS
    SELECT * FROM KUK1
    OUTER UNION
    SELECT NAME AS NAME1,JUMSU FROM KUK2;
QUIT;

* �ΰ� ���̺��� ���ΰ��ս� ���� ������ ���Ͽ� ����.;
PROC SQL;
  CREATE TABLE OUTER_UNION2 AS
    SELECT * FROM KUK1
    OUTER UNION CORR
    SELECT * FROM KUK2;
QUIT;

*********************************************;
* ��� ������ ���ΰ���(EXCLUSIVE UNION) ;
*********************************************;
* - ����� ����ġ '������'�� ����ġ �����ϰ� ���ΰ���.;
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
