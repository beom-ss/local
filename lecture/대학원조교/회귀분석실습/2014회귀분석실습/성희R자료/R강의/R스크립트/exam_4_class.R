#-----------연습문제1------------
#make data
exam1=matrix(c(40,30,35,20,20,30,45,40),ncol=4,byrow=T)
rownames(exam1)=c("presence","absent")
colnames(exam1)=c(1:4)

chisq.test(exam1)


#-----------연습문제2-------------
y=c(53,42,51,45,36,37,65)
p=c(1/7,1/7,1/7,1/7,1/7,1/7,1/7)

chisq.test(y,p=p)


#---------연습문제3---------------

m=c(159, 280, 101, 121, 224, 222, 379, 179, 250, 170)
t.test(m,mu=225,alternative="greater",conf.level=0.98)

#--------연습문제4-----------------
A=c(90,86,72,65,44,52,46,38,43)
B=c(85,87,70,62,44,53,42,35,46)

t.test(A,B,paired=T)




#--------단순 회귀분석-------------
x=c(3,3,4,5,6,6,7,8,8,9)
y=c(9,5,12,9,14,16,22,18,24,22)

plot(x,y)
abline(-1.0709,2.7408)
plot(y~x)
cor(x,y)
result=lm(y~x)
R=summary(result)
names(R)

#y=-1.0709 + 2.7408*X



