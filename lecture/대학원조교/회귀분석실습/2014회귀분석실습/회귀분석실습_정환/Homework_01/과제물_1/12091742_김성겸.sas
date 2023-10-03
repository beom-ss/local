data height;
infile "D:\table2.11.txt" expandtabs firstobs=2;
input Husband Wife;
run;
/* D����̺꿡 ���������� ���� �� �ҷ�����, Husband ����Ű Wife ����Ű*/

proc corr data=height cov;
var Husband;
with Wife;
run;
/*(a) Husband�� Wife�� Ű ������ ���л��� 69.41293860�̰�
(c)�������� 0.76339�̴�.*/

proc sql;
create table height_inch as
select Husband*0.393701 as H_inch, Wife*0.393701 as W_inch
from height;
quit;
/*sql���� �̿��Ͽ� cmŰ�� 0.393701�� ���Ͽ� inchŰ�� ��ȯ�Ͽ� height_inch ���̺� ����*/

proc corr data=height_inch cov;
var H_inch ;
with W_inch;
run;
/* (b) inch�� ��ȯ�� ����� ����Ű ������ ���л��� 10.75903862
(d) inch�� ��ȯ�ؼ� ���� �������� 0.76339�̹Ƿ� cm�� ������ �� �� �ִ�.*/

proc sql;
create table height_5 as
select Husband,Husband-5 as Wife_5
from height;
quit;
/*������ 5cm���� ������ Ű(Wife_5)�� height_5�� �����Ѵ�.*/

proc corr data=height_5;
var Husband;
with Wife_5;
run;
proc plot data=height_5;
plot Husband*Wife_5;
run;
/*(e)�������� 1�̴�. plot������ �������谡 ������ �� �� �ִ�.*/

proc plot data=height;
plot Husband*Wife;
plot Wife*Husband;
run;
proc reg data=height;
model Husband=Wife;
run;
proc reg data=height;
model Wife= Husband;
run;
/*(f)  plot �� ���غ��� ū ���̰� ���� R-square�� ���� ��� beta0 �� beta1�� �Ⱒ�ϹǷ� 
��� ���� ���Ӻ����� ��Ƶ� �������. �ٸ� �׷����� ������ ����� ������ ���̰� ������
����� �ٲܸ�ŭ�� ������ ����δ�.
 (g)(h)���Ӻ����� ������� ��Ƶ�  ȸ�ͺм� ��� beta0,beta1�� �Ⱒ���� �� �� �ִ�.     <---  ��������??? 2���� ��� ����...
 (j)(k) ����Ű�� �Ƴ�Ű�� corr���� 0.7634�̹Ƿ� ����� Ű�� ���డ ��ȥ�Ѵٰ� ������ �� �ִ�.*/

data ciga;
infile "D:\table3.17.txt" expandtabs firstobs=2;
input state$ age HS income black female price sales;
run;

proc reg data=ciga;
model sales=age HS income black female price;
test female=0;
run;
/*(a)FM�� ���������� ��� �� ��
   RM�� female�� ������ �ټ��������� �� ��
H0: female=0 �̰� ������� �͹������� �Ⱒ���� ������ �� �� �ִ�.
���� sales�� �����ϴµ� female������ �ʿ��ϴٰ� ���� ��  ����.*/

proc reg data=ciga;
model sales=age HS income black female price;
test female=HS=0;
run;
/*(b)RM�� female HS�� ������ �װ������� �� ��
H0: female=HS=0 �̰� ������� �͹������� �Ⱒ���� ������ �� �� �ִ�.
���� sales�� �����ϴµ� female,HS������ �ʿ��ϴٰ� ���� �� ����.*/

data tvalue ;
alpha=0.05 ; df=51-6-1 ;
t=tinv(1-alpha/2,df) ;
run ; 

/*t(alpha/2,n-p-1)�� ��跮 ��� 2.0153675744*/

proc reg data=ciga;
model sales= age HS income black female price/i;
run;
/*income�� ����ġ�� standard error�� Root MSE, Cii(C_income) ���� ��´�
standard error=Root MSE*sqrt(Cii) �̴�*/

data interval;
upper=0.01895+2.0153675744*0.01022;
lower=0.01895-2.0153675744*0.01022;
run;
/*(c)beta_income_hat +- t(0.05/2,44) *standard error �̰�
�� ���� (-0.001647057, 0.0395470566) �̴�.*/

proc reg data=ciga;
model sales=age HS income black female price;
run;
/*������ ���� ��� ������ R-square���� 0.3208*/

proc reg data=ciga;
model sales=age HS black female price;
run;
/*(d)income ������ �����ϰ� ������ �����鿡 ���� sales�� ���� ȸ�ͺм��� ������ ���
R-square���� 0.2678 �̹Ƿ� ������ �����鿡 ���� 26.78% ����ȴ� */

proc reg data=ciga;
model sales= price age income;
run;
/*(e) ���� �� ������ sales�� ������ �� �ִ� %�� R-square=0.3032�̹Ƿ� 30.32%�̴� */

proc reg data=ciga;
model sales=income;
run;
/*(f) income������ ������ �� �ִ� %�� 10.63%�̴�.*/
