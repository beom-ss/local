#연습문제 

#(1)
x=c(2,3,5,7,9,10)

#(2)
x2=x^2

#(3)
sum(x2)

#(4)
x-2

#(5)
max(x)
min(x)

#(6)
x_up=x[x>5]

#(7)
length(x)

#(8)
x1=c(3,5,6,2,1,9)
x
x1

test=cbind(x,x1)
dimnames(test)[[1]]=letters[1:6]


apply(test,1,sum)
apply(test,2,sum)

rep(c(1,2,3),each=2)

seq(1,10,by=0.5)
3:7
7:5
rev(3:7)

test[1,2]
