# 5.1
temp<-factor(c(15,70,125))
mat<-factor(c(1,2,3))
obs<-factor(c(1,2,3,4))
dat_5.1<-expand.grid(obs=obs,temp=temp,mat=mat)
count_5.1<-c(130,155,74,180,34,40,80,75,20,70,82,58,150,188,159,126,136,122,106,115,25,70,58,45,138,110,168,160,174,120,150,139,96,104,82,60)
dat_5.1<-cbind(dat_5.1,count_5.1)
#fitting anova 1)
fit_5.1<-aov(count_5.1~mat*temp,data=dat_5.1)
#fitting anova 2)
fit_5.1_2<-aov(count_5.1~mat+temp+temp:mat,data=dat_5.1)
summary(fit_5.1)
# Model Adequacy Checking 
par(mfrow=c(2,2))
plot(fit_5.1)

# 모든 요인수준평균
model.tables(fit_5.1,type="means")
# interaction plot
interaction.plot(dat_5.1$temp,dat_5.1$mat,response=dat_5.1$count_5.1)

# 5.3 
pre<-factor(c(25,30))
car<-factor(c(10,12,14))
spe<-factor(c(200,250))
obs<-factor(c(1,2))
dat_5.3<-expand.grid(obs=obs,spe=spe,pre=pre,car=car)
count_5.3<-c(-3,-1,-1,0,-1,0,1,1,0,1,2,1,2,3,6,5,5,4,7,6,7,9,10,11)
dat_5.3<-cbind(dat_5.3,count_5.3)
#fitting anova 1)
fit_5.3<-aov(count_5.3~spe*car*pre,data=dat_5.3)
summary(fit_5.3)

#압력 수준 편차의 평균
tapply(dat_5.3$count_5.3,dat_5.3$pre,mean)
#라인 속도 수준 편차의 평균
tapply(dat_5.3$count_5.3,dat_5.3$spe,mean)
#탄산포화 비율 수준 편차의 평균
tapply(dat_5.3$count_5.3,dat_5.3$car,mean)

par(mfrow=c(1,3))
# interaction plot
interaction.plot(dat_5.3$pre,dat_5.3$car,response=dat_5.3$count_5.3)
interaction.plot(dat_5.3$pre,dat_5.3$spe,response=dat_5.3$count_5.3)
interaction.plot(dat_5.3$car,dat_5.3$spe,response=dat_5.3$count_5.3)
