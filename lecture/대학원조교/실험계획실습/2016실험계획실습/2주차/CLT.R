
##Central limit theorem


rs<-10000
n<-10
lamda<-4
X<-matrix(rpois(rs*n,lamda),ncol=n)

head(X,10)

sample.sums<-apply(X,1,sum)
sample.means<-apply(X,1,mean)
sample.vars<-apply(X,1,var)


hist(X,col="gray",main="Distribution of One Sample")
hist(sample.sums,col="gray",main="Sampling Distributionnof
     the Sum")
hist(sample.means,col="gray",main="Sampling Distributionnof the Mean")
hist(sample.vars,col="gray",main="Sampling Distributionnof
     the Variance")





sdm.sim <- function(n,src.dist=NULL,param1=NULL,param2=NULL) {
  r <- 10000  
  my.samples <- switch(src.dist,
                       "E" = matrix(rexp(n*r,param1),r),
                       "N" = matrix(rnorm(n*r,param1,param2),r),
                       "U" = matrix(runif(n*r,param1,param2),r),
                       "P" = matrix(rpois(n*r,param1),r),
                       "C" = matrix(rcauchy(n*r,param1,param2),r),
                       "B" = matrix(rbinom(n*r,param1,param2),r),
                       "G" = matrix(rgamma(n*r,param1,param2),r),
                       "X" = matrix(rchisq(n*r,param1),r),
                       "T" = matrix(rt(n*r,param1),r))
  all.sample.sums <- apply(my.samples,1,sum)
  all.sample.means <- apply(my.samples,1,mean)   
  all.sample.vars <- apply(my.samples,1,var) 
  par(mfrow=c(2,2))
  hist(my.samples[1,],col="gray",main="Distribution of One Sample")
  hist(all.sample.sums,col="gray",main="Sampling Distributionnof
       the Sum")
  hist(all.sample.means,col="gray",main="Sampling Distributionnof the Mean")
  hist(all.sample.vars,col="gray",main="Sampling Distributionnof
       the Variance")
}



sdm.sim(10,src.dist="E",1)
sdm.sim(50,src.dist="E",1)
sdm.sim(100,src.dist="E",1)
sdm.sim(10,src.dist="X",14)
sdm.sim(50,src.dist="X",14)
sdm.sim(100,src.dist="X",14)
sdm.sim(10,src.dist="N",param1=20,param2=3)
sdm.sim(50,src.dist="N",param1=20,param2=3)
sdm.sim(100,src.dist="N",param1=20,param2=3)
sdm.sim(10,src.dist="G",param1=5,param2=5)
sdm.sim(50,src.dist="G",param1=5,param2=5)
sdm.sim(100,src.dist="G",param1=5,param2=5)   #n의 값이 커짐에 따라 분포가 정규분포에 가까워지는 것을 볼 수 있고 Variance는 작아지는 것을 볼 수 있다.

