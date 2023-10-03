
/*2.10��*/

data wife;
infile "D:\P049.txt" expandtabs;
input x y;
run;

proc corr data=wife cov;  /*(a)�� ���л�= 69.41293860 , (c)�� ������= 0.76339*/
quit;                    

/* (b)�� ��Ƽ����->���ͷ�qkRnaus 0.01�� �ϴ°Ͱ� ���������̹Ƿ� ���л��� 0.01�� ������ 0.0001�谡 �ȴ�.
        ���� 0.00694129386 �̴�.

(d)�� �������� ������ ����.

(e)�� �������� 1�� �ȴ�.

(f) �Ƴ��� Ű�� ���������� �Ұ��̴�. ������ Ű�� Ŭ ���� ū Ű�� ���ڸ� ��ȣ�ҰͰ���.*/

proc reg data=wife;
model y=x;
quit;

/* 
(g)�� H0: b1=0 , H1 : not H0
������ p-value�� 0.0001���ٵ� �۱� ������ �Ⱒ�Ҽ��ִ�.

(h)�� H0 : b0=0 , H1 : not H0
�Ⱒ��R: z�� ���밪>1.96
z= 3.93�̱� ������ �Ⱒ�Ҽ��ִ�.                    <----    t-�����ε�.. �� �̷� ����� ??? 

(j)�� ����͵� �������� �ʴ�.

(k)�� H0 : b1=1 , H1: not H0
z=(0.69965-1)/0.06106=-4.9189322
R: z������>1.96  �űⰢ�Ҽ��ִ�.
*/




/* 3.14�� */
data db;
infile "D:\P081.txt" expandtabs;
input states$ x1-x6 y;
run;

proc reg data=db;
model y=x1-x6;
test x5=0;
quit;

data v1;
alpha=0.05; df1=1; df2=50-6-1;
f0=finv(1-alpha,df1,df2);
put f0=;
run;

/*(a)�� H0: b5=0 , H1=not H0
�Ⱒ��R: F>4.0670474264 �̹Ƿ� �Ⱒ�Ҽ�����.*/

proc reg data=db;
model y=x1-x6;
test x2=x5=0;
quit;

data v2;
alpha=0.05; df1=2; df2=50-6-1;
f0=finv(1-alpha,df1,df2);
put f0=;
run;

/* (b)�� H0: b2=b5=0 , H1=not H0
�Ⱒ��R: F>3.2144803279 �̹Ƿ� �Ⱒ�Ҽ�����.*/

proc reg data=db;
model y=x1-x6;
quit;

/* (c)�� 
 0.01895 �� 1.96*0.01022
��0.01895 �� 0.0200312 */

proc reg data=db;
model y=x1 x2 x4 x5 x6;
quit;

/*(d)�� income�� ���ŵ� �𵨿��� R square�� ���ϸ� 0.2678�̴� 
  ��26.78%.*/

proc reg data=db;
model y=x1 x3 x5;
quit;

/*(e)��  Age, Income, Price 3���� ������ �ִ� �� ���� R square�� 0.1384 ��13.84% */        /*  <----    R-square ���� �߸���...  ???  */

proc reg data=db;
model y=x3;
quit;

/*(f)�� income�� �ִ� �� ���� R square�� 0.1063 ��10.63% */


