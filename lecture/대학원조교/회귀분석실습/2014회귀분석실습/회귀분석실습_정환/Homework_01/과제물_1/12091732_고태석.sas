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
/*공분산 = 69.41293860*/

/*(b)*/
proc sql;
create table height_meter as 
select H/100 as H_m, W/100 as W_m from Height;
quit;
proc corr data=height_meter cov;
var H_m;
with W_m;
run;
/*공분산 = 0.0069412939*/

/*(c)*/
proc corr data=height;
run;
/*상관계수 = 0.76339*/

/*(d)*/
proc corr data=height_meter;
run;
/*상관계수 = 0.76339*/

/*(e)*/
data height_5;
infile "D:\height.txt" expandtabs firstobs=2;
input H W;
H_5 = H-5;
drop W;
run;
proc corr data=height_5;
run;
/*상관계수 =1*/

/*(f)*/
proc reg data=height;
model H=W;
run;
proc reg data=height;
model W=H;
run;
/*아내의 키를 반응변수로 하겠다.*/
/*그러나 반응변수를 남편의키, 아내의키로 할때의 R-squre가 같으므로, 해당 설명변수가 반응변수를 y평균에 비해 잘 설명하는 정도는 같으므로, 양쪽의 경우가 회귀식의 좋은 정도에 대해 별 차이를 보이지 않는다고 할 수 있다.*/
/*본인은 남학생이므로 남편의 키에 따른 아내의 키의 성향을 원하기 때문에 아내의 키를 반응변수로 하겠다.*/

/*(g)*/
proc reg data=height;
model W=H;
run;
/*H0 : b1=0를 검정함에 있어 t-value = 11.46, p-value < 0.0001이므로 H0를 기각한다. 유의수준=0.05*/

/*(h)*/
proc reg data=height;
model W=H;
run;
/*H0 : b0=0를 검정함에 있어 t-value =  3.93, p-value = 0.0002이므로 H0를 기각한다. 유의수준=0.05*/

/*(j)*/
/*(g)의 검정에서 아내의키와 남편의키 데이터를 regression했을때 회귀선의 기울기를 나타내는 b1이 0이 아님을 밝혔다.(유의수준 내에서)*/
/*게다가 b1의 추정치를 보면 0.69965를 가지므로 양의 기울기를 갖는다고 추정하고 있다.*/
/*따라서 상대적으로 비슷한 키의 남녀가 서로 결혼하는 경향이 있음을 알 수 있다.*/

/*(k)*/
/*두 변수의 상관계수 = 0.76339 이고 공분산이 양수임을 보았을때 남편의키와 아내의키 데이터가 서로 비교적 높은 양의 상관성이 있음을 알 수 있다. */


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
/*F-value=0.04, P-value=0.8507이므로 유의수준 0.05에서 H0를 기각할 수 없다.*/
/*따라서 위의 모델에서 female변수는 필요하다고 말할 수 없다.*/

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
/*F-value=0.02, P-value=0.9789이므로 유의수준 0.05에서 H0를 기각할 수 없다.*/
/*따라서 위의 모델에서 female나 hs중 적어도 하나의 변수는 필요하다고 말할 수 없다.*/

/*(c)*/
proc reg data=cig;
model sales=age hs income black female price /i;
run;
data tvalue ;
alpha=0.05 ; df=51-6-1;
t=tinv(1-alpha/2,df) ;
run ; 
/*income의 추정치는  0.01895, Standard Error는 0.01022이고, tvalue는 2.0153675744이므로 신뢰구간은  0.01895± 2.0153675744*0.01022이다. 즉,  구간(-0.001647057, +0.03954705661 )이다.*/


/*(d)*/
proc reg data=cig;
model sales=age hs black female price;
run;
/*income변수를 제외한 모델에서 R-squre가 0.2678이므로 약 26.78%라고 할 수 있다..*/
/*R-squre는 SSR/SST로서 SST(전체 변이)중에 SSR(이중 모형에 의해 설명되는 변이)가 차지하는 비율을 나타내므로.*/

/*(e)*/
proc reg data=cig;
model sales=age income price;
run;
/*age income price변수만 포함한 모델에서 R-squre가 0.3032이므로 약30.32%라고 할 수 있다..*/
/*R-squre는 SSR/SST로서 SST(전체 변이)중에 SSR(이중 모형에 의해 설명되는 변이)가 차지하는 비율을 나타내므로.*/

/*(f)*/
proc reg data=cig;
model sales=income;
run;
/*income변수만을 포함한 모델에서 R-squre가 0.1063이므로 약 10.63%라고 할 수 있다.*/
/*R-squre는 SSR/SST로서 SST(전체 변이)중에 SSR(이중 모형에 의해 설명되는 변이)가 차지하는 비율을 나타내므로.*/
