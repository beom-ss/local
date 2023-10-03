# 7.1 
A<-factor(c(-1,1))
B<-factor(c(-1,1))
rep<-factor(c(1,2,3))

dat_7.1<-expand.grid(A=A,B=B,rep=rep)
c_7.1<-c(28,36,18,31,25,32,19,30,27,32,23,29)
dat_7.1<-cbind(dat_7.1,c_7.1)
fit_7.1<-aov(c_7.1~A*B+rep,data=dat_7.1)
summary(fit_7.1)


# 7.2
A<-factor(c(-1,1))
B<-factor(c(-1,1))
C<-factor(c(-1,1))
D<-factor(c(-1,1))

dat_7.2<-expand.grid(A=A,B=B,C=C,D=D)
count<-c(25,71,48,45,68,40,60,65,43,80,25,104,55,86,70,76)
dat_7.2<-cbind(dat_7.2,count)
fit<-aov(count~A*B*C*D,data=dat_7.2)
summary(fit)

x <- expand.grid(c(-1,1), c(-1,1), c(-1,1), c(-1,1))
A <- x[,1]
B <- x[,2]
C <- x[,3]
D <- x[,4]


fa <- expand.grid(c("A", ""), c("B", ""), c("C", ""), c("D", ""))
eff <- numeric(nrow(fa))
names(eff) <- apply(fa, 1, paste, collapse="")

effect <- function (x) {
  
  txt <- names(x)
  ntxt <- length(txt)
  ans <- numeric(ntxt)
  for (i in 1:ntxt) {
    y <- paste(strsplit(txt[i], "")[[1]], collapse="*")
    z <- eval(parse(text = y))
    ans[i] <- sum(z*count)/8
  }
  names(ans) <- txt
  ans
  
}

y <- effect(eff)


tmp <- qqnorm(y)
qqline(y)
text(tmp$x, tmp$y, names(y), pos=3)


#7.3  

count<-c(25,71,28,45,68,60,60,65,23,80,45,84,75,86,70,76)
dat_7.3<-data.frame(cbind(A=A,B=B,C=C,D=D,count))
fit<-aov(count~A*B*C*D,data=dat_7.3)


y <- effect(eff)


tmp <- qqnorm(y)
qqline(y)
text(tmp$x, tmp$y, names(y), pos=3)
