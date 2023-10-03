

#-----------그래프 그리기-----------
x=1:10
y=(x-5)^2
plot(x,y,col="red")
plot(y~x)


#-----------그래프 한꺼번에 그리기------ 
par(mfrow=c(2,2))
plot(x,y,type="p")
plot(x,y,type="l")
plot(x,y,type="b")
plot(x,y,type="p",pch=19,col="red")


#------------pdf file로 보내기--------
pdf('rplot.pdf')
plot(x,y,type="p")
plot(x,y,type="l",lty=6)
plot(x,y,type="b")
plot(x,y,type="p",pch="19",col="red")
dev.off()
#jpg->jpeg, png->png

par(mfrow=c(2,2))
plot(x,y,type="o")
plot(x,y,type="h")
plot(x,y,type="s")
plot(x,y,type="n")

#option lty=1~...
#phc=1 or "*" 
#xlab=,ylab=,main,sub,xlim,ylim,axes=F
plot(x,y,axes=F)

#---------그래프에 선 추가하기--------
data(cars)
head(cars)
attach(cars)
detach(cars)


#평균 확인
mean(speed)
mean(dist)

#---------plot----------------
par(mfrow=c(2,2))
plot(speed,dist,pch=1);abline(v=15.4)
plot(speed,dist,pch=2);abline(h=42.98)
plot(speed,dist,pch=3);abline(-17,4)
plot(speed,dist,pch=4)

lines(speed,dist)
abline(v=15.4)
abline(h=42.98)

#Fiji 섬 지진 데이터 
#--------histogram그리기-----------
data(quakes)
head(quakes)
par(mfrow=c(1,2))

hist(quakes$mag)
hist(quakes$mag,probability=T,main="histogram with density line")
lines(density(quakes$mag))


#---------범주형 자료---------------
res=c("y","n","y","y","y","n","n","y","y","y")

#table로 만들기
table(res)

#막대그래프
barplot(table(res),xlab="response",ylab="frequency")
barplot(table(res),xlab="frequency",ylab="response",horiz=T)

#파이그림
pie(table(res),main="response")


#--------수치형 자료----------------
x=c(45,86,34,98,67,78,56,45,85,75,64,75,75,75,58,45,83,74)

#범위별로 정확한 수치가 나오지 않음
stem(x)

#scale 늘리기
stem(x,scale=2)

#상자그림 (boxplot)
par(mfrow=c(1,2))
boxplot(x,main="Box Plot", sub="basketball game scores")
boxplot(x,horizontal=T,main="Box Plot", sub="basketball game scores")


#사분위수와 사분위수 범위 및 기술통계량
quantile(x,0.8)
quantile(x,0.75)-quantile(x,0.25)
IQR(x)

summary(x)

#회귀분석
R=lm(dist~speed)
summary(R)

#-------matrix만들기----------

matrix(c(54,3,7,12),nrow=2) #matrix 함수 이용
rbind(c(54,7),c(3,12)) #rbind 함수 이용
cbind(c(54,3),c(7,12)) #cbind 함수 이용

#각 행렬에 이름 주기 
x=matrix(c(54,3,7,12),nrow=2)
rownames(x)=c("p.buckled","p.unbuckled")
colnames(x)=c("c.buckled","c.unbuckled")

#행과 열의 합 
colSums(x)
rowSums(x)

#행렬에 포함
addmargins(x)

#그래프 그리기
par(mfrow=c(1,2))
barplot(x,main="child seat-belt usage")
barplot(x,main="child seat-belt usage",legend.text=T,beside=TRUE) 
detach(cars)

#---------이원분할표----------
#read.data
nico=read.csv("nico.csv",header=T)
attach(nico)
y=table(nicotin,stopsmoke)
prop.table(y)
detach(nico)

#---------상관계수-----------
blood=read.table("blood.txt",header=T)
attach(blood)
plot(machine,expert)

cor(machine,expert)
cor(trees)
cor(blood)

detach(blood)

x=1:10
y=(x-5)^2
cor(x,y)
plot(x,y)

detach(blood)

