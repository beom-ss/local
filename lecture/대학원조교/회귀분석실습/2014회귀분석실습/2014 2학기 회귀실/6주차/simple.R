
#------------------------------------------------------------------------------#
# ancombe's quartet 
#------------------------------------------------------------------------------#

  #data import

  quartet <- read.table('quartet.txt',header=F,col.names=c("y1","x1","y2","x2","y3","x3","y4","x4"))
  head(quartet)
  summary(quartet)
  dim(quartet)
  attach(quartet)

  #explore - scatter plot,correlation - figure2.3
  
  #corr
  cor(x1,y1)
  cor(x2,y2)
  cor(x3,y3)
  cor(x4,y4)
  
  #scatter plot
  par(mfrow=c(2,2))
  plot(x1, y1, pch=19);abline(lm(y1~x1))
  plot(x2, y2, pch=19);abline(lm(y2~x2))
  plot(x3, y3, pch=19);abline(lm(y2~x3))
  plot(x4, y4, pch=19);abline(lm(y2~x4))

  detach(quartet)

#------------------------------------------------------------------------------#
# computer repair
#------------------------------------------------------------------------------#

  # data import
  repair <- read.table('repair.txt', header=F, col.names=c("minute","units"))  
  head(repair)
  dim(repair)
  summary(repair)
  attach(repair)

  # plot 
  plot(units,minute,pch=19,main="repair data")

  # corr
  cor(minute,units)

  # esimate using lm function
  model1 <- lm(minute~units)
  summary(model1)
  anova(model1)

  # estimate calculated
  y = minute
  x = units 
  n = length(y)

  ybar = mean(y)
  xbar = mean(x)

  sxx = sum(x^2) - n*xbar^2
  syy = sum(y^2) - n*ybar^2
  sxy = sum(x*y) - n*xbar*ybar

  b1 = sxy/sxx
  b0 = ybar - b1*xbar

  yhat  = b0 + b1*x

 
  # distribution of parameters & test
  
  # BEATA1

						
  SSE = sum((y-yhat)^2)
  MSE = SSE/(n-2)
  s.e_b1 = sqrt(MSE/sxx)   	# calculated

  						
  names(summary(model1))
  names(model1)
  names(anova(model1))
  out <- summary(model1)
  anova <- anova(model1)
  out$coeffi[2,2]  		# using output

  anova$M
  anova$S
  anova$D
  anova$F
  anova$P

  # TEST / H0 : b1 = 12
  
  t = (b1 - 12)/s.e_b1
  t0 = qt(1-0.05/2,n-2)			#|t| > t0 -> rejected H0


  # BETA0
						
  s.e_b0 = sqrt(MSE*(1/n+xbar^2/sxx))  # calculated
  out$coeffi[1,2]		  		# using output


  # TEST / H0 : b0 = 0
  
  t = b0 /s.e_b0
  t0 = qt(1-0.05/2,n-2)			#|t| > t0 -> rejected H0



  # confidence Interval
  # 95% C.I OF MEAN RESPONSE

  x0 = 4
  m0 = b0 + b1*x0
  s.e_m0 = sqrt(MSE*(1/n + (x0-xbar)^2/sxx))

  lower1 <- m0 - t0*s.e_m0
  upper1 <- m0 + t0*s.e_m0		#calculated

  # 95% C.I OF PREDICTED VALUE
  
  
  s.e_y4 = sqrt(MSE*(1 + 1/n + (x0-xbar)^2/sxx))
 
  lower2 <- m0 - t0*s.e_y4
  upper2 <- m0 + t0*s.e_y4		#calculated

  matrix(c(lower1,upper1,lower2,upper2),nrow=2)
  
  #R squre

  R_squre <- anova$S[1]/(anova$S[1] +anova$S[2])  
  


  # Regression line through the origin
  model2 <- lm(y~x-1)
  summary(model2)
  a = anova(model2)
  test = a$S[1]/(a$S[1]+a$S[2])   
  






















