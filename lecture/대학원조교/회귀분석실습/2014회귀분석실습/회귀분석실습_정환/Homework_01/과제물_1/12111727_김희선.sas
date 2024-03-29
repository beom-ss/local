data one;
input H W;
cards;
186 175 
180 168
160 154
186 166
163 162
172 152
192 179
170 163
174 172
191 170
182 170
178 147
181 165
168 162
162 154
188 166
168 167
183 174
188 173
166 164
180 163
176 163
185 171
169 161
182 167
162 160
169 165
176 167
180 175
157 157
170 172
186 181
180 166
188 181
153 148
179 169
175 170
165 157
156 162
185 174
172 168
166 162
179 159
181 155
176 171
170 159
165 164
183 175
162 156
192 180
185 167
163 157
185 167
170 157
176 168
176 167
160 145
167 156
157 153
180 162
172 156
184 174
185 160
165 152
181 175
170 169
161 149
188 176
181 165
156 143
161 158
152 141
179 160
170 149
170 160
165 148
165 154
169 171
171 165
192 175
176 161
168 162
169 162
184 176
171 160
161 158
185 175
184 174
179 168
184 177
175 158
173 161
164 146
181 168
187 178
181 170
;
run;


proc reg data=one;  
model W =H;    
quit;

proc corr data=one cov;   /* (a) 프로그램을 돌렸을 때 공분산이  69.4129 라는 값을 얻었다  (c) 상관계수는 0.76339.*/
var w;
with h;
run;

data two;    /*키를 미터로 바꾸기 위해 각각의 변수에 0.01을 곱해준다*/
set one;
w2=w*0.01;
h2=h*0.01;
run;

proc corr data=two cov;   /* (b) 프로그램을 돌렸을 때 공분산이  0.00694129 라는 값을 얻었다.  (d) 상관계수는 0.76339*/
var w2;
with h2;   
quit;

data three;  /* 남자들의 키에서 정확히 5센티미터를 뺀다. */
set one;
h2=h-5;
run;
proc corr data=three cov;  /* (e) 상관계수는 1 */
var h;
with h2;
run;/*f*/
 
proc plot data=one;  
plot  w*h;
run;

proc plot data=one;
plot h*w;
run;

proc corr data=one cov;
var h;
with w;

proc reg data=one;
model W =H;    /* (f)  r sqaure는  0.5828 로 동일하고 plot 을 그려봐도 차이가 별로 없으므로 
                           키큰여자가 키큰남자를 선호한다는 가정 하에 여자를 반응변수로 둔다.*/
quit;
proc reg data=one;
model w=h;
quit;
/*  (g) h0 : 기울기=0 vs h1 : 기울기가 0이아니다
기각역=0.05
p값을 보면 0.001보다 작으므로 기각가능하다*/                          /* <----------- 기각역이 아니라 유의수준이라고 써야 하지만, 따로 유의수준보다 작다고 명시했으므로 감점하지 않음. */

/*(h)  h0 : 절편이 0 이다. vs h1 : 절편이 0이 아니다. 
기각역 = 0.05
p값을 보면 유의수준인 0.05보다 작은 0.0021의 값을 가지므로 기각가능하다 */

/*(j) 가설을 검정하기위하여 위 가설들중 어느것도 적절하지 않다.*/

/* (k) h0 :  기울이가 1이다
  통계량t=(0.83292-1)/0.07269=-2.2985
 R: |-2.2985|>1.9852이므로 
기각가능 따라서 비슷한 키를 가진 사람들끼리 결혼하는 경향이 있다. */
data tvalue;  
alpha=0.05;
df=96-1;
t=tinv(1-alpha/2,df);
put t=;
run; /*  기각역을 구하기 위해 t-value 를 구한다.  1.9852  */

data homework;
input state age hs income black female price sales;
cards;
al 27.0 41.3 2948.0 26.2 51.7 42.7 89.8
ak 22.9 66.7 4644.0 3.0 45.7 41.8 121.3
az 26.3 58.1 3665.0 3.0 50.8 38.5 115.2
ar 29.1 39.9 2878.0 18.3 51.5 38.8 100.3
ca 28.1 62.6 4493.0 7.0 50.8 39.7 123.0
co 26.2 63.9 3855.0 3.0 50.7 31.1 124.8
ct 29.1 56.0 4917.0 6.0 51.5 45.5 120.0
de 26.8 54.6 4524.0 14.3 51.3 41.3 155.0
dc 28.4 55.2 5079.0 71.1 53.5 32.6 200.4
fl 32.3 52.6 3738.0 15.3 51.8 43.8 123.6
ga 25.9 40.6 3354.0 25.9 51.4 35.8 109.9
hi 25.0 61.9 4623.0 1.0 48.0 36.7 82.1
id 26.4 59.5 3290.0 0.3 50.1 33.6 102.4
il 28.6 52.6 4507.0 12.8 51.5 41.4 124.8
in 27.2 52.9 3772.0 6.9 51.3 32.2 134.6
ia 28.8 59.0 3751.0 1.2 51.4 38.5 108.5
ks 28.7 59.9 3853.0 4.8 51.0 38.9 114.0
ky 27.5 38.5 3112.0 7.2 50.9 30.1 155.8
la 24.8 42.2 3090.0 29.8 51.4 39.3 115.9
me 28.0 54.7 3302.0 0.3 51.3 38.8 128.5
md 27.1 52.3 4309.0 17.8 51.1 34.2 123.5
ma 29.0 58.5 4340.0 3.1 52.2 41.0 124.3
mi 26.3 52.8 4080.0 11.2 51.0 39.2 128.6
mn 26.8 57.6 3859.0 0.9 51.0 40.1 104.3
ms 25.1 41.0 2626.0 36.8 51.6 37.5 93.4
mo 29.4 48.8 3781.0 10.3 51.8 36.8 121.3
mt 27.1 59.2 3500.0 0.3 50.0 34.7 111.2
nb 28.6 59.3 3789.0 22.7 51.2 34.7 108.1
nv 27.8 65.2 4563.0 5.7 49.3 44.0 189.5
nh 28.0 57.6 3737.0 0.3 51.1 34.1 265.7
nj 30.1 52.5 4701.0 10.8 51.6 41.7 120.7
nm 23.9 55.2 3077.0 1.9 50.7 41.7 90.0
ny 30.4 52.7 4712.0 11.9 52.2 41.7 119.0
nc 26.5 38.5 3252.0 22.2 51.0 29.4 172.4
nd 26.4 50.3 3086.0 0.4 49.5 38.9 93.8
oh 27.7 53.2 4029.0 9.1 51.5 38.1 121.6
ok 29.4 51.6 3387.0 6.7 51.3 39.8 108.4
or 29.0 60.0 3719.0 1.3 51.0 29.0 157.0
pa 30.7 50.2 3971.0 8.0 52.0 44.7 107.3
ri 29.2 46.4 3959.0 2.7 50.9 40.2 123.9
sc 24.8 37.8 2990.0 30.5 50.9 34.3 103.6
sd 27.4 53.3 3123.0 0.3 50.3 38.5 92.7
tn 28.1 41.8 3119.0 15.8 51.6 41.6 99.8
tx 26.4 47.4 3606.0 12.5 51.0 42.0 106.4
ut 23.1 67.3 3227.0 0.6 50.6 36.6 65.5
vt 26.8 57.1 3468.0 0.2 51.1 39.5 122.6
va 26.8 47.8 3712.0 18.5 50.6 30..2 124.3
wa 27.5 63.5 4053.0 2.1 50.3 40.3 96.7
wv 30.0 41.6 3061.0 3.9 51.6 41.6 114.5
wi 27.2 54.5 3812.0 2.9 50.9 40.2 106.4
wy 27.2 62.9 3815.0 0.8 50.0 34.4 132.2
;
run;

proc reg data=homework;
model sales = age hs income black female price;
test female = 0;
quit;
/*  (a)    h0 : female=0 
p값이 유의수준인 0.05보다 큰 0.9379 이므로 귀무가설을 기각 할 수 없다 . 
따라서 female 은 sales 를 설명하는데 유의한 변수라고 할 수 없다. */

proc reg data=homework;
model sales = age hs income black female price;
test female = hs =  0;
quit;
/**  (b)    h0 : female= hs =  0 
p값이 유의수준인 0.05보다 큰 0.9098 이므로 귀무가설을 기각 할 수 없다 . 
따라서 female과 hs 는 sales 를 설명하는데 유의한 변수라고 할 수 없다. */

proc reg data = homework;
model sales = age hs income black female price;
quit;

data tvalue;
	alpha=0.05;
	df=(51-6-1);
	t=tinv(1-alpha/2,df);   /*2.0154*/
	put t=;
run;

/*    (c)  신뢰구간 : 0.02195  +- 2.0154*0.01016
                 = 0.02195 +- 0.0205*/


proc reg data = homework;
model sales = age hs  black female price;
quit;
/*  (d)  r sqaure =  0.2514  
    위의 회귀식에서 income 을 제거 했을 때 회귀식에 의하여 설명되는 sales의 변이는 25.14 % 이다 */

proc reg data = homework;
model sales = hs  black female ; 
quit;
/*  (e)  r sqaure = 0.0747
    위의 회귀식에서 income, age, price 을 제거 했을 때 회귀식에 의하여 설명되는 sales의 변이는7.47% 이다.  */

proc reg data = homework;
model sales = income;
quit;
/* (f)  r sqaure = 0.1063 
    오직 income에 대해서만 sales를 회귀시켰을 때  income에 의하여  설명되는 sales의 변이는 10.63 % 이다 */

