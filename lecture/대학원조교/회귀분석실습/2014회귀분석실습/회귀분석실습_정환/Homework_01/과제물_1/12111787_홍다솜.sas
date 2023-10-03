
/*2.10번*/

data wife;
infile "D:\P049.txt" expandtabs;
input x y;
run;

proc corr data=wife cov;  /*(a)번 공분산= 69.41293860 , (c)번 상관계수= 0.76339*/
quit;                    

/* (b)번 센티미터->미터로qkRnaus 0.01배 하는것과 마찬가지이므로 공분산은 0.01의 제곱인 0.0001배가 된다.
        따라서 0.00694129386 이다.

(d)번 상관계수는 변함이 없다.

(e)번 상관계수는 1이 된다.

(f) 아내의 키를 반응변수로 할것이다. 남자의 키가 클 수록 큰 키의 여자를 선호할것같다.*/

proc reg data=wife;
model y=x;
quit;

/* 
(g)번 H0: b1=0 , H1 : not H0
기울기의 p-value가 0.0001보다도 작기 때문에 기각할수있다.

(h)번 H0 : b0=0 , H1 : not H0
기각역R: z의 절대값>1.96
z= 3.93이기 때문에 기각할수있다.                    <----    t-분포인데.. 왜 이런 계산을 ??? 

(j)번 어느것도 적절하지 않다.

(k)번 H0 : b1=1 , H1: not H0
z=(0.69965-1)/0.06106=-4.9189322
R: z의절댓값>1.96  ∴기각할수있다.
*/




/* 3.14번 */
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

/*(a)번 H0: b5=0 , H1=not H0
기각역R: F>4.0670474264 이므로 기각할수없다.*/

proc reg data=db;
model y=x1-x6;
test x2=x5=0;
quit;

data v2;
alpha=0.05; df1=2; df2=50-6-1;
f0=finv(1-alpha,df1,df2);
put f0=;
run;

/* (b)번 H0: b2=b5=0 , H1=not H0
기각역R: F>3.2144803279 이므로 기각할수없다.*/

proc reg data=db;
model y=x1-x6;
quit;

/* (c)번 
 0.01895 ± 1.96*0.01022
∴0.01895 ± 0.0200312 */

proc reg data=db;
model y=x1 x2 x4 x5 x6;
quit;

/*(d)번 income이 제거된 모델에서 R square를 구하면 0.2678이다 
  ∴26.78%.*/

proc reg data=db;
model y=x1 x3 x5;
quit;

/*(e)번  Age, Income, Price 3개의 변수가 있는 이 모델의 R square는 0.1384 ∴13.84% */        /*  <----    R-square 값이 잘못됨...  ???  */

proc reg data=db;
model y=x3;
quit;

/*(f)번 income만 있는 이 모델의 R square는 0.1063 ∴10.63% */


