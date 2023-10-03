#---------연습문제1------------
#read data
exam1=c(25, 16, 44, 62, 36, 58, 38)

#(a)
mean(exam1)

#(b)
var(exam1)

#(c)
sd(exam1)

#(d)
boxplot(exam1)

#(e)
stem(exam1)



#---------연습문제2------------
#read data
exam2=InsectSprays
head(exam2)
attach(exam2)
#(a)
table(spray)

#(b)
mean(count)

#(c)
pie(table(spray),main="Spray")
A=exam2[spray=="A",1]
B=exam2[spray=="B",1]
C=exam2[spray=="C",1]
D=exam2[spray=="D",1]
E=exam2[spray=="E",1]
F=exam2[spray=="F",1]

newdata=c(rep("A",sum(A)),rep("B",sum(B)),rep("C",sum(C)),rep("D",sum(D)),
rep("F",sum(F)))

table(newdata)
pie(table(newdata))


#-----------연습문제3------------
#make data
exam3=matrix(c(40,30,35,20,20,30,45,40),ncol=4,byrow=T)
rownames(exam3)=c("presence","absent")
colnames(exam3)=c(1:4)

#(a)
Exam3=exam3/colSums(exam3)
barplot(Exam3,main="Exam3_A",legend.text=T,beside=TRUE)

#(b)
Exam3b=prop.table(exam3)
all_p=rowSums(Exam3b)
names(all_p)=c("presence","absent")
barplot(all_p,main="Exam3_B",legend.text=T,beside=TRUE)


