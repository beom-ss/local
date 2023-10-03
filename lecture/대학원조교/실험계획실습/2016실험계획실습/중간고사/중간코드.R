#install.packages("agricolae")
library("agricolae")


##1
achieve<- cbind(student=c(1:10),
		before=c(14,12,20,8,11,15,17,18,9,7),
		after=c(17,16,21,10,10,14,20,22,14,12))

##1-1
t.test(achieve[,2], achieve[,3], alternative="less", paired=T)

#H0:before-after=0 vs H1:before-after<0
#H0 기각. 강의를 들은 후 성취도 점수가 더 좋아졌다고 할 수 있다.

##1-2
t.test(achieve[,2], achieve[,3], alternative="less")
t.test(achieve[,2], achieve[,3], alternative="less", paired=T)

#independent two sample t-test
#95 percent confidence interval:
# -Inf 0.9162289

#paired t-test
#95 percent confidence interval:
# -Inf -1.211015


t.test(achieve[,2], achieve[,3])
t.test(achieve[,2], achieve[,3], paired=T)

#independent two sample t-test
#95 percent confidence interval:
# -6.638978  1.638978

#paired t-test
#95 percent confidence interval:
# -4.0906753 -0.9093247


#independent t-test보다 pair t-test일 때 신뢰구간이 더 좁다.




##2
coa<-factor(c('A','B','C','D'))
o_2<-factor(c(1,2,3,4,5))
dat2<-expand.grid(coa=coa,obs=o_2)
c_2<-c(56,64,45,42,55,61,46,39,62,50,45,45,59,55,39,43,60,56,43,41)
dat2<-cbind(dat2,c_2)

#a)
fit2<-aov(c_2~coa,data=dat2)
summary(fit2)
plot(fit2)
# H0 기각 코팅방법에 따라 열전도율 차이가 있다고 할 수 있다. 

#b)
contrasmatrix<-cbind(c(1,-1,0,0),c(1,1,-1,-1),c(0,0,1,-1))
contrasmatrix
contrasts(dat2$coa)<-contrasmatrix
# result for t-value anova
summary.lm(aov(c_2~coa,data=dat2))

# 2번째 직교대비만 유의한 결과가 나온다. 


#c)
# using TukeyHSD
fit_tuk <- TukeyHSD(x=fit2, "coa", conf.level=0.95)
# using TukeyHSD another function in agricolae
fit_tuk2<-HSD.test(fit2,"coa",group = F)

# A와B C와D 사이에는 코팅방법의 평균의 차이가 없다고 할 수 있고 나머지 사이에는 유의한 결과를 볼 수 있다.



##3
cap<-factor(c('A','B','C'))
o_3<-factor(c(1,2,3,4,5,6))
dat3<-expand.grid(cap=cap,obs=o_3)
c_3<-c(7.3,10.7,10.5,8.0,10.2,10.1,8.1,10.2,10.8,8.5,10.7,11.6,8.4,9.9,11.4,7.5,11.0,10.8)
dat3<-cbind(dat3,c_3)

#fittting
reg3<-lm(c_3~cap,data=dat3)
fit3<-anova(reg3)
fit3_1<-aov(c_3~cap,data=dat3)


#(a)
fit3
plot(fit3_1)
# 전기누수량이 축전지에따라 변동의 차이가 있다고 할 수 있다 .


#(b)
MStreat<-fit3$"Mean Sq"[1]
MSerror<-fit3$"Mean Sq"[2]
n<-length(o_3)
sigma.tau<-(MStreat-MSerror)/n
# 
# > MStreat
# [1] 14.75056
# > MSerror
# [1] 0.2374444
# > sigma.tau
# [1] 2.418852



#(c)
Lower<-((MStreat/MSerror/qf(1-0.05/2,fit3$Df[1],fit3$Df[2]))-1)/n
Upper<-((MStreat/MSerror/qf(0.05/2,fit3$Df[1],fit3$Df[2]))-1)/n

CI<-c(Lower/(1+Lower),Upper/(1+Upper))


# > CI
# [1] 0.6673512 0.9975556







##4
Metal<-factor(c("Nickel","Iron","Copper"))
Ingot<-factor(1:7)
dat4<-expand.grid(block=Ingot,treat=Metal)
BA<-c(67.0,67.5,76.0,72.7,73.1,65.8,75.6,
	71.9,68.8,82.6,78.1,74.2,70.8,84.9,
	72.2,66.4,74.5,67.3,73.2,68.7,69.0)
dat4<-cbind(dat2,BA)


##4-1
fit.dat4<-anova(lm(BA~treat+block,data=dat2))

#H0:mu1=mu2=mu3 vs H1:not H0
#H0 기각. 합금물질 사이에 결합력 차이가 하나라도 존재한다.

##4-2
MSblock<-fit.dat4$"Mean Sq"[2]
MSerror<-fit.dat4$"Mean Sq"[3]
a<-length(Metal)
sigma.beta<-(MSblock-MSerror)/a


##4-3
fit2.dat4<-aov(BA~treat+block,data=dat2)
lsd.dat4<-LSD.test(fit2.dat4,"treat",group=F)

#Copper와 Nickel은 차이 없음. Iron만 차이 있음



##5
posit<-factor(1:5)
strip<-factor(1:5)
dat5<-expand.grid(col=posit,row=strip)
latin<-factor(c("A","B","C","D","E",
	"E","A","B","C","D",
	"D","E","A","B","C",
	"C","D","E","A","B",
	"B","C","D","E","A"))
removal<-c(64,61,62,62,62,
	62,62,63,62,63,
	61,62,63,63,63,
	63,64,63,63,63,
	62,61,63,63,62)
dat5<-cbind(dat5,latin,removal)

##5-1
fit.dat5<-aov(removal~row+col+latin, data=dat5)
summary(fit.dat5)

#H0:A=B=C=D=E vs H1:not H0
#H0 기각하지 못함. 즉, 전극형상별로 차이가 없다.

##5-2
lsd.dat5<-LSD.test(fit.dat5,"latin",group=F)

#5개의 전극형상에 차이가 없다.
