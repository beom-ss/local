/*2.10*/
data height;
infile "D:\height.txt" expandtabs firstobs=2;
input H W;
run;

/*(a)*/
proc corr data=height cov;
var H;
with W;
run;
/*���л� = 69.41293860*/

/*(b)*/
proc sql;
create table height_meter as 
select H/100 as H_m, W/100 as W_m from Height;
quit;
proc corr data=height_meter cov;
var H_m;
with W_m;
run;
/*���л� = 0.0069412939*/

/*(c)*/
proc corr data=height;
run;
/*������ = 0.76339*/

/*(d)*/
proc corr data=height_meter;
run;
/*������ = 0.76339*/

/*(e)*/
data height_5;
infile "D:\height.txt" expandtabs firstobs=2;
input H W;
H_5 = H-5;
drop W;
run;
proc corr data=height_5;
run;
/*������ =1*/

/*(f)*/
proc reg data=height;
model H=W;
run;
proc reg data=height;
model W=H;
run;
/*�Ƴ��� Ű�� ���������� �ϰڴ�.*/
/*�׷��� ���������� ������Ű, �Ƴ���Ű�� �Ҷ��� R-squre�� �����Ƿ�, �ش� �������� ���������� y��տ� ���� �� �����ϴ� ������ �����Ƿ�, ������ ��찡 ȸ�ͽ��� ���� ������ ���� �� ���̸� ������ �ʴ´ٰ� �� �� �ִ�.*/
/*������ ���л��̹Ƿ� ������ Ű�� ���� �Ƴ��� Ű�� ������ ���ϱ� ������ �Ƴ��� Ű�� ���������� �ϰڴ�.*/

/*(g)*/
proc reg data=height;
model W=H;
run;
/*H0 : b1=0�� �����Կ� �־� t-value = 11.46, p-value < 0.0001�̹Ƿ� H0�� �Ⱒ�Ѵ�. ���Ǽ���=0.05*/

/*(h)*/
proc reg data=height;
model W=H;
run;
/*H0 : b0=0�� �����Կ� �־� t-value =  3.93, p-value = 0.0002�̹Ƿ� H0�� �Ⱒ�Ѵ�. ���Ǽ���=0.05*/

/*(j)*/
/*(g)�� �������� �Ƴ���Ű�� ������Ű �����͸� regression������ ȸ�ͼ��� ���⸦ ��Ÿ���� b1�� 0�� �ƴ��� ������.(���Ǽ��� ������)*/
/*�Դٰ� b1�� ����ġ�� ���� 0.69965�� �����Ƿ� ���� ���⸦ ���´ٰ� �����ϰ� �ִ�.*/
/*���� ��������� ����� Ű�� ���డ ���� ��ȥ�ϴ� ������ ������ �� �� �ִ�.*/

/*(k)*/
/*�� ������ ������ = 0.76339 �̰� ���л��� ������� �������� ������Ű�� �Ƴ���Ű �����Ͱ� ���� ���� ���� ���� ������� ������ �� �� �ִ�. */


/*3.14*/
data cig;
infile "D:\cigarrete.txt" expandtabs firstobs=2;
input state$ age hs income black female price sales;
run;

/*(a)*/
/*full model*/
proc reg data=cig;
model sales=age hs income black female price;
run;
/*reduced model*/
proc reg data=cig;
model sales=age hs income black price;
run;
/*test*/
proc reg data=cig ;
	model sales=age hs income black female price;  
	test female=0 ;
quit;
/*H0: female=0  vs  H1: female!=0*/
/*F-value=0.04, P-value=0.8507�̹Ƿ� ���Ǽ��� 0.05���� H0�� �Ⱒ�� �� ����.*/
/*���� ���� �𵨿��� female������ �ʿ��ϴٰ� ���� �� ����.*/

/*(b)*/
/*full model*/
proc reg data=cig;
model sales=age hs income black female price;
run;
/*reduced model*/
proc reg data=cig;
model sales=age income black price;
run;
/*test*/
proc reg data=cig ;
	model sales=age hs income black female price;  
	test female=hs=0 ;
quit;
/*H0: female=hs=0  vs  H1: female!=0 or hs!=0*/
/*F-value=0.02, P-value=0.9789�̹Ƿ� ���Ǽ��� 0.05���� H0�� �Ⱒ�� �� ����.*/
/*���� ���� �𵨿��� female�� hs�� ��� �ϳ��� ������ �ʿ��ϴٰ� ���� �� ����.*/

/*(c)*/
proc reg data=cig;
model sales=age hs income black female price /i;
run;
data tvalue ;
alpha=0.05 ; df=51-6-1;
t=tinv(1-alpha/2,df) ;
run ; 
/*income�� ����ġ��  0.01895, Standard Error�� 0.01022�̰�, tvalue�� 2.0153675744�̹Ƿ� �ŷڱ�����  0.01895�� 2.0153675744*0.01022�̴�. ��,  ����(-0.001647057, +0.03954705661 )�̴�.*/


/*(d)*/
proc reg data=cig;
model sales=age hs black female price;
run;
/*income������ ������ �𵨿��� R-squre�� 0.2678�̹Ƿ� �� 26.78%��� �� �� �ִ�..*/
/*R-squre�� SSR/SST�μ� SST(��ü ����)�߿� SSR(���� ������ ���� ����Ǵ� ����)�� �����ϴ� ������ ��Ÿ���Ƿ�.*/

/*(e)*/
proc reg data=cig;
model sales=age income price;
run;
/*age income price������ ������ �𵨿��� R-squre�� 0.3032�̹Ƿ� ��30.32%��� �� �� �ִ�..*/
/*R-squre�� SSR/SST�μ� SST(��ü ����)�߿� SSR(���� ������ ���� ����Ǵ� ����)�� �����ϴ� ������ ��Ÿ���Ƿ�.*/

/*(f)*/
proc reg data=cig;
model sales=income;
run;
/*income�������� ������ �𵨿��� R-squre�� 0.1063�̹Ƿ� �� 10.63%��� �� �� �ִ�.*/
/*R-squre�� SSR/SST�μ� SST(��ü ����)�߿� SSR(���� ������ ���� ����Ǵ� ����)�� �����ϴ� ������ ��Ÿ���Ƿ�.*/
