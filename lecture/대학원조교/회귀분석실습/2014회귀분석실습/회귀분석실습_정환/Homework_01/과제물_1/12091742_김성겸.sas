data height;
infile "D:\table2.11.txt" expandtabs firstobs=2;
input Husband Wife;
run;
/* D드라이브에 데이터파일 저장 후 불러오기, Husband 남편키 Wife 부인키*/

proc corr data=height cov;
var Husband;
with Wife;
run;
/*(a) Husband와 Wife의 키 사이의 공분산은 69.41293860이고
(c)상관계수는 0.76339이다.*/

proc sql;
create table height_inch as
select Husband*0.393701 as H_inch, Wife*0.393701 as W_inch
from height;
quit;
/*sql문을 이용하여 cm키에 0.393701를 곱하여 inch키로 변환하여 height_inch 테이블에 저장*/

proc corr data=height_inch cov;
var H_inch ;
with W_inch;
run;
/* (b) inch로 변환한 남편과 부인키 사이의 공분산은 10.75903862
(d) inch로 변환해서 얻은 상관계수는 0.76339이므로 cm와 같음을 알 수 있다.*/

proc sql;
create table height_5 as
select Husband,Husband-5 as Wife_5
from height;
quit;
/*남편보다 5cm작은 부인의 키(Wife_5)를 height_5에 생성한다.*/

proc corr data=height_5;
var Husband;
with Wife_5;
run;
proc plot data=height_5;
plot Husband*Wife_5;
run;
/*(e)상관계수는 1이다. plot생성시 직선관계가 강함을 알 수 있다.*/

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
/*(f)  plot 을 비교해봐도 큰 차이가 없고 R-square도 같고 모두 beta0 와 beta1을 기각하므로 
어느 것을 종속변수로 잡아도 상관없다. 다만 그려지는 직선의 기울기와 절편에는 차이가 있지만
결과를 바꿀만큼의 영향은 없어보인다.
 (g)(h)종속변수를 어느것을 잡아도  회귀분석 결과 beta0,beta1이 기각함을 알 수 있다.     <---  검정과정??? 2문제 모두 없음...
 (j)(k) 남편키와 아내키의 corr값이 0.7634이므로 비슷한 키의 남녀가 결혼한다고 생각할 수 있다.*/

data ciga;
infile "D:\table3.17.txt" expandtabs firstobs=2;
input state$ age HS income black female price sales;
run;

proc reg data=ciga;
model sales=age HS income black female price;
test female=0;
run;
/*(a)FM은 여섯개변수 모두 들어간 모델
   RM은 female을 제외한 다섯개변수가 들어간 모델
H0: female=0 이고 검정결과 귀무가설을 기각하지 못함을 알 수 있다.
따라서 sales를 설명하는데 female변수가 필요하다고 말할 수  없다.*/

proc reg data=ciga;
model sales=age HS income black female price;
test female=HS=0;
run;
/*(b)RM은 female HS를 제외한 네개변수가 들어간 모델
H0: female=HS=0 이고 검정결과 귀무가설을 기각하지 못함을 알 수 있다.
따라서 sales를 설명하는데 female,HS변수가 필요하다고 말할 수 없다.*/

data tvalue ;
alpha=0.05 ; df=51-6-1 ;
t=tinv(1-alpha/2,df) ;
run ; 

/*t(alpha/2,n-p-1)인 통계량 계산 2.0153675744*/

proc reg data=ciga;
model sales= age HS income black female price/i;
run;
/*income의 추정치와 standard error와 Root MSE, Cii(C_income) 값을 얻는다
standard error=Root MSE*sqrt(Cii) 이다*/

data interval;
upper=0.01895+2.0153675744*0.01022;
lower=0.01895-2.0153675744*0.01022;
run;
/*(c)beta_income_hat +- t(0.05/2,44) *standard error 이고
그 값은 (-0.001647057, 0.0395470566) 이다.*/

proc reg data=ciga;
model sales=age HS income black female price;
run;
/*여섯개 변수 모두 있을때 R-square값은 0.3208*/

proc reg data=ciga;
model sales=age HS black female price;
run;
/*(d)income 변수를 제외하고 나머지 변수들에 의해 sales에 관한 회귀분석을 돌려본 결과
R-square값이 0.2678 이므로 나머지 변수들에 의해 26.78% 설명된다 */

proc reg data=ciga;
model sales= price age income;
run;
/*(e) 위의 세 변수로 sales를 설명할 수 있는 %는 R-square=0.3032이므로 30.32%이다 */

proc reg data=ciga;
model sales=income;
run;
/*(f) income만으로 설명할 수 있는 %는 10.63%이다.*/
