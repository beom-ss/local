#------------R의 기본연산----------------

#단순계산 
sqrt(4)
abs(-3)
log(10)
log(10,base=10)
factorial(5)

#벡터 만들기 
k_score=c(96,80,76,96,88,75,78,89,92,70)
k_score_2=c(67,83,96,90,85,75,82,89,92,75)
score=c(k_score,k_score_2)

#문자 벡터
family=c("kim","lee","chulsu","suhee")

#문자 벡터에 이름설정
names(family)=c("father","mother","son","daughter")

#논리형 데이터
c(T,F,F,F,T,T,F)
x=-3:3
w=x<2

#논리형 데이터는 T=1, F=0으로 받음 아래 확인
sum(w)


#----------------데이터 형태 변환-------------------
x=c("1","2","3","4","5")
x
num=as.numeric(x)
char=as.character(num)
fac=as.factor(x)

#벡터에 함수 적용하기 

sum(k_score)
mean(k_score)
max(k_score)
min(k_score)
range(k_score)
var(k_score)
sd(k_score)
median(k_score)
length(k_socre)

#mode는 R에서 최빈값으로 적용이 안되서 직접 코드를 만들어야함
mode_test=c(1,2,3,4,5,2,2,2,2,2)
as.numeric(names(table(mode_test))[which.max(table(mode_test))])

#---------------벡터의 함수 적용--------------------

x=cbind(x1=3,x2=c(4:1,2:8))
dimnames(x)[[1]]=letters[1:11]

#행별 합
apply(x,1,sum)

#열별 합
apply(x,2,sum)

#패키지 설치 
install.packages("MASS")
install.packages("tree")
library(MASS)

head(cabbages)
tail(cabbages)
names(cabbages)

cabbages[,2]
cabbages$Cult

cabbages1=cabbages[(cabbages$Date=="d16"),]
cabbages2=cabbages[(cabbages$VitC>=50),]
cabbages3=cabbages[(cabbages$Date=="d16")&(cabbages$VitC>=60),]



#순서함수
id=c(1,2,3,4,5)
a=c(4,9,7,2,8)
da=cbind(id,a)

#sorting or order
a_s=sort(a)
da_s=da[order(a,decreasing=T),]

#rank
x=c(11,24,24,30,30,30)
rank(x) #0.5씩 더해져서 순위값을 준다.
rank(x,ties.method="first")
rank(x,ties.method="max")
rank(x,ties.method="min")

?rank
help(rank)

order(x,decreasing=F)
order(x,decreasing=T)


#-----------------구조적인 데이터 만들기---------------
1:10
seq(1,10)

rev(1:10)
10:1

seq(1,10,by=2)
seq(from=1,to=10,by=2)

# 1부터 3까지 3번 반복해서 생성할 경우
rep(1:3,time=3)
rep(1:3,3)

#1부터 3까지 각각 3번씩 반복해서 생성할 경우
rep(1:3,each=3)

#벡터나 행렬값의 초기화
a=rep(0,12)

#A 회사의 2007년 월별매출액이 다음과 같다.
# 100, 120, 130, 124, 150, 167, 170, 163, 160, 155, 145, 157
x=c(100, 120, 130, 124, 150, 167, 170, 163, 160, 155, 145, 157)

#원하는 위치의 벡터의 값 선택하기
x[1]
x[1:3]
x[c(6,10)]
xm1=x[-1]
xm2=x[-c(1,12)]
xx=x[x!=150]

#각 벡터에 일련번호를 준다.
names(x)=seq(1,12)





