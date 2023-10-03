



    data exam;
        infile"D:\exam.txt" expandtabs;
        input husband wife;
run;

/*(a)*/
proc corr data=exam cov;
run;
/* ���л��� 69.4129 */

/*(b)*/
data mexam;
set exam;
newhusband=husband*0.01;
drop husband;
newwife=wife*0.01;
drop wife;
run;
proc corr data=mexam cov;
run;
/* ���л��� 0.0069412939 */

/*(c)*/
proc corr data=exam cov;
run;
/* �������� 0.76339 */
/*(d)*/
proc corr data=exam cov;
run;
/* c�� ����� ����. ���л��� �ڷ��� �����Ͱ� ��ȯ�Ǵ� �ݸ鿡 R^2�� �� ����Ÿ �ڷ�鿡 �Ȱ��� ���� �������� ������ �ڷ����
�ٲ��� �ʱ� �����̴�.*/

/*(e)*/
data newexam;
set exam;
newwife=(husband-5);
drop wife;
run;


proc corr data=newexam;
run;
/* R^2=1 */


/*(f)*/
proc reg data=exam;
model husband=wife;
run;
proc reg data=exam;
model wife=husband;
run;
/* wife�� ���������� �ϴ°��� �� ȿ�������� ���δ�. �� ������, ����������, ��������տ��� husband���� �� ���� ���� ���� �����̴�.*/


/*(g)*/
proc reg dat=exam;
model wife=husband;
run;

/* �� ����� ������ ���, H0:b1=0 �� H1:b1��0�� pvalue ���� <0.0001 ���Ϸν� a>p�̹Ƿ� �͹������� �Ⱒ�Ѵ�.�׷��Ƿ� ���Ⱑ 0�� �ƴ϶�
������ �Ǵ�.*/

/*(h)*/

/*H0: b0=0 �� h1: b0��0. pvalue���� 0.0002�ν� �ſ� �����Ƿ� ���Ǽ��� 0.05�Ͽ��� �͹������� �Ⱒ�Ѵ�. */

/*(j)*/

/* (g)�� ������ �̿��Ѵ�. �͹������� �Ⱒ�Ѵ�. �׷��Ƿ� ���� ����� Ű�� ���� ����鳢�� ��ȥ�ϴ� ������ �ִٰ� �� �� �ִ�. */

/*(k)*/
 /*�� ������ �� g�� ������ �����ϴٰ� �����մϴ�.*/

data exam1;
        infile "D:\exam1.txt" expandtabs;
        input State$ Age Hs Income Black Female Price Sales;
        run;
 /*(a)*/
proc reg data=exam1;
        model Sales=Age Hs Income Black Female Price;
        test Female=0;
quit;
/* pvalue���� 0.8507�ν� �͹������� ä���Ѵ�. ��, ������ ������ ���Һ񷮿� ������ ��ġ�� �ʴ´�.*/  <--- h0 ???

/*(b)*/
proc reg data=exam1;
        model Sales=Age Hs Income Black Female Price;
        test Female,Hs=0;
quit;

/* pvalue�� 0.9789�ν� �͹������� ä���Ѵ�. ������ ������ ����б��� ������ 25�� �̻��� �ֹκ����� �Һ񷮿� ������ ��ġ�� �ʴ´�.*/  <--- h0 ???

/*(c)*/
data confidenceline;
alpha=0.05;
df=44;
t=tinv(1-alpha/2,df);
run;
/* �ŷڱ�����   0.01895��2.0153675744*sqrt(0.01895)


/*(d)*/
proc reg data=exam1;
        model Sales=Age Hs Black Female Price;
quit;
/* R^2�� 0.2678*/

/*(e)*/
proc reg data=exam1;
        model sales=price age income;
quit;
/* R^2�� 0.3032*/

/*(f)*/

proc reg data=exam1;
        model sales=income;
quit;

/* R^2�� 0.1063 */
