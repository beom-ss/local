#### 세제 데이터에 대한 확률화완전블록설계 ####

trt<-c(1, 1, 1, 1,
       2, 2, 2, 2,
       3, 3, 3, 3)

block<-c(1, 2, 3, 4,
          1, 2, 3, 4,
          1, 2, 3, 4)

y<-c(20, 22, 18, 25,
     16, 18, 17, 19, 
     30, 34, 29, 27)

trt<-as.factor(trt)
block<-as.factor(block)

mean(y) # overall mean
tapply(y, trt, mean) # trt-wise mean
tapply(y, trt, var) # trt-wise var
tapply(y, block, mean) # block-wise mean
tapply(y, block, var) # block-wise var
tapply(y, trt, mean) - mean(y) # hat tau
tapply(y, block, mean) - mean(y) # hat block

aov.out<-aov(y ~ trt + block)
summary(aov.out)

par(mfrow=c(1,2))
plot(y ~ trt) ; boxplot(y ~ block)

library(agricolae) # trt에 대한 LSD
LSD.test(aov.out, "trt", p.adj="none", main="Y of different groups", console=T)

head(aov.out)
aov.out$fitted
aov.out$residuals

shapiro.test(aov.out$residuals) # H0 : 잔자는 정규분포를 따른다. vs H1 : 잔차는 정규분포를 따르지 않는다.
# 정규성 가설에 대한 검정으로 검정통계량은 W=0.9776 이고 p-값=0.972 > 0.05=alpha이므로 유의수준 5%에서 H0를 기각하지 못한다.
# 그러므로 잔차는 정규분포를 따른다고 할 수 있으므로 모형에 대한 가정을 만족한다.

par(mfrow=c(2,2))
pdf("aov_cleanser.pdf") # pdf로 저장
plot(aov.out)
dev.off()

#### 3가지 첨가제가 자동차 연비 향상에 미치는 영향 ####
b<-read.csv("trt_block_rcbd.csv", header=T)
attach(b) ; b
trt<-as.factor(trt) # tretment
block<-as.factor(block) # block

par(mfrow=c(1,2))
plot(y ~ trt) ; plot(y ~ block)

tapply(y, trt, mean) ; tapply(y, block, mean)
fit<-lm(y ~ trt+block)
anova(fit)

aov.out<-aov(y ~ trt+block)
summary(aov.out)

sort(tapply(y, trt, mean)) # 처리평균별 오름차순
library(agricolae)
LSD.test(aov.out, "trt", p.adj="none", main="Y of different groups", console=T)
# LSD.test(aov.out, "block", p.adj="none", main="Y of different groups", console=T) # 
detach(b)
