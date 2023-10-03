# 6.1
A<-factor(c(0,1))
B<-factor(c(0,1))
C<-factor(c(0,1))
rep<-factor(c(0,1))
dat_6.1<-expand.grid(A=A,B=B,C=C,rep=rep)
count<-c(550,669,633,642,1037,749,1075,729,604,650,601,635,1052,868,1063,860)
dat_6.1<-cbind(dat_6.1,count)

fit<-aov(count~A*B*C,data=dat_6.1)
summary(fit)
model.tables(fit)
#qqplot
qqnorm(fit$residuals)
qqline(fit$residuals)




# example 6.2

A<-factor(c(-1,1))
B<-factor(c(-1,1))
C<-factor(c(-1,1))
D<-factor(c(-1,1))

dat_6.2<-expand.grid(A=A,B=B,C=C,D=D)
count<-c(45,71,48,65,68,60,80,65,43,100,45,104,75,86,70,96)
dat_6.2<-cbind(dat_6.2,count)
fit<-aov(count~A*B*C*D,data=dat_6.2)
effect<-fit$effects[-1]/2
model.tables(fit)


## From "stats.stackexchange.com"

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
    ans[i] <- sum(z*R)/8
  }
  names(ans) <- txt
  ans
  
}

y <- effect(eff)

pdf("qqplot-effect.pdf")
tmp <- qqnorm(y)
qqline(y)
text(tmp$x, tmp$y, names(y), pos=3)
dev.off()

fit.fm <- fit
fit.rm <- aov(R ~ A*C*D, rate)






#example 6.3
logc<-log(dat_6.2$count)
dat_6.3<-cbind(dat_6.2,logc)
fit<-aov(logc~A*B*C*D,data=dat_6.2)
summary(fit)
fit$effects
