##### 기초통계량
# 전선데이터에 대한 기초 통계량
# 예)A 전선을 끊기 위해 필요한 힘을 알아보기 위해 측정한 데이터는 다음과 같다. 16p
y<-c(5.8, 8.0, 9.3, 7.2, 7.8, 10.3, 11.2, 10.8, 9.7, 8.5)
mean(y) # mean
sd(y) # standard deviation
var(y) # variance
summary(y)
plot(y)
boxplot(y, ylab="Strength")

###########################

#추정
# 예)전선데이터는 정규분포를 따른다고 한다. 평균에 대한 95% 신뢰구간을 구하고자 한다. 18p
y<-c(5.8, 8.0, 9.3, 7.2, 7.8, 10.3, 11.2, 10.8, 9.7, 8.5)
n<-length(y)
y.m<-mean(y)
y.sd<-sd(y)
z<-qnorm(0.975, mean=0, sd=1)
bound<-z*y.sd/sqrt(n)
lo<-y.m-bound # lower bound
up<-y.m+bound # upper bound
lo
up

###########################

##### 분산에 대한 검정
# 일집단 모분산에 대한 카이제곱 검정
# 예)전선에 대한 힘 데이터는 정규분포를 따른다고 할때 다음을 구하시오. 22p
# (1) 분산에 대한 추정값과 95% 신뢰구간을 구하고자 한다.
var(y)
alpha<-0.05
lo<-(n-1)*var(y)/qchisq(alpha/2, df=n-1)
up<-(n-1)*var(y)/qchisq(1-alpha/2, df=n-1)
lo
up

# (2) H0 : sigma^2=3.5 vs H1 : Not H0 가설에 대해 alpha=0.05에서 검정하시오.
sigma0<-3.5
chi.t<-var(y)*(length(y)-1)/sigma0
chi.t
pchisq(chi.t, length(y)-1, lower.tail=var(y) < sigma0) * 2

# (3) H0 : sigma^2 > 3.5 vs H1 : sigma^2 <= 3.5에 대해 유의수준 alpha=0.05에서 검정한다.
pchisq(chi.t, length(y)-1, lower.tail=var(y) < sigma0)

# 이집단 모분산에 대한 F-검정
# 예)두 종류의 지혈제 A와 B의 효과를 측정한 데이터이다. 실험 참여자에게 같은 상처를 낸 후 지혈될 때까지의 시간을
# 측정하였으며 모집단은 정규분포를 따른다고 한다. 지혈제 A와 B의 분산 차이가 있는지 검정하고자 한다.
# (1) 통계적 가설 H0 : sigmaA^2 = sigmaB^2 vs H1 : Not H0
# (2) var.test()를 이용한 이집단 양측검정
x1<-c(1.1, 2.3, 4.3, 2.2, 5.3, 6.5, 7.0)
x2<-c(3.3, 4.3, 3.5, 3.6)
var.test(x1,x2)
#결론
# 유의수준 5%에서 지현제 A와 B의 분산 차이가 유의하다고 할 수 있다. 모분산비 sigmaA^2/sigmaB^2 추정값은 27.7533이고
# 모분산비에 대한 95% 신뢰구간은 (1.883531 183.138461)이다.

###########################

#####평균에 대한 검정
# 일집단 t-검정 : 소표본이며 모분산 sigma^2을 모르는 경우
# 예) 전선에 대한 힘 데이터는 정규분포를 따른다고 한다.
# (a) 힘의 평균이 기존 전선의 평균이 7과 다르다고 할 수 있는지 검정하고자 한다.
#  (1) 가설 H0 : mu=7.0 vs H1 : Not H0
#  (2) t.test()를 이용한 t-검정
y<-c(5.8, 8.0, 9.3, 7.2, 7.8, 10.3, 11.2, 10.8, 9.7, 8.5)
#  (3) 결론

#   (3-1) 양측검정 : H0 : mu=7.0 vs H1 : Not H0
t.test(y, mu=7.0, alt="two.sided")
#유의수준 5%에서 힘 평균은 7.0이 아니라고 할 수 있다. 모평균 추정값은 8.86이고 모평균에 대한 95% 신뢰구간은 (7.636575 10.083425)이다.

#   (3-2) 단측검정(H0 : mu<=7.0 vs H1 : mu>7.0)
#유의수준 5%에서 힘 평균은 7.0이 크다고 할 수 있다. 모평균 추정값은 8.86이고 모평균에 대한 95% 신뢰구간은 (7.868611 Inf)이다.
t.test(y, mu=7.0, alt="greater")

#   (3-3) 단측검정(H0 : mu<=7.0 vs H1 : mu<7.0)
t.test(y, mu=7.0, alt="less")
#유의수준 5%에서 힘 평균은 7.0보다 작다고 할 수 있는 통계적 근거가 있다고 할 수 없다. 모평균 추정값은 8.86이고 모평균에 대한 95% 신뢰구간은 ( -Inf 9.851389)이다.

# 일집단 t-검정 : 소표본이며 모분산 sigma^2을 아는 경우
# 예) 다음은 암컷 원숭이의 몸무게를 조사한 자료이다.(단위kg) 원숭이 몸무게는 분산이 1.0인 정규분포를 따른다고 한다. 암컷 원숭이의 평균 몸무게가 8.5kg이라고 할 수 있는지 검정하고자 한다.
x<-c(8.30, 9.50, 9.60, 8.75, 8.40, 9.10, 8.15, 8.80)
mu0<-8.5
sigma<-1
z<-(mean(x)-mu0)/(1/sqrt(length(x)))
z
pvalue<-pnorm(z, 0, 1, lower=(mean(x)<mu0)) * 2
pvalue

# 이집단 t-검정 : 소표본이며 모분산을 모르며 sigma1^2 not= sigma2^2인 경우 31p
# 예) 두 종류의 진통제 A와 B의 효과를 측정한 데이터이다. 두통이 있는 실험 참여자에게 같은 진통이 완화될 때까지의 시간을 측정하였으며 모집단은 정규분포를 따른다고 한다. 진통제 A와 B의 효과가 차이가 있는지 검정하고자 한다.
x1<-c(1.1, 2.3, 4.3, 2.2, 5.3) # A 진통제
x2<-c(2.3, 4.3, 3.5) # B 진통제
t.test(x1,x2, var.equal=T, alternative="two.sided") # 등분산 경우 ( default = two.sided)
# p-value값 = 0.7775>0.05=alpha이므로 H0를 기각하지 못한다. 유의수준 5%에서 지혈제 A와 B의 효과가 차이가 난다고 할 수 있는 통계적 근거가 없다.
t.test(x1,x2, var.equal=F) # 이분산 경우

var.test(x1,x2) # 두 진통제의 분산이 다르다고 할 수 있는지 검정해 보자.
# p-value값 = 0.5465 > 0.05 = alpha이므로 H0를 기각하지 못한다. 그러므로 분산이 동일한 경우의 이집단 t-검정을 할 수 있다.

# 짝지어진 t-검정(사전 사후 Data)
# 예) A 대학에서 랜덤하게 선택된 10명의 학생을 대상으로 집중학습법 강좌 수강 전후의 B과목 시험점수를 얻었다. 모집단은 정규분포를 따른다고 할 수 있다. 다음의 가설에 대해 검정하고자 한다.
# H0 : 강좌 수강 전 후 점수 차이가 없다. VS H1 : 강좌 수간 전 후 점수 차이가 있다.
pre<-c(77, 56, 64, 60, 58, 72, 67, 78, 67, 79) # 전 시험점수
post<-c(99, 80, 78, 65, 59, 67, 65, 85, 74, 80) # 후 시험점수
t.test(post, pre, paired=T) # 사후 - 사전 : 효과가 있다면 값이 +로 나와 보기가 편하다.
# p-value=0.04052 < 0.05=alpha이므로 유의수준 alpha=0.05에서 H0를 기각한다. 즉 강좌 수강 전후 점수 차이가 유의하므로 강좌 효과가 유의 한다.

###########################
##### 완전확률화설계 51p
# 쉽게 말해서 셋 이상의 집단으로 k개 집단의 평균들 간 비교 문제 H0 : mu_1=mu_2=...=mu_k
# 이것을 분석하는 방법을 분산분석법(ANOVA)이라 한다.

# 일원배치 완전확률화 설계(Completely Randomized design : CRD)
# 예) 처리그룹=5, 반복=4인 데이터를 얻었다. 그룹간 평균 차이가 있는지 분석하고자 한다.
# tip 분석시 object명을 head(object) 할 경우. 추가적으로 활용 가능한 명령어들을 보여준다.
y<-c(2.4, 2.7, 3.1, 3.1,
     0.7, 1.6, 1.7, 1.8,
     2.4, 3.1, 5.4, 6.1,
     0.3, 0.3, 2.4, 2.7,
     0.5, 0.9, 1.4, 2.0)
group<-c(rep(1,4), rep(2,4), rep(3,4), rep(4,4), rep(5,4))
sol<-cbind(group, y)
group<-as.factor(group)
aov1<-aov(y~group)
summary(aov1) # ANOVA table
# 검정통계량 F = 5.966이고 p-value=0.004 < 0.05=alpha 이므로 유의수준 0.05에서 H0를 기각한다. 즉 5개 처리간 평균이 모두 동일하다고 할 수 없다.
boxplot(y~group) #boxplot plot(y~group)
tapply(y, group, mean) # 그룹간 평균
sort(tapply(y, group, mean)) # 그룹간 오른차순 정렬
summary.lm(aov1) #group contribution


par(mfrow=c(2,2))
plot(aov1) # model diagnostic plots
# 위 왼쪽 : 잔차그림 = (적합 반응값, 잔차)를 점 찍은 그림으로 잔차의 패턴을 볼 수 있다. 적합 반응값이 큰 경우 약간 큰 잔차가 있음이 보인다.
# 위 오른쪽 : Q-Q plot 정규분포를 반족하면 직선위에 놓이게 된다. 현재 표준화 잔차들이 직선에서 크게 벗어나지 않음을 알 수 있다.
# 아래 왼쪽 : 표준화 잔차 그림 = 정규분포를 만족하면 잔차의 95% (0, 2)사이에 놓인다. 그리고 각 적합 반응값에서 평균 잔차를 이은 빨간선은 이상적인 경우 즉, 그룹간 잔차가 경향이 없는 경우, 수평이 된다.
# 아래 오른쪽 : 그룹변 표준화 잔차 = (그룹수준값, 잔차)를 점 찍은 그림으로 잔차들의 경향을 볼 수 있다. 그룹 1과 2에서 잔차의 퍼짐이 작아 보인다.

# 5개 처리간 분산은 동일한지 검정하시오.
bartlett.test(y~group)
# p-value=0.06677>0.05=alpha 이므로 유의수준 0.05에서 H0를 기각하지 못한다. 즉, 5개 처리간 분산은 동일하다고 간주할 수 있다.

###########################
# 사후검정 또는 다중비교(그룹간 평균을 오름차순으로 해놓고 하는 것이 나중에 편함.)
tapply(y, group, mean)
pairwise.t.test(y, group, p.adjust="none", pool.sd=T) # LSD, 그룹별 평균차이가 유의한지 검정 유의하지 않으면 밑줄을 그어 표시한다.
sort(tapply(y, group, mean)) # {5,4,2},{1,3} 또는 {5}, {4,2,1}, {3}의 그룹으로 묶을 수 있다.

pairwise.t.test(y, group, p.adjust="bonferroni", pool.sd=F) # bonferroni방법 bonferroni방법의 평균차가 유의하지 않으면 밑줄을 그어 표현하는데 세부 그룹으로 나우어지지 않는다.
# bonferroni방법은 LSD방법에 비해 매우 보수적으로 처리평균간 차이가 유의하다는 결정을 쉽게 내리지 않는다.

a.tukey<-TukeyHSD(aov1, ordered=T) # TukeyHSD : 평균차이별 tukey다중비교 이며 신뢰구간95%주며 여기서 신뢰구간이 0을 포함하면 귀무가설을 기각하지 못한다. 유의수준 alpha=0.05에서 평균차가 유의하지 않으면 밑줄을 그어 표현한다.
a.tukey
plot(a.tukey) # {5,4,2,1},{3} 또는 {5,4,2},{1,3}의 그룹으로 묶여지는 것을 알 수 있다.

# 사후검정 또는 다중비교 agricolae패키지를 이용해 LSD, Tukey, Scheffe, SNK 구하기
install.packages("agricolae")
library(agricolae)
aov1<-aov(y~group)

LSD.test(aov1, "group", p.adj="none", main="Y of different groups", console=T)
# LSD에 사용된 유의수준 5% 기각값은 1.603317이고, 그룹과 결과는 아래에 a, b, c로 표시되어 있다. 위에서와 같이 밑줄그은 결과는
# 5 4 2 1 3 
# -----
#   -----
#       ---

HSD.test(aov1, "group", group=T, console=T)
# 그룹화가 {3,1}, {2,4,5} 또는 {3},{1,2,4,5}로 그룹화 된다.

scheffe.test(aov1, "group", group=T, main="Y of different groups", console=T)
# scheffe방법은 Tukey HSD방법과 결과가 같다.

SNK.test(aov1, "group", main="Y of different groups", console=T)
# SNK 방법에 의한 결과도 Tukey HSD방법과 결과가 같다.

#### 처리간 대비(회귀분석의 dummy처럼 생각하면 조금 더 쉽게 다가온다.)
k<-5
control<-1
contr.treatment(k, base=control, contrasts=T) # base에 그룹번호를 쓰면 control group을 지정 해줄 수 있다. 1,2,3 해보기
# shows treatment contrasts, compares with baseline level(control) as -1

# 처리간 대비 
# C2 : -mu1+mu2 =0
# C3 : -mu1+mu3 =0
# C4 : -mu1+mu4 =0
# C5 : -mu1+mu5 =0

summary.lm(aov1) # contrast contribution
# 유의수준 alpha=0.05에서 대비 C2에 대한 검정 결과 p-value=0.0875 > 0.05=alpha이므로 귀무가설 H0 : -mu1 + mu2 =0을 기각하지 못하므로 mu1=m,u2관계가 있다고 볼 수 있다.
# 해석 방식은 동일
# C5에 대한 검정 결과 p-value=0.0473 < 0.05=alpha이므로 귀무가설 H0 : -mu1+mu5=0을 기각하므로 mu1 not= mu5 관계가 있다고 볼 수 있다. 
# 그러므로 대비에 대한 검정에서는 귀무가설을 기각하지 못할 경우 처리평균간의 관계를 알려준다.

# 처리제곱합을 직교다항대비로 분해하고 각 대비에 대한 검정을 하고자 한다.
contrasts(group)<-contr.poly(levels(group)) # polynomial contrast fit
contrasts(group)
round(contrasts(group), digits=2) # 반올림 명령어
# group.L,Q,C,^4는 각각 선형,2차,3차,4차를 나타내는 다항식으로 구성되는 각 대비에서 처리평균에 해당되는 계수들을 다음과 같이 보여준다.

summary.lm(aov(y ~ group))
# group.L = 유의수준 5%에서 H0 : -0.63*mu1-0.32*mu2+0.32*mu4+0.63*mu5=0을 기각하지 못하므로 처리평균간에 선형관계가 있다고 볼 수 있다.
# 해석 방식은 동일
# 4차 다항식 관계는 검정결과 4차 다항식 관계는 있다고 볼 수 없다. 이와 같이 대비에 대한 검정으로 처리평균간의 관계를 알 수 있다.

# 계수표의 다항식 대비 계수를 이용하여 대비에 대한 검정
contrastmatrix<-cbind(c(-2, -1, 0, 1, 2), c(2, -1, -2, -1, 2), c(-1, 2, 0, -2, 1), c(1, -4, 6, -4, 1))
contrasts(group)<-contrastmatrix
contrasts(group)
summary.lm(aov(y ~ group))

# H0 : mu1+mu2-mu3-mu4=0 VS H1 : Not H0으로 주어진 대비가설에 대해 검정하시오. 다항식 대비 계수 (1, 1, -1, -1, 0)
# 즉 mu1+mu2=mu3+mu4

k<-5
n<-length(y)
m<-tapply(y, group, mean)
ni<-tapply(y, group, length)
c1<-c(1, 1, -1, -1, 0)
sum(c1/ni) ; sum(c1^2/ni)
mse<-1.132 # From anova table
f<-sum(c1*m)^2/(mse*sum(c1^2/ni))
f
1-pf(f, length(group)-1, n-k)
# 주어진 대비가설에 대한 검정통계량은 F=1.731449이고 p-value=0.1423211 > 0.05=alpha이므로 H0를 기각하지 못한다. 그러므로 mu1+mu2=mu3+mu4관계가 있다고 할 수 있다.

###########################
# 예제
# 눈동자 색깔이 갈색, 초록, 파랑인 19명의 사람들을 대상으로 눈동자 깜빡거림 횟수(eye flicker frequency)를 조사하여 데이터를 얻었다.
# 광원(light source)을 감지했을 때 횟수로 측정하는데 실험순서와 눈동자 색깔과는 랜덤하게 배치되었다.

data<-read.csv("eyecolor.csv", header=T)
attach(data)
plot(as.numeric(color), flicker)
plot(as.factor(color), flicker)
tapply(flicker, color, length)
aov1<-aov(flicker ~ color)
model.tables(aov1) # 각 색깔별 수준효과를 보여준다.
model.tables(aov1, type="mean")

display<-as.factor(color)
aov1<-aov(flicker ~ color)
summary(aov1) # 분석결과 색깔(처리) 효과에 대한 검정통계량은 F=4.583, p-value=0.028 < 0.05=alpha이므로 귀무가설을 기각한다. 그러므로 유의수준 alpha=0.05에서 색깔(처리)에 따른 효과가 유의하다. 즉 색깔에 따라 눈동자 깜빡거림 횟수 평균이 같다고 할 수 없다.
summary.lm(aov1) # groupwise contribution head명령어를 통해서 다양함 object명을 찾을 수 있음

par(mfrow=c(2,2))
plot(aov1)

# 사후검정을 통해 어떻게 그룹지어지는지 확인
library(agricolae)
LSD.test(aov1, "color", p.adj="none", main="Y of different groups", console=T)
LSD.test(aov1, "color", p.adj="bonferroni", main="Y of different groups", group=F, console=T)
HSD.test(aov1, "color", group=T, console=T)
scheffe.test(aov1, "color", group=T, main="Y of different groups", console=T)
SNK.test(aov1, "color", main="Y of different groups", console=T)
detach(data)

###########################
# 예) A 음료수 회사 정답 코드
y<-c(5.43, 5.71, 6.22, 6.01, 5.29,
     6.24, 6.24, 5.98, 5.66, 6.60,
     8.79, 9.20, 7.90, 8.15, 7.55)
display<-c(rep("text",5), rep("color",5), rep("image",5))
sol<-cbind(display, y)
sol2<-data.frame(sol)

boxplot(y ~ display)

tapply(y, display, mean)
tapply(y, display, var)
tapply(y, display, sd)

display<-as.factor(display)
aov1<-aov(y ~ display)
summary(aov1)

summary.lm(aov1)

par(mfrow=c(2,2))
plot(aov1)

library(agricolae)
LSD.test(aov1, "display", p.adj="none", main="Y of different groups", console=T)
HSD.test(aov1, "display", group=T, console=T)
scheffe.test(aov1, "display", group=T, main="Y of different groups", console=T)
SNK.test(aov1, "display", main="Y of different groups", console=T)
