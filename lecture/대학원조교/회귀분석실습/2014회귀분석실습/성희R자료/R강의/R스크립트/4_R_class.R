#-----------일집단 t-test-------------#
x=c(8.30, 9.50, 9.60, 8.75, 8.40, 9.10, 8.15, 8.80)
t.test(x,mu=8.5)

#어느 도시의 보건복지과에서는 그 도시의 상수원인 어느 호수의 수질에 관심이 있다.
#수질을 나타내는 하나의 수치로 단위부피당 평균 세균수가 있는데, 그 수가 200이상이면
#상수원으로 적합하지 않다고 한다.
#평균 세균수가 200보다 적다고 주장할 수 있는가 

test1=c(175,190,215,198,184,207,210,193,196,180)

t.test(test1,mu=200,alternative="greater")
t.test(test1,mu=200,alternative="less")



#-----------이집단 t-test--------------#
x1=c(1.1,2.3,4.3,2.2,5.3)
x2=c(2.3,4.3,3.5)





#분산이 같다는 가정/양측검정
t.test(x1,x2,var.equal=TRUE, alternative="two.sided")


#분산이 같다는 가정/단측검정1
t.test(x1,x2,var.equal=TRUE, alternative="greater")
#분산이 같다는 가정/단측검정2
t.test(x1,x2,var.equal=TRUE, alternative="less")

#분산이 다르다는 가정/양측검정
t.test(x1,x2,var.equal=F, alternative="two.sided")
#분산이 다르다는 가정/단측검정
t.test(x1,x2,var.equal=F, alternative="greater")
#분산이 다르다는 가정/단측검정
t.test(x1,x2,var.equal=F, alternative="less")


#신뢰구간 정하기
t.test(x1,x2,var.equal=T,conf.level=0.95)
t.test(x1,x2,var.equal=T,conf.level=0.90)
t.test(x1,x2,var.equal=T,conf.level=0.99)

#목초의 종류에 따른 우유생산량의 차이를 알아보기 위해 25마리의 젖소를 대상으로 3주 동안
#임의로 추출된 12마리의 젖소에게는 인공적으로 건조시킨 목초를 주고,13마리의 젖소에게는
#들판에서 말린 목초를 주었다. 
#들판에서 자연적으로 말린 목초로 사육하는 젖소가 인공적으로 말린 목초로 사육하는 젖소보다
#우유생산량이 많다고 할 수 있겠는가?

test2_x1=c(44,44,56,46,47,38,58,53,49,35,46,30,41)
test2_x2=c(35,47,55,29,40,39,32,41,42,57,51,39)

t.test(test2_x2,test2_x1,var.equal=T, alternative="greater")
t.test(test2_x2,test2_x1,var.equal=F, alternative="greater")


#호박잎의 질소성분
met=read.table("method.txt",header=T)

#분산이 같다는 가정
t.test(x~method,var.equal=T,data=met)

#분산이 다르다는 가정
t.test(x~method,var.equal=F, data=met)




#-------------이집단 분산비 F-검정----------------

var.test(x1,x2)
t.test(x1,x2,var.equal=T, alternative="two.sided")


#--------------짝비교-----------------
pre=c(77, 56, 64, 60, 58, 72, 67, 78, 67, 79)
post=c(99, 80, 78, 65, 59, 67, 65, 85, 74, 80)
t.test(post,pre,paired=T)  

#혈압강하의 효과가 있는지 알아보기 위해 15명의 환자를 대상으로 약의 복용전후의 이완기 혈압을 측정
p=c(70,80,72,76,76,76,72,78,82,64,74,92,74,68,84)
a=c(68,72,62,70,58,66,68,52,64,72,74,60,74,72,74)
t.test(p,a,paired=T)


#어떤 사업안전 프로그램이 공장에서 일어나는 사건으로 인한 작업시간의 손실을 줄이는데 효과적이라고
#주장하고 있다. 다음의 자료는 6곳의 공장에서 산업 안전 프로그램 실시 전과 후의 사고로 인한 주당
#작업시간의 손실을 기록한 것이다. 

p2=c(12,29,16,37,28,15)
a2=c(10,28,17,35,25,16)
t.test(p2,a2,paired=T)


#--------------독립성검정-----------------
#H0=독립이다.

x=matrix(c(54,63,45,65),nrow=2)
chi=chisq.test(x)

#기대도수와 잔차
chi$expected
chi$resi
names(chi)



#개체에 대한 정보로 주어진 경우
x=seq(1,12)
gender=c("M","M","M","M","M","M","F","F","F","F","F","M")
admit=c("Y","Y","Y","N","N","Y","Y","Y","N","N","Y","Y")
y=cbind(x,gender,admit)
y=data.frame(y)

table(gender,admit)
chisq.test(gender,admit)
chisq.test(table(gender,admit))
fisher.test(gender,admit)

#스트레스를 받는 직종에 근무하는 185명에 대한 조사를 통하여 다음과 같은 표를 얻었다.
#우울증의 유무와 알콜 중독과 관계가 있는가? 
data=matrix(c(54,22,27,82),nrow=2)
res=chisq.test(data)


#--------------적합성검정-----------------
#H0=비율이 같다
y=c(30,20,27,23)
p=c(0.25,0.25,0.25,0.25)
chisq.test(y,p=p)


#다음의 표는 헌혈한 96명의 사람들의 혈액형을 정리한 것이다. 유의수준 0.05로 "헌혈한 사람의
#혈액형은 같은 비율이다"라는 가설을 검정하여라.

y=c(38,43,10,5)
p=c(0.25,0.25,0.25,0.25)
chisq.test(y,p=p)
