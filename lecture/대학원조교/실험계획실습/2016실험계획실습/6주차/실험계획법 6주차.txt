# Ex 4.1
PSI<-factor(c(8500,8700,8900,9100))
block<-factor(c(1,2,3,4,5,6))
dat_4.1<-expand.grid(PSI=PSI,block=block)
c_4.1<-c(90.3,92.5,85.5,82.5,89.2,89.5,90.8,89.5,98.2,90.6,89.6,85.6,93.9,94.7,86.2,87.4,87.4,87.0,88.0,78.9,97.9,95.8,93.4,90.7)
dat_4.1<-cbind(dat_4.1,c_4.1)
# fitting anova
fit_4.1<-aov(c_4.1~PSI+block,data=dat_4.1)
summary(fit_4.1)
lsd_4.1<-LSD.test(fit_4.1,"PSI",group=F)
# Model Adequacy Checking 
par(mfrow=c(2,2))
plot(fit_4.1)


# Ex 4.3
RM<-factor(c(1,2,3,4,5))
OP<-factor(c(1,2,3,4,5))
dat_4.3<-expand.grid(RM=RM,OP=OP)
c_4.3<-c(-1,-8,-7,1,-3,-5,-1,13,6,5,-6,5,1,1,-5,-1,2,2,-2,4,-1,11,-4,-3,6)
LA<-c('A','B','C','D','E','B','C','D','E','A','C','D','E','A','B','D','E','A','B','C','E','A','B','C','D')
dat_4.3<-cbind(dat_4.3,LA,c_4.3)
# fitting anova
fit_4.3<-aov(c_4.3~LA+RM+OP,data=dat_4.3) #treat + row +col
summary(fit_4.3)
lsd_4.3<-LSD.test(fit_4.3,"LA",group=F)
# Model Adequacy Checking 
par(mfrow=c(2,2))
plot(fit_4.3)
