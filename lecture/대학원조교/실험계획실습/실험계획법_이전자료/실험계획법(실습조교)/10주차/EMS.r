

  #-----------------------------------------------------------------------------------------------
  # library install and loading
  # install.packages("lme4")
  # install.packages("nlme")
  library(lme4)
  library(nlme) 

  # Data input
  example <- read.table("EMS_example.txt", header=T)
  #-----------------------------------------------------------------------------------------------


  # Modeling for single factor model
  #-----------------------------------------------------------------------------------------------
  single_fixed <- lm(Y ~ as.factor(E), data=example)
  summary(single_fixed)
  ================================================================================================
  Call:
  lm(formula = Y ~ as.factor(E), data = example)

  Residuals:
      Min      1Q  Median      3Q     Max 
  -11.250  -4.250  -0.875   5.938  11.750 

  Coefficients:
                  Estimate Std. Error t value Pr(>|t|)    
  (Intercept)       55.500      3.795  14.624 1.41e-07 ***
  as.factor(E)90   -34.250      5.367  -6.381 0.000128 ***
  as.factor(E)120  -46.250      5.367  -8.617 1.22e-05 ***
  ---
  Signif. codes:  0 ¡®***¡¯ 0.001 ¡®**¡¯ 0.01 ¡®*¡¯ 0.05 ¡®.¡¯ 0.1 ¡® ¡¯ 1 

  Residual standard error: 7.59 on 9 degrees of freedom
  Multiple R-squared: 0.8989,     Adjusted R-squared: 0.8764 
  F-statistic: 39.99 on 2 and 9 DF,  p-value: 3.327e-05 
  ================================================================================================
  anova(single_fixed)
  ================================================================================================
  Analysis of Variance Table

  Response: Y
               Df Sum Sq Mean Sq F value    Pr(>F)    
  as.factor(E)  2 4608.2 2304.08  39.994 3.327e-05 ***
  Residuals     9  518.5   57.61                      
  ---
  Signif. codes:  0 ¡®***¡¯ 0.001 ¡®**¡¯ 0.01 ¡®*¡¯ 0.05 ¡®.¡¯ 0.1 
  ================================================================================================


  single_random.1 <- lmer(Y ~ (1|E), family=gaussian, data=example) 
  summary(single_random.1)
  ================================================================================================
  Linear mixed model fit by REML 
  Formula: Y ~ (1 | E) 
     Data: example 
     AIC   BIC logLik deviance REMLdev
   91.67 93.12 -42.83    92.72   85.67
  Random effects:
   Groups   Name        Variance Std.Dev.
   E        (Intercept) 561.618  23.6985 
   Residual              57.611   7.5902 
  Number of obs: 12, groups: E, 3

  Fixed effects:
              Estimate Std. Error t value
  (Intercept)    28.67      13.86   2.069
  ================================================================================================
  anova(single_random.1)
  ================================================================================================
  Analysis of Variance Table
       Df Sum Sq Mean Sq F value
  ================================================================================================


  single_random.2 <- lme(Y ~ 1 , random=~1|E, data=example)
  summary(single_random.2)
  ================================================================================================
  Linear mixed-effects model fit by REML
   Data: example 
         AIC      BIC    logLik
    91.66987 92.86356 -42.83493

  Random effects:
   Formula: ~1 | E
          (Intercept) Residual
  StdDev:    23.69848 7.590198

  Fixed effects: Y ~ 1 
                 Value Std.Error DF  t-value p-value
  (Intercept) 28.66667  13.85666  9 2.068801  0.0685

  Standardized Within-Group Residuals:
         Min         Q1        Med         Q3        Max 
  -1.5066070 -0.5940405 -0.1030641  0.7364128  1.5236169 

  Number of Observations: 12
  Number of Groups: 3 
  ================================================================================================
  anova(single_random.2)
  ================================================================================================
              numDF denDF  F-value p-value
  (Intercept)     1     9 4.279938  0.0685
  ================================================================================================

 
  # Modeling for two factors model
  #-----------------------------------------------------------------------------------------------
  two_fixed <- lm(Y ~ as.factor(E)*as.factor(V), data=example)
  summary(two_fixed)
  ================================================================================================
   Call:
  lm(formula = Y ~ as.factor(E) * as.factor(V), data = example)

  Residuals:
     Min     1Q Median     3Q    Max 
  -5.000 -2.875  0.000  2.875  5.000 

  Coefficients:
                                  Estimate Std. Error t value Pr(>|t|)    
  (Intercept)                       53.000      3.403  15.573 4.44e-06 ***
  as.factor(E)90                   -22.500      4.813  -4.675 0.003415 ** 
  as.factor(E)120                  -42.000      4.813  -8.726 0.000125 ***
  as.factor(V)220                    5.000      4.813   1.039 0.338930    
  as.factor(E)90:as.factor(V)220   -23.500      6.807  -3.452 0.013593 *  
  as.factor(E)120:as.factor(V)220   -8.500      6.807  -1.249 0.258273    
  ---
  Signif. codes:  0 ¡®***¡¯ 0.001 ¡®**¡¯ 0.01 ¡®*¡¯ 0.05 ¡®.¡¯ 0.1 ¡® ¡¯ 1 

  Residual standard error: 4.813 on 6 degrees of freedom
  Multiple R-squared: 0.9729,     Adjusted R-squared: 0.9503 
  F-statistic: 43.06 on 5 and 6 DF,  p-value: 0.0001268 
  ================================================================================================
  anova(two_fixed)
  ================================================================================================
  Analysis of Variance Table

  Response: Y
                            Df Sum Sq Mean Sq F value   Pr(>F)    
  as.factor(E)               2 4608.2 2304.08 99.4568 2.51e-05 ***
  as.factor(V)               1   96.3   96.33  4.1583  0.08754 .  
  as.factor(E):as.factor(V)  2  283.2  141.58  6.1115  0.03569 *  
  Residuals                  6  139.0   23.17                     
  ---
  Signif. codes:  0 ¡®***¡¯ 0.001 ¡®**¡¯ 0.01 ¡®*¡¯ 0.05 ¡®.¡¯ 0.1 
  ================================================================================================

  two_random <- lmer(Y ~ (1|E)+(1|V)+(1|E*V) , family=gaussian, data=example)
  summary(two_random)
  ================================================================================================
  Linear mixed model fit by REML 
  Formula: Y ~ (1 | E) + (1 | V) + (1 | E * V) 
     Data: example 
     AIC   BIC logLik deviance REMLdev
   92.56 94.99 -41.28    89.61   82.56
  Random effects:
   Groups   Name        Variance Std.Dev.
   E * V    (Intercept)  51.667   7.1880 
   E        (Intercept) 544.396  23.3323 
   V        (Intercept)   0.000   0.0000 
   Residual              23.167   4.8132 
  Number of obs: 12, groups: E * V, 6; E, 3; V, 2

  Fixed effects:
              Estimate Std. Error t value
  (Intercept)    28.67      13.86   2.069
  ================================================================================================
  anova(two_random)
  ================================================================================================
  Analysis of Variance Table
       Df Sum Sq Mean Sq F value
  ================================================================================================

  two_mixed <- lmer(Y ~ as.factor(E)+(1|V)+(1|E*V), family=gaussian, data=example)
  summary(two_mixed)
  ================================================================================================
   Linear mixed model fit by REML 
  Formula: Y ~ as.factor(E) + (1 | V) + (1 | E * V) 
     Data: example 
     AIC   BIC logLik deviance REMLdev
   75.08 77.99 -31.54     78.5   63.08
  Random effects:
   Groups   Name        Variance   Std.Dev.  
   E * V    (Intercept) 5.1664e+01 7.18776232
   V        (Intercept) 1.5715e-07 0.00039642
   Residual             2.3167e+01 4.81322412
  Number of obs: 12, groups: E * V, 6; V, 2

  Fixed effects:
                  Estimate Std. Error t value
  (Intercept)       55.500      5.624   9.869
  as.factor(E)90   -34.250      7.953  -4.306
  as.factor(E)120  -46.250      7.953  -5.815

  Correlation of Fixed Effects:
              (Intr) a.(E)9
  as.fct(E)90 -0.707       
  as.fc(E)120 -0.707  0.500
  ================================================================================================
  anova(two_mixed)
  ================================================================================================
  Analysis of Variance Table
    Df Sum Sq Mean Sq F value
  E  2 844.56  422.28  18.228
  ================================================================================================

  #-----------------------------------------------------------------------------------------------
  # End..




