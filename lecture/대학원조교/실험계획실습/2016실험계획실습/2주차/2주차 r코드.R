setwd("D:/실계실/2016/2주차")    #data가 있는 폴더경로

## data 불러오기
dat01<-read.csv("employment.csv",header=T)  
head(dat01)



## Exploring data analysis

str(dat01)

#data유형 바꿔주기
dat01$job<-as.factor(dat01$job)
dat01$racial<-as.factor(dat01$racial)

str(dat01)
summary(dat01)

#scatter plot
plot(salary~career,dat01, xlim=c(0,500), ylim=c(0,140000), xlab="career", ylab="salary", main="career vs salary")  
text(x=dat01$career, y=dat01$salary, cex=0.75)

#histogram
hist(dat01$salary,main="Salary histogram")

#boxplot
par(mfrow=c(1,2))
boxplot(salary ~ sex, data=dat01)
boxplot(salary ~ sex+racial, data=dat01)# 두변수의 상호작용으로 Boxplot그리기 x축의 이름을보면 2개의 변수가 합쳐진것을 알 수 있다.
par(mfrow=c(1,1))


#barplot
islands  #R에 내장되어 있는 data

hist(islands)
barplot(islands,main="Bar plot")



#Hypotheses Testing



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
#C.I
# 예)전선데이터는 정규분포를 따른다고 한다. 평균에 대한 95% 신뢰구간을 구하고자 한다. 
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
# 예)전선에 대한 힘 데이터는 정규분포를 따른다고 할때 다음을 구하시오.
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






