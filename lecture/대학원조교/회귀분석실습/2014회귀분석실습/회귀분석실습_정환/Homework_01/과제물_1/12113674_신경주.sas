/*2.10*/
/* 2.10의 데이터셋 입력*/
data huswife;
	infile "C:\Users\inha\Desktop\huswife.txt";
	input husband wife;
run; 
/*센치단위의 회귀분석*/
proc reg data=huswife;
	model husband=wife;
run;
/*(a)*/
/*센치단위의 공분산분석*/

proc corr data=huswife cov;
	var husband ;
	with wife;
run;
/* 남편과 아내의 키 사이의 공분산은 69.41293860*/
/*(b)*/ 
/*센치미터를 미터로 환산하여 데이터 입력*/
data huswife2;
	infile "C:\Users\inha\Desktop\huswife.txt";
	input husband 3.2  wife 4.2;
run;
/*미터단위의 회귀분석*/
proc reg data=huswife2;
	model husband=wife;
run;
/*미터단위의 공분산분석*/
/* (b)키가 센티미터가 아닌 미터로 측정되었을때 공분산은 0.0069412939
    (c)상관계수는 0.76339 
	(d)키를 센티미터로 했을때와 미터로 했을때의 상관계수는 같다. 왜냐하면 상관계수는 측정 단위와 관계없이 일정하기 때문이다. */
proc corr data=huswife2 cov;
	var husband;
	with wife;
run;
/*남자들이 자신보다 정확히 5센티미터 작은 여자와 결혼했을때의  데이터셋*/
data huswife3;
	infile "C:\Users\inha\Desktop\huswife.txt";
	input husband wife;
	wife2= husband-5;
	keep husband wife2;
run;
/*남자들이 자신보다 정확히 5센티미터 작은 여자와 결혼했을때의 데이터셋의 회귀분석*/
proc reg data=huswife3;
	model husband=wife2;
run;
/*남자들이 자신보다 정확히 5센티미터 작은 여자와 결혼했을때의 데이터셋의 공분산분석*/
proc corr data=huswife3 cov;
	var husband;
	with wife2;
run;
/*(e) 상관계수는 1이다.*/
/*남편과 아내의 키 중 어느것을 반응변수로 정할지를 알아보기 위해 각 각을 모두 반응 변수로 두어보았다*/
proc reg data=huswife;
	model husband=wife;
run;
proc reg data=huswife;
	model wife=husband;
run;
/*(f) 위의 두 결과에서 결정계수의 차이가 없다. 따라서 두 변수중 어느 것을 반응변수로 해도 결과는 같다고 할수있다. 
		하지만 앞으로 편의를 위해 남자의키를 반응변수로 정한다.*/
proc reg data=huswife;
	model husband=wife;
run;
/*(g)		H0: ß1=0 vs H1:ß1=0이라고 할 수 없다
		t-value의 값이 11.46이고, p-value <0.0001이므로 유의수준 0.05하에서 귀무가설을 기각한다. 
		따라서 기울기가 0이라고 할 수 없다 */
/*(h)		H0::β0=0 vs H1:β0=0이라고 할 수 없다
		t-value의 값이 3.17이고, p-value <0.0021이므로 유의수준 0.05하에서 귀무가설을 기각한다
		따라서 절편항이 0이라고 할 수 없다*/

/*(j)		비슷한 키를 가진 사람들 끼리 결혼하는 경향이 있는지를 검정하기 위해서는 ß0(절편항)이 0이며 ß1(기울기)는 양수이여야 할것이다. 이러한 경향을 검정하기 위해서는 
		이러한 경향을 검정하기 위해선 ß0=0인가를 확인하는 즉 절편항이 0인가 아닌가를 확인하는 (h)의 가설과 검정을 선택하여야 한다.
		(g)문제의 검정은 ß1의 값이 0인지를 확인하는 즉 기울기가 0인지 확인하는 검정이다. 하지만 비슷한 키를 가진 사람들끼리
		결혼한다는 경향을 확인하는 검정에서는 ß1의 값이 0인지를 판단하는 것 보다는 ß1이 양수인지 판단하는 검정이 필요하다.*/
		
/*(k)		비슷한 키를 가진 사람들끼리 결혼하는 경향을 확인하기 위해서는 ß1의 값이 양수인지를 확인하는 가설이 필요하다. 
		H0:ß1>0 vs H1:ß1>0이라고 할 수 없다. 라고 귀무가설과 대립가설을 설정한 가설이 필요하다. 
		상관계수가 0.76339이므로 남편과 아내의 키에대한 분포는 선형관계가 뚜렷하다고 할 수 있다. 
		또한 공분산이 양수 이므로 x가 증가 할때 y도 증가 하게되므로 ß>0이라는 것이 유의하다*/








/*3.14*/
/* 담배소비량 데이터셋 입력*/
data ciga;
	infile "C:\Users\inha\Desktop\ciga.txt" expandtabs firstobs=2;
	input age hs income black female price sales;
run; 
/*(a)*/
/*full model*/
proc reg data=ciga;
	model sales = age hs income black female price;
quit;
/*reduced model*/
proc reg data=ciga;
	model sales = age hs income black price;
quit;
/* H0: female=0 vs H1: female=0이라고 할 수 없다
		라는 귀무가설과 대립가설을 설정*/
proc reg data=ciga ;
	model sales = age hs income black female price ;  
	test female=0 ;
quit;
/* 이때 p-value가 0.8507 이고 유의수준 0.05내에서  H0을 기각하지못한다.
	따라서 변수 female은 sales를 예측하는데  필요하다고 말할수 없다*/
/*(b)*/
/*full mode*/
proc reg data=ciga;
	model sales = age hs income black female price;
quit;
/*reduced model*/
proc reg data=ciga;
	model sales = age income black price;
quit;
/* H0: HS=female=0vs H1:HS=female=0이라고 할 수 없다  라는 귀무가설과 대립가설을 설정*/
proc reg data=ciga ;
	model sales = age hs income black female price ;  
	test female=hs=0 ;
quit;
/*p-value가 0.9789 이고 유의수준 0.05내에서  H0을 기각하지 못한다.
	따라서  female,hs가 필요하다고 말할수 없다*/
/*(c)*/
proc reg data=ciga;
	model sales = age hs income black female price/i;
quit;
 /*t-value 값 계산*/
data tvalue ;
	alpha=0.05 ; df=50-6-1 ;
	t=tinv(1-alpha/2,df) ;
run ;
/*(c) income의 추정치는 0.01895 이고 표준오차는 0.01022 이다.
	신뢰구간은 0.01895 ±  t(0.025, 51-7)*(0.01022)이다*/

/*(d)*/
/*full model*/
proc reg data=ciga;
	model sales = age hs income black female price;
quit;
/*reduced model*/
proc reg data=ciga;
	model sales = age hs black female price;
quit;
/*(d) income을 제거하였을때 R-Squar가 0.2678로 나타난다.
	그러므로 회귀식에서 income을 제거 하였을때, 회귀식에 의아여 설명되는 sales의 변이는 0.2678%이다.*/

/*(e)*/
/*full model*/
proc reg data=ciga;
	model sales = age hs income black female price;
quit;
/*reduced model*/
proc reg data=ciga;
	model sales = price age income;
quit;
/*(e) price,age,income를 설명변수로 하였을때 R-Squar가 0.3032로 나타났다.
	그러므로 회귀식에서 price,age,income에 의하여 설명되는 sales의 변이는 0.3032%이다.*/                      

/*(f)*/
proc reg data=ciga;
	model sales = income;
quit;
/*(f) income만 남겼을때  R-Squar가 0.1063 이므로 income에 의하여 설명되는 sales의 변이는 10.63%이다.*/
