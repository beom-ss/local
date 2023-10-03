# Sequential variable selection

# Example 4.3 
 
 example4.3 <- scan("table3-8.txt", list(x1=0,x2=0,x3=0,x4=0,x5=0,y=0))
 
 attach(example4.3)

 # Backward elimination

 
 summary(lm(y ~ x1+x2+x3+x4+x5)) # delete x1

 summary(lm(y ~ x2+x3+x4+x5))    # delete x4

 summary(lm(y ~ x2+x3+x5))       # all the remaining variables are significant at level 0.10


 # Stepwise(Backward elimination) model selection using AIC (Akaike Information Criterion)

 m <- lm(y ~ x1+x2+x3+x4+x5)
 m1 <- step(m)
 summary(m1)
 anova(m1)