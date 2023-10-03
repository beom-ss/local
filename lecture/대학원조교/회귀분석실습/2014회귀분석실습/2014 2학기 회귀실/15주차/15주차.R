
 # Example 3.3

 example3.3 <- scan("table3-3.txt", list(g=0,w=0,ch=0))
 attach(example3.3)
 
 x1 <- c(rep(1,8), rep(0,18))
 x2 <- c(rep(0,8), rep(1,8), rep(0,10))
 x3 <- c(rep(0,16), rep(1,10))

 x4 <- c(w[1:8], rep(0,18))
 x5 <- c(rep(0,8), w[9:16], rep(0,10))
 x6 <- c(rep(0,16), w[17:26])
 X=cbind(x1,x2,x3,x4,x5,x6)

 m1 <- lm(ch ~ x1+x2+x3+x4+x5+x6-1)       # model without the intercept
 summary(m1)

 # test for same slope

 C=matrix(c(0,0,0,0,0,0,1,1,-1,0,0,-1), nrow=2)      #C matrix  
 d=c(0,0)                                            #d vector 

 b=m1$coefficients
 b

 SSE <- sum(resid(m1)^2)
 SST <- sum(ch^2) - length(ch)*mean(ch)^2
 SSR <- SST - SSE
 s2 <- SSE/df.residual(m1)
 

 solve(t(X)%*%X)                       

 f=t(C%*%b-d)%*%(solve(C%*%solve(t(X)%*%X)%*%t(C)))%*%(C%*%b-d)/(2*s2)                                                                         # F stat on p.107
 f
 qf(0.95,2,20)                                       # Rejection Region

 detach(example3.3)
 # --------------------------------------------------------------------------------------

 data3.9 <- read.table('supervisor.txt', header=F)
 y <- data3.9[,1]
 x1 <- data3.9[,2]
 x2 <- data3.9[,3]
 x3 <- data3.9[,4]
 x4 <- data3.9[,5]
 x5 <- data3.9[,6]
 x6 <- data3.9[,7]
 

 # test for b1=b3=0.5
 
 m3.9a <- lm(y ~ x1 + x3)
 summary(m3.9a)

 C = matrix(c(0,0,1,0,0,1), nrow=2)
 d = c(0.5,0.5)
 b = m3.9a$coeffi
 
 X <- model.matrix(m3.9a)
 s2 <- anova(m3.9a)[2,2]

 f = t(C%*%b-d)%*%(solve(C%*%solve(t(X)%*%X)%*%t(C)))%*%(C%*%b-d)/(2*s2)    
 qf(0.95,2,27)

  # test for b1=b3=0.5
 
 m3.9b <- lm(y ~ x1 + x2 + x3)
 summary(m3.9b)

 C = matrix(c(0,0,1,0,0,0,0,1),nrow=2)
 d = c(0.5,0.5)
 b = m3.9b$coeffi
 
 X <- model.matrix(m3.9b)
 s2 <- anova(m3.9a)[3,2]

  f = t(C%*%b-d)%*%(solve(C%*%solve(t(X)%*%X)%*%t(C)))%*%(C%*%b-d)/(2*s2)    
 qf(0.95,2,26)



 #-------------------------------------------------------------------------------#
 #	variable selection
 #-------------------------------------------------------------------------------#


 # backward

 m1 <- lm(y~x1+x2+x3+x4+x5+x6)
 summary(m1)
 m2 <- lm(y~x1+x2+x3+x4+x6)
 summary(m2)
 m3 <- lm(y~x1+x2+x3+x6)
 summary(m3)
 m4 <- lm(y~x1+x3+x6)
 summary(m4)
 m5 <- lm(y~x1+x3)
 summary(m5)
 m6 <- lm(y~x1)
 summary(m6)


 # forward

 anova(lm(y~1),lm(y~x1))$P
 anova(lm(y~1),lm(y~x2))$P
 anova(lm(y~1),lm(y~x3))$P
 anova(lm(y~1),lm(y~x4))$P
 anova(lm(y~1),lm(y~x5))$P
 anova(lm(y~1),lm(y~x6))$P

	# x1 선택

 anova(lm(y~x1),lm(y~x1+x2))$P
 anova(lm(y~x1),lm(y~x1+x3))$P
 anova(lm(y~x1),lm(y~x1+x4))$P
 anova(lm(y~x1),lm(y~x1+x5))$P
 anova(lm(y~x1),lm(y~x1+x6))$P


 test <-read.table('test4.txt', header=F)
 y <- test[,17]
 x1 <- test[,2]
 x2 <- test[,3]
 x3 <- test[,4]
 x4 <- test[,5]
 x5 <- test[,6]
 x6 <- test[,7]
 x7 <- test[,8]
 x8 <- test[,9]
 x9 <- test[,10]
 x10 <- test[,11]
 x11 <- test[,12]
 x12 <- test[,13]
 x13 <- test[,14]
 x14 <- test[,15]
 x15 <- test[,16]

 #----------------------------------------------------------------------#
 #					backward						#
 #----------------------------------------------------------------------#

 summary(lm(y~x1+x2+x3+x4+x5+x6+x7+x8+x9+x10+x11+x12+x13+x14+x15))
 summary(lm(y~x1+x2+x3+x4+x5+x6+x7+x8+x9+x10+x12+x13+x14+x15))
 summary(lm(y~x1+x2+x3+x4+x5+x6+x7+x8+x9+x10+x12+x13+x15))
 summary(lm(y~x1+x2+x3+x4+x5+x6+x7+x8+x9+x12+x13+x15))
 summary(lm(y~x1+x2+x3+x4+x5+x6+x7+x8+x9+x12+x13))
 summary(lm(y~x1+x2+x3+x4+x5+x6+x8+x9+x12+x13))
 summary(lm(y~x1+x2+x3+x5+x6+x8+x9+x12+x13))
 summary(lm(y~x1+x2+x3+x6+x8+x9+x12+x13))
 summary(lm(y~x1+x2+x6+x8+x9+x12+x13))
 summary(lm(y~x2+x6+x8+x9+x12+x13))			#final

 #----------------------------------------------------------------------#
 #					forward						#
 #----------------------------------------------------------------------#

 anova(lm(y~1),lm(y~x1))$P
 anova(lm(y~1),lm(y~x2))$P
 anova(lm(y~1),lm(y~x3))$P
 anova(lm(y~1),lm(y~x4))$P
 anova(lm(y~1),lm(y~x5))$P
 anova(lm(y~1),lm(y~x6))$P
 anova(lm(y~1),lm(y~x7))$P
 anova(lm(y~1),lm(y~x8))$P
 anova(lm(y~1),lm(y~x9))$P
 anova(lm(y~1),lm(y~x10))$P
 anova(lm(y~1),lm(y~x11))$P
 anova(lm(y~1),lm(y~x12))$P
 anova(lm(y~1),lm(y~x13))$P
 anova(lm(y~1),lm(y~x14))$P
 anova(lm(y~1),lm(y~x15))$P
 ------------------------------------------------------------------------
 anova(lm(y~x9),lm(y~x9+x1))$P
 anova(lm(y~x9),lm(y~x9+x2))$P
 anova(lm(y~x9),lm(y~x9+x3))$P
 anova(lm(y~x9),lm(y~x9+x4))$P
 anova(lm(y~x9),lm(y~x9+x5))$P
 anova(lm(y~x9),lm(y~x9+x6))$P
 anova(lm(y~x9),lm(y~x9+x7))$P
 anova(lm(y~x9),lm(y~x9+x8))$P

 anova(lm(y~x9),lm(y~x9+x10))$P
 anova(lm(y~x9),lm(y~x9+x11))$P
 anova(lm(y~x9),lm(y~x9+x12))$P
 anova(lm(y~x9),lm(y~x9+x13))$P
 anova(lm(y~x9),lm(y~x9+x14))$P
 anova(lm(y~x9),lm(y~x9+x15))$P
------------------------------------------------------------------------
 anova(lm(y~x9+x6),lm(y~x9+x6+x1))$P
 anova(lm(y~x9+x6),lm(y~x9+x6+x2))$P
 anova(lm(y~x9+x6),lm(y~x9+x6+x3))$P
 anova(lm(y~x9+x6),lm(y~x9+x6+x4))$P
 anova(lm(y~x9+x6),lm(y~x9+x6+x5))$P
 
 anova(lm(y~x9+x6),lm(y~x9+x6+x7))$P
 anova(lm(y~x9+x6),lm(y~x9+x6+x8))$P

 anova(lm(y~x9+x6),lm(y~x9+x6+x10))$P
 anova(lm(y~x9+x6),lm(y~x9+x6+x11))$P
 anova(lm(y~x9+x6),lm(y~x9+x6+x12))$P
 anova(lm(y~x9+x6),lm(y~x9+x6+x13))$P
 anova(lm(y~x9+x6),lm(y~x9+x6+x14))$P
 anova(lm(y~x9+x6),lm(y~x9+x6+x15))$P

------------------------------------------------------------------------

 anova(lm(y~x9+x6+x2),lm(y~x9+x6+x2+x1))$P

 anova(lm(y~x9+x6+x2),lm(y~x9+x6+x2+x3))$P
 anova(lm(y~x9+x6+x2),lm(y~x9+x6+x2+x4))$P
 anova(lm(y~x9+x6+x2),lm(y~x9+x6+x2+x5))$P
 
 anova(lm(y~x9+x6+x2),lm(y~x9+x6+x2+x7))$P
 anova(lm(y~x9+x6+x2),lm(y~x9+x6+x2+x8))$P

 anova(lm(y~x9+x6+x2),lm(y~x9+x6+x2+x10))$P
 anova(lm(y~x9+x6+x2),lm(y~x9+x6+x2+x11))$P
 anova(lm(y~x9+x6+x2),lm(y~x9+x6+x2+x12))$P
 anova(lm(y~x9+x6+x2),lm(y~x9+x6+x2+x13))$P
 anova(lm(y~x9+x6+x2),lm(y~x9+x6+x2+x14))$P
 anova(lm(y~x9+x6+x2),lm(y~x9+x6+x2+x15))$P

------------------------------------------------------------------------
 # 추가할 것이 없음 

 anova(lm(y~x9+x6+x2+x8),lm(y~x9+x6+x2+x8+x1))$P

 anova(lm(y~x9+x6+x2+x8),lm(y~x9+x6+x2+x8+x3))$P
 anova(lm(y~x9+x6+x2+x8),lm(y~x9+x6+x2+x8+x4))$P
 anova(lm(y~x9+x6+x2+x8),lm(y~x9+x6+x2+x8+x5))$P
 
 anova(lm(y~x9+x6+x2+x8),lm(y~x9+x6+x2+x8+x7))$P

 anova(lm(y~x9+x6+x2+x8),lm(y~x9+x6+x2+x8+x10))$P
 anova(lm(y~x9+x6+x2+x8),lm(y~x9+x6+x2+x8+x11))$P
 anova(lm(y~x9+x6+x2+x8),lm(y~x9+x6+x2+x8+x12))$P
 anova(lm(y~x9+x6+x2+x8),lm(y~x9+x6+x2+x8+x13))$P
 anova(lm(y~x9+x6+x2+x8),lm(y~x9+x6+x2+x8+x14))$P
 anova(lm(y~x9+x6+x2+x8),lm(y~x9+x6+x2+x8+x15))$P

 summary(lm(y~x9+x6+x2+x8)) 			#final



 #----------------------------------------------------------------------#
 #					stepwise						#
 #----------------------------------------------------------------------#

 anova(lm(y~1),lm(y~x1))$P
 anova(lm(y~1),lm(y~x2))$P
 anova(lm(y~1),lm(y~x3))$P
 anova(lm(y~1),lm(y~x4))$P
 anova(lm(y~1),lm(y~x5))$P
 anova(lm(y~1),lm(y~x6))$P
 anova(lm(y~1),lm(y~x7))$P
 anova(lm(y~1),lm(y~x8))$P
 anova(lm(y~1),lm(y~x9))$P
 anova(lm(y~1),lm(y~x10))$P
 anova(lm(y~1),lm(y~x11))$P
 anova(lm(y~1),lm(y~x12))$P
 anova(lm(y~1),lm(y~x13))$P
 anova(lm(y~1),lm(y~x14))$P
 anova(lm(y~1),lm(y~x15))$P
 ------------------------------------------------------------------------
 anova(lm(y~x9),lm(y~x9+x1))$P
 anova(lm(y~x9),lm(y~x9+x2))$P
 anova(lm(y~x9),lm(y~x9+x3))$P
 anova(lm(y~x9),lm(y~x9+x4))$P
 anova(lm(y~x9),lm(y~x9+x5))$P
 anova(lm(y~x9),lm(y~x9+x6))$P
 anova(lm(y~x9),lm(y~x9+x7))$P
 anova(lm(y~x9),lm(y~x9+x8))$P

 anova(lm(y~x9),lm(y~x9+x10))$P
 anova(lm(y~x9),lm(y~x9+x11))$P
 anova(lm(y~x9),lm(y~x9+x12))$P
 anova(lm(y~x9),lm(y~x9+x13))$P
 anova(lm(y~x9),lm(y~x9+x14))$P
 anova(lm(y~x9),lm(y~x9+x15))$P

 summary(lm(y~x9+x1))
 summary(lm(y~x9+x2))
 summary(lm(y~x9+x3))
 summary(lm(y~x9+x4))
 summary(lm(y~x9+x5))
 summary(lm(y~x9+x6))
 summary(lm(y~x9+x7))
 summary(lm(y~x9+x8))
 summary(lm(y~x9+x9))
 summary(lm(y~x9+x10))
 summary(lm(y~x9+x11)) 
 summary(lm(y~x9+x12))
 summary(lm(y~x9+x13))
 summary(lm(y~x9+x14))
 summary(lm(y~x9+x15))
 ------------------------------------------------------------------------
 anova(lm(y~x9+x6),lm(y~x9+x6+x1))$P
 anova(lm(y~x9+x6),lm(y~x9+x6+x2))$P
 anova(lm(y~x9+x6),lm(y~x9+x6+x3))$P
 anova(lm(y~x9+x6),lm(y~x9+x6+x4))$P
 anova(lm(y~x9+x6),lm(y~x9+x6+x5))$P
 
 anova(lm(y~x9+x6),lm(y~x9+x6+x7))$P
 anova(lm(y~x9+x6),lm(y~x9+x6+x8))$P

 anova(lm(y~x9+x6),lm(y~x9+x6+x10))$P
 anova(lm(y~x9+x6),lm(y~x9+x6+x11))$P
 anova(lm(y~x9+x6),lm(y~x9+x6+x12))$P
 anova(lm(y~x9+x6),lm(y~x9+x6+x13))$P
 anova(lm(y~x9+x6),lm(y~x9+x6+x14))$P
 anova(lm(y~x9+x6),lm(y~x9+x6+x15))$P

------------------------------------------------------------------------

 stpe1 <- step(lm(y~x1+x2+x3+x4+x5+x6+x7+x8+x9+x10+x11+x12+x13+x14+x15),direction="both")
 stpe2 <- step(lm(y~x1+x2+x3+x4+x5+x6+x7+x8+x9+x10+x11+x12+x13+x14+x15),direction="forward")
 stpe3 <- step(lm(y~x1+x2+x3+x4+x5+x6+x7+x8+x9+x10+x11+x12+x13+x14+x15),direction="backward")

 # model selection
 
 mse
 adjR2
 Cp 




























