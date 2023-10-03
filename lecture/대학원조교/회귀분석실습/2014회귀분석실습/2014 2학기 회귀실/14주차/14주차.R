

 salary <- read.table('salary_survey.txt',header=T)
 head(salary)
 attach(salary)

 n <- nrow(salary) 
 
 # creating dummy
 
 e1 <- rep(0,n)
 e2 <- rep(0,n)

 for(i in 1:n){
 	if(E[i] == 1)	e1[i] <- 1
	else e1[i] <- 0 
 } 

 for(i in 1:n){
 	if(E[i] == 2)	e2[i] <- 1
	else e2[i] <- 0 
 } 

 # exploring

 plot(S~X)
 boxplot(S~E)
 boxplot(S~M)
 
 # Modeling

 m1 <- lm(S ~ X + e1 + e2 + M)
 summary(m1)

 m2 <- lm(S ~ X + e1 + M)
 summary(m2)

 r <- rstandard(m1)
 plot(X,r)
 plot(E,r)
 plot(M,r)

 #interaction - diffrent slope
 
 boxplot(S~E*M)
 interaction.plot(E,M,S)

 m3 <- lm(S ~ X + e1 + e2 + M + e1*M + e2*M)
 summary(m3)

 r3 <- rstandard(m3)

 plot(X[-33],r3[-33]);text(X,r3,pos=1,cex=0.7)
 plot(E[-33],r3[-33])
 plot(M[-33],r3[-33])

 detach(salary)
 #--------------------------------------------------------------------------------#
 corn <- read.table('corn_yeild.txt',header=T)
 corn
 attach(corn)

 F1 <- as.numeric(Fertilizer==1) 
 F2 <- as.numeric(Fertilizer==2) 
 F3 <- as.numeric(Fertilizer==3) 

 m5.5 <- lm(Yield~F1+F2+F3)
 summary(m5.5)

 #(c)
 rm1 <- lm(Yield~1)
 anova(rm5.5,m5.5)

 #(d)
 new_F <- F1+F2+F3
 rm2 <- lm(Yield~new_F)
 summary(rm2)
 anova(rm2,m5.5)

 #(e)
  boxplot(Yield~Fertilizer)

 detach(corn)
 #--------------------------------------------------------------------------------#

 class <- read.table('class_data.txt',header=T)
 head(class)
 attach(class)

 plot(Height,Weight,col=Sex+9,pch=19)
 plot(Age,Weight,col=Sex+9,pch=19)
 boxplot(Height~Sex)
 
 m5.6 <- lm(Weight ~ Height+Age+Sex)
 summary(m5.6)
 r <- rstandard(m5.6)
 plot(fitted(m5.6),r,col=Sex+9,pch=19)

 m2 <- lm(Weight ~ Height+Age+Sex+Sex*Age)
 r2 <- rstandard(m2)
 summary(m2)
 plot(fitted(m2),r2,col=Sex+9,pch=19)

    # detach
 female <- class[Sex==1,]
 male <- class[Sex==0,]
 f_m <- lm(Weight ~ Height , data=female) 
 m_m <- lm(Weight ~ Height , data=male) 
 summary(f_m)
 summary(m_m)
 interaction.plot(Sex,Age,Weight)

 #----------------------------------------------------------------#
 data1 <- read.table("ex3-11.txt", header=T)
  
  y <- data1[,1]
  lnx1 <- log(data1[,2])
  lnx2 <- log(data1[,3])
  lnx3 <- log(data1[,4])

  #3-11 - (a)
  lm(y ~ lnx1 + lnx2 + lnx3) 
  

  #3-11 - (b)
  X <- cbind(lnx1,lnx2,lnx3)  
  cor(X)

  #3-11 - (c)
  eigen <- eigen(cor(X))

  #3-11 - (d)
  VIF <- diag(solve(cor(X)))




