 
 # data import
 data <- read.csv('q1.csv',header=T)
 head(data)
 attach(data)


#1.
 m0 <- lm(y~1)
 m1 <- lm(y~x1+e1+e2+s)    #mdoel4
 summary(m1)
 anova(m0,m1)Z

#2.
 m2 <- lm(y~x1+s+j)
 out <- summary(m2)
 out$coeffi
 n <- length(y)
 (out$coeffi[2,1]-15)/out$coeffi[2,2]    #t
 qt(0.95,n-4)


#3.
 m3 <- lm(y~e1+e2+s+j)		#model3
 summary(m3)

#4.

 m5 <- lm(y~x1+e1+e2+s+s*e1+s*e2)	#model6
 m1 <- lm(y~x1+e1+e2+s)  		  #mdoel4
 anova(m1,m5)

 #5. test for a1=a2
 
 summary(m1) 

 C = matrix(c(0,0,1.5,-1,0), nrow=1)
 d = c(0)
 b = m1$coeffi
 
 X <- model.matrix(m1)
 s2 <- anova(m1)$M[5]

 t(C%*%b-d)%*%(solve(C%*%solve(t(X)%*%X)%*%t(C)))%*%(C%*%b-d)/(1*s2)    
 qf(0.95,1,n-5)

 #6
 #a.
 m6 <- lm(y~x1+e1+e2+s+s*x1+x1*e2+s*e2) #model7
 new <- data.frame(x1=0,e1=1,e2=0,s=1,j=0)
 pred <- predict(m6,new=new)

 #b.
 new1 <- data.frame(x1=0,e1=0,e2=1,s=0,j=1)
 new2 <- data.frame(x1=1,e1=0,e2=1,s=0,j=1)
 pred1 <- predict(m6,new=new1)
 pred2 <- predict(m6,new=new2)
 pred2-pred1

 #7.
 m7 <- lm(y~x1+e1+e2+s+j)
 plot(fitted(m7),rstudent(m7))
 summary(m7)
 y2 <- log(y)
 m71 <- lm(y2~x1+e1+e2+s+j)
 plot(fitted(m71),rstudent(m71))


 #8.
 #a.

 cbind(
	summary(m1)$adj.r.squared,
	summary(m5)$adj.r.squared,
	summary(m6)$adj.r.squared,
	summary(m7)$adj.r.squared)
	#mse ±âÁØ m7 best

 #b.
 PRESS1 <- sum((resid(m1)/(1-lm.influence(m1)$hat))^2 )
 PRESS5 <- sum((resid(m5)/(1-lm.influence(m5)$hat))^2 )
 PRESS6 <- sum((resid(m6)/(1-lm.influence(m6)$hat))^2 )
 PRESS7 <- sum((resid(m7)/(1-lm.influence(m7)$hat))^2 )
 cbind(PRESS1,PRESS5,PRESS6,PRESS7)

 detach(data)
--------------------------------------------------------------------------

 #2-(1)

  data2 <- read.table("greg12fdata_11.txt", header=T)
  attach(data2)

  m21 <- lm(y ~ x1 + x2 + x3 + x4 + x5 + x6)

  X2<-cbind(x1,x2,x3,x4,x5,x6) 
  VIF <- diag(solve(cor(X2)))
  VIF

 #2-(3)
 step(m21,direction="backward")

 #2-(4)

   fm <- lm(y ~ x1 + x3)
   summary(fm)
  e <- fm$resid
  hii <- lm.influence(fm)$hat
  dffits <- dffits(fm)
  cooks.d <- cooks.distance(fm)
  t <- rstudent(fm)
 
  dig <- data.frame(e,t,hii,dffits,cooks.d)

 #outlier
  dig[abs(t)>2,]
 #hii
 p <- 7
 n <- length(y)
  dig[hii>2*p/n,]
 #dffits
 dig[abs(dffits)>2*sqrt(p/n),]
 #cooks.d
 dig[cooks.d>1,]


