
 
 #-------------------------------------------------------------------------------#
 # REGESSION HOMEWORK ~ 11/17
 #-------------------------------------------------------------------------------#

 #3.3 
 data3.3 <- data.frame(
 F = c(68,75,85,94,86,90,86,68,55,69,91,75,81,91,80,94,94,97,79,84,65,83),
 P1 = c(78,74,82,90,87,90,83,72,68,69,91,79,89,93,87,91,86,91,81,80,70,79),
 P2 = c(73,76,79,96,90,92,95,69,67,70,89,75,84,97,77,96,94,92,82,83,66,81) 
 )

 head(data3.3)

 #(a)
 model1 <- lm(F~P1,data=data3.3)
 model2 <- lm(F~P2,data=data3.3)
 model3 <- lm(F~P1+P2,data=data3.3)
 summary(model1)
 summary(model2)
 summary(model3)

 #(b) 전부 유의하지 않음
 #(c) R2, t-value, p-value 측면에서 모두 P2가 더 좋은 예측변수라 할 수 있다.(개별적으로 사용하였을 시)
 #(d)
 anova(model1,model3)
 anova(model2,model3)
 
 # 둘다 기각하였으므로, model3이 적합함
 predict(model3,new=data.frame(P1=78,P2=85))
 -14.5005 + 0.4883*78 + 0.6720*85
 

 #3.9
 data3.9 <- read.table('supervisor.txt', header=F,
				 col.names=c("y","x1","x2","x3","x4","x5","x6"))
 attach(data3.9)
 
 (a)
 z = y - 0.5*x1 - 0.5*x3
 FM.a <- lm(y~x1+x3)
 RM.a <- lm(z~1) 
 summary(FM.a)
 summary(RM.a)
 anova(RM.a)
 anova(FM.a)

 ((anova(RM.a)$S[1]  - anova(FM.a)$S[3])/2)/(anova(FM.a)$S[3]/27) # F 통계량
  qf(0.95,2,27) # 기각역

 	#H0 기각 못함.b1=b3=0.5라 할만한 충분한 근거가 없다. 

 (b)

 FM.b <- lm(y~x1+x2+x3)
 RM.b <- lm(z~x2)
 summary(FM.b)
 summary(RM.b)
 anova(RM.b)
 anova(FM.b)

 ((anova(RM.b)$S[2]  - anova(FM.b)$S[4])/2)/(anova(FM.b)$S[4]/26) # F 통계량
  qf(0.95,2,26)  # 기각역

	 #H0 기각 못함.b1=b3=0.5라 할만한 충분한 근거가 없다. 

 #3.11
 #3.12
 #(a)
 h0 : b1=b2=b3=b4=0 (모든 설명변수들의 회귀 계수가 0이다.) 
 qf(0.95,1,88) # F통계량이 22.98 이므로 기각

 #(b) 
 표 3.14를 보면 모든 회귀계수들이 유의하다나왔으며,
 성별, 교육수준, 근무기간의 효과를 조정한 뒤
 경력이 한단위(한달) 증가하였을때 급여가 1.2690만큼 증가하므로,
 급여와 경력사이에 양의 선형관계가 있다 할 수 있다.

 #(c)(d)(e)
 coeffi <- as.matrix(c(3526.4,722.5,90.02,1.2690,23.406),ncol=1)
 new1 <- c(1,1,12,10,15)
 new2 <- c(1,0,12,10,15)
 
 pred1 = new1%*%coeffi
 pred2 = new2%*%coeffi
 
 #(c)와 (d)는 같은 결과 ! s.e는 다르지만 예측값과 평균예측값은 같다! 

































 
