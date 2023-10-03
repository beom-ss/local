



    data exam;
        infile"D:\exam.txt" expandtabs;
        input husband wife;
run;

/*(a)*/
proc corr data=exam cov;
run;
/* 공분산은 69.4129 */

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
/* 공분산은 0.0069412939 */

/*(c)*/
proc corr data=exam cov;
run;
/* 상관계수는 0.76339 */
/*(d)*/
proc corr data=exam cov;
run;
/* c의 정답과 같다. 공분산은 자료의 데이터가 변환되는 반면에 R^2은 두 데이타 자료들에 똑같은 값이 곱해져도 데이터 자료들이
바뀌지 않기 때문이다.*/

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
/* wife를 반응변수로 하는것이 더 효과적으로 보인다. 그 이유는, 잔차제곱합, 평균제곱합에서 husband보다 더 적은 값을 갖기 떄문이다.*/


/*(g)*/
proc reg dat=exam;
model wife=husband;
run;

/* 위 결과로 실행한 결과, H0:b1=0 대 H1:b1≠0의 pvalue 값은 <0.0001 이하로써 a>p이므로 귀무가설을 기각한다.그러므로 기울기가 0이 아니라
주장은 옳다.*/

/*(h)*/

/*H0: b0=0 대 h1: b0≠0. pvalue값이 0.0002로써 매우 작으므로 유의수준 0.05하에서 귀무가설을 기각한다. */

/*(j)*/

/* (g)의 가설을 이용한다. 귀무가설을 기각한다. 그러므로 서로 비슷한 키를 가진 사람들끼리 결혼하는 경향이 있다고 할 수 있다. */

/*(k)*/
 /*위 가설들 중 g의 가설이 적절하다고 생각합니다.*/

data exam1;
        infile "D:\exam1.txt" expandtabs;
        input State$ Age Hs Income Black Female Price Sales;
        run;
 /*(a)*/
proc reg data=exam1;
        model Sales=Age Hs Income Black Female Price;
        test Female=0;
quit;
/* pvalue값이 0.8507로써 귀무가설을 채택한다. 즉, 여성의 비율은 담배소비량에 영향을 미치지 않는다.*/  <--- h0 ???

/*(b)*/
proc reg data=exam1;
        model Sales=Age Hs Income Black Female Price;
        test Female,Hs=0;
quit;

/* pvalue는 0.9789로써 귀무가설을 채택한다. 여성의 비율과 고등학교를 졸업한 25세 이상의 주민비율은 소비량에 영향을 미치지 않는다.*/  <--- h0 ???

/*(c)*/
data confidenceline;
alpha=0.05;
df=44;
t=tinv(1-alpha/2,df);
run;
/* 신뢰구간은   0.01895±2.0153675744*sqrt(0.01895)


/*(d)*/
proc reg data=exam1;
        model Sales=Age Hs Black Female Price;
quit;
/* R^2은 0.2678*/

/*(e)*/
proc reg data=exam1;
        model sales=price age income;
quit;
/* R^2은 0.3032*/

/*(f)*/

proc reg data=exam1;
        model sales=income;
quit;

/* R^2은 0.1063 */
