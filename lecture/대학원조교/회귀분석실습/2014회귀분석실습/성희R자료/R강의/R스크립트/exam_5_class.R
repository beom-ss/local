#-------연습문제(1)----------
ex1=read.table("brother.txt",header=F,col.names=c("older","younger"))

apply(ex1,2,mean)
apply(ex1,2,sd)


#-------연습문제(2)----------
korean=data.frame(name=c("kim","lee","park","oh","yang","min","jung"),
			korean=c(93,76,87,92,98,75,82))
english=data.frame(name=c("kim","lee","park","oh","yang","min","jung","choi"),
			english=c(90,94,88,75,79,87,88,90))

#(a)
all=merge(korean,english,by.x="name",by.y="name", all=T)

#(b)
all=all[order(as.character(all$name)),]


#-------연습문제(3)----------
install.packages("UsingR")
library(UsingR)

hist(primes)





#-------연습문제(4)----------
phone=c(20870, 39400, 65000, 45000, 35890, 29000, 56770,23000, 38550, 59800, 39880, 56780, 35220, 48990)

#(a)
mean(phone)

#(b)
t.test(phone,mu=mean(phone))

#(c)
var(phone)
sd(phone)
range(phone)

#(d)
boxplot(phone)

#(e)
hist(phone,probability =T)
lines(density(phone))


#-------연습문제(5)----------
E=c(90,88,78,65,78,60,89,73)
F=c(80,78,75,69,73,62,79,70)
t.test(E,F,paired=T)


#-------연습문제(6)----------
ex6=matrix(c(24,32,54,20,30,60,50,20,15),nrow=3)
chisq.test(ex6)


#-------연습문제(7)----------
type=c(rep("A",3),rep("B",4),rep("C",3),rep("D",4))
y=c(26,23,27,19,20,20,17,28,28,29,29,29,27,34)

result=aov(y~type)
summary(result)

result.tukey=TukeyHSD(result,"type")
result.LSD=pairwise.t.test(y,type)
plot(result.tukey)


