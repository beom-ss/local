
 data(cars);
  head(cars)
  dim(cars);

 #(1)

 #1 벡터만들기
  id <- seq(1,50)
  test <- rep(seq(1,10,by=2),10)
  cars2 <- data.frame(cars,id=id,test=test)
  head(cars2)

 #2  for문
  max(cars$speed)
  min(cars$speed)
  
  z <- rep(0,50)
  mean <- mean(cars$dist)
  for(i in 1:50){
  	if(cars$dist[i] > mean){
		z[i]=1;
	} else { 
		z[i]=0;
	}
   }

  cars3 <- data.frame(cars2,z=z)
  head(cars3)

  #3 merge
  id <- read.csv('id.csv',header=F, col.names=c("id","x"))
  head(id)
  cars4 <- merge(cars3,id)

  #4 sorting
  
  cars4[order(cars4$test,-cars4$x),]
  
  #5 tapply
  sum <- tapply(cars4$speed,cars4$z,mean)

  #6 table
  table(cars4$test,cars4$z)

  #7 일부가져와서 플라팅
  par(mfrow=c(1,2))
  hist(cars4$x[cars4$z==1]);
  hist(cars4$x[cars4$z!=1]);

  boxplot(cars4$x~cars4$z, main="Do they have a different distribution?")


 #(2)
 
  #1 scatter corr(plotting, option)
 
  #2 reg -lm 

  #4 beta0 beta1 신뢰구간 99% 

  #3 beta1 단측검정 (0말고 따른거 검정) 95%

  #5 신뢰구간 평균 95%

  


