##6.1

bitsize<-factor(c(-1,1))
speed<-factor(c(-1,1))
board<-factor(c(1:4))

dat6.1<-expand.grid(A=bitsize,B=speed,rep=board)
vib<-c(
   18.2,27.2,15.9,41.0,
   18.9,24.0,14.5,43.9,
   12.9,22.4,15.1,36.3,
   14.4,22.5,14.2,39.9)
dat6.1<-cbind(dat6.1,vib)

#a

##model ANOVA table 만들기

fit6.1<-anova(lm(vib~A*B,data=dat6.1))

SSmodel<-sum(fit6.1$"Sum Sq"[1:3])
Dfmodel<-sum(fit6.1$"Df"[1:3])
MSmodel<-SSmodel/Dfmodel

MSresid<-fit6.1$"Mean Sq"[4]

Fmodel<-MSmodel/MSresid
P.value<-1-pf(Fmodel,Dfmodel,fit6.1$"Df"[4],lower.tail = TRUE)

fit6.1_model<-cbind(Df=Dfmodel,"Sum Sq"=SSmodel,"Mean Sq"=MSmodel,"F value"=Fmodel,"Pr(>F)"=P.value)
rownames(fit6.1_model)<-"Model"

(anova6.1<-rbind(fit6.1_model,fit6.1))


## The Model F-value of 91.35833 implies the model is significant. 
There is only a 0.01% chance that a "Model F-Value" this large could occur due to noise.


#b

fit6.1.2<-aov(vib~A*B,data=dat6.1)

#simple한 방법
par(mfrow=c(2,2))
plot(fit6.1.2)

#plot 옵션을 사용하고자 할 때
par(mfrow=c(1,2))
qqnorm(rstandard(fit6.1.2), ylab="Standardized Residuals", xlab="Normal Scores", main="Normal QQ-plot", lwd=2)
qqline(rstandard(fit6.1.2), col="red")

plot(predict(fit6.1.2),resid(fit6.1.2), lwd=2, main="Residuals vs Predict Values", xlab="Predict Values", ylab="Residuals")
abline(0,0,col="red")


##There is nothing unusual about the residual plots.


#c

interaction.plot(dat6.1$A,dat6.1$B,dat6.1$vib,col =c(2,4), lwd=2, type="l",trace.label=c("Speeds"),leg.bty="o",
         xlab="Bit Size", ylab="Vibration", main="Interaction plot")
points(dat6.1$A,dat6.1$vib,col=(2*(dat6.1$B!=-1)+2), cex=1, pch=19)

#Once the small bit is specified, either speed will work equally well, 
#because the slope of the curve relating vibration to speed for the small tip is approximately zero.
#The process is robust to speed changes if the small bit is used.



##6.12

arsenic<-factor(c(-1,1))
deposition<-factor(c(-1,1))
repeated<-factor(c(1:4))

dat6.12<-expand.grid(A=arsenic,B=deposition,rep=repeated)
thick<-c(
   14.037,13.880,14.821,14.888,
   16.165,13.860,14.757,14.921,
   13.972,14.032,14.843,14.415,
   13.907,13.914,14.878,14.932)

dat6.12<-cbind(dat6.12,thick)


#a

fit6.12<-aov(thick~A*B,data=dat6.12)

mt6.12<-model.tables(fit6.12,type="means")$tables

eff<-function(data)
{
   neff<-numeric(length(data))
   names(neff)<-names(data)

   for(i in 1:length(data))
   {
   if (length(data[[i]])==2) 
      {
      neff[i]<-data[[i]][2]-data[[i]][1]/(length(data[[i]])/2)
      }
   else if (length(data[[i]])==4) 
      {
      neff[i]<-(data[[i]][2,2]+data[[i]][1,1]-data[[i]][1,2]-data[[i]][2,1])/(length(data[[i]])/2)
      }
   else if (length(data[[i]])==8) 
      {
      neff[i]<-((data[[i]][2,2,2]+data[[i]][1,1,2]-data[[i]][1,2,2]-data[[i]][2,1,2])
            -(data[[i]][2,2,1]+data[[i]][1,1,1]-data[[i]][1,2,1]-data[[i]][2,1,1]))/(length(data[[i]])/2)
      }
   }
   return(neff)
}

eff(mt6.12)



#b
summary(fit6.12)


fit6.12_2<-anova(lm(thick~A*B,data=dat6.12))

SSmodel<-sum(fit6.12_2$"Sum Sq"[1:3])
Dfmodel<-sum(fit6.12_2$"Df"[1:3])
MSmodel<-SSmodel/Dfmodel

MSresid<-fit6.12_2$"Mean Sq"[4]

Fmodel<-MSmodel/MSresid
P.value<-1-pf(Fmodel,Dfmodel,fit6.12_2$"Df"[4],lower.tail = TRUE)

fit6.12_model<-cbind(Df=Dfmodel,"Sum Sq"=SSmodel,"Mean Sq"=MSmodel,"F value"=Fmodel,"Pr(>F)"=P.value)
rownames(fit6.12_model)<-"Model"

(anova6.12<-rbind(fit6.12_model,fit6.12_2))



#The "Model F-value" of 2.19 implies the model is not significant relative to noise. 
#There is a 14.25 % cahnace that a "Model F-value" this large could occur due to noise.

#Value of "Prob > F" less than 0.05 indicate model terms are significant.
#In this case there are no significant model terms.


#c
coded6.12<-eff(mt6.12)/2
coded6.12[1]<-mt6.12$`Grand mean` 

natur6.12<-cbind(
	intercept=(coded6.12[1]+coded6.12[2]*(-(59+55)/2)/((59-55)/2)+coded6.12[3]*(-(15+10)/2)/((15-10)/2)
			+coded6.12[4]*(-(59+55)/2)/((59-55)/2)*(-(15+10)/2)/((15-10)/2)),
	arsenic=(coded6.12[2]/((59-55)/2)+coded6.12[4]*(-(15+10)/2)/((15-10)/2)/((59-55)/2)),
	deposition=(coded6.12[3]/((15-10)/2)+coded6.12[4]*(-(59+55)/2)/((59-55)/2)/((15-10)/2)),
	interaction=(coded6.12[4]/((59-55)/2)/((15-10)/2))
)

coded6.12
natur6.12



#d
par(mfrow=c(1,2))
qqnorm(rstandard(fit6.12), ylab="Standardized Residuals", xlab="Normal Scores", main="Normal QQ-plot", lwd=2)
qqline(rstandard(fit6.12), col="red")

plot(predict(fit6.12),resid(fit6.12), lwd=2, main="Residuals vs Predict Values", xlab="Predict Values", ylab="Residuals")
abline(0,0,col="red")


#e
dat6.12

dat6.12.2<-dat6.12
dat6.12.2[5,4]<-14.165



fit6.12.2<-aov(thick~A*B,data=dat6.12.2)
summary(fit6.12.2)



mt6.12.2<-model.tables(fit6.12.2,type="means")$tables


coded6.12.2<-eff(mt6.12.2)/2
coded6.12.2[1]<-mt6.12.2$`Grand mean` 

natur6.12.2<-cbind(
	intercept=(coded6.12.2[1]+coded6.12.2[2]*(-(59+55)/2)/((59-55)/2)+coded6.12.2[3]*(-(15+10)/2)/((15-10)/2)
			+coded6.12.2[4]*(-(59+55)/2)/((59-55)/2)*(-(15+10)/2)/((15-10)/2)),
	arsenic=(coded6.12.2[2]/((59-55)/2)+coded6.12.2[4]*(-(15+10)/2)/((15-10)/2)/((59-55)/2)),
	deposition=(coded6.12.2[3]/((15-10)/2)+coded6.12.2[4]*(-(59+55)/2)/((59-55)/2)/((15-10)/2)),
	interaction=(coded6.12.2[4]/((59-55)/2)/((15-10)/2))
)

coded6.12.2
natur6.12.2


par(mfrow=c(1,2))
qqnorm(rstandard(fit6.12.2), ylab="Standardized Residuals", xlab="Normal Scores", main="Normal QQ-plot", lwd=2)
qqline(rstandard(fit6.12.2), col="red")

plot(predict(fit6.12.2),resid(fit6.12.2), lwd=2, main="Residuals vs Predict Values", xlab="Predict Values", ylab="Residuals")
abline(0,0,col="red")




##6.25
A<-B<-C<-D<-E<-factor(c(-1,1))

dat6.25<-expand.grid(A=A,B=B,C=C,D=D,E=E)
yield<-c(
	7,9,34,55,16,20,40,60,
	8,10,32,50,18,21,44,61,
	8,12,35,52,15,22,45,65,
	6,10,30,53,15,20,41,63)

dat6.25<-cbind(dat6.25,yield)



#a

x <- expand.grid(c(-1,1), c(-1,1), c(-1,1), c(-1,1), c(-1,1))
A <- x[,1]
B <- x[,2]
C <- x[,3]
D <- x[,4]
E <- x[,5]

fa <- expand.grid(c("A", ""), c("B", ""), c("C", ""), c("D", ""), c("E", ""))
u.eff <- numeric(nrow(fa))
names(u.eff) <- apply(fa, 1, paste, collapse="")

unrep.eff <- function (x,respon) {
  
  txt <- names(x)
  ntxt <- length(txt)
  ans <- numeric(ntxt)
  for (i in 1:ntxt) {
    y <- paste(strsplit(txt[i], "")[[1]], collapse="*")
    z <- eval(parse(text = y))
    ans[i] <- sum(z*respon)/(nrow(fa)/2)
  }
  names(ans) <- txt
  ans
  
}

y <- unrep.eff(u.eff, yield)


(tmp<-qqnorm(y, ylab="Standardized Residuals", xlab="Normal Scores", main="Normal QQ-plot", lwd=2))
qqline(y, col="red")
text(tmp$x[which(tmp$y >5)], tmp$y[which(tmp$y >5)], names(tmp$y[which(tmp$y >5)]), pos=3)



#From the normal probability plot of effects shown below, 
#effects A, B, C, and the AB interaction appear to be large.



#b

fit6.25<-anova(lm(yield~A*B+C,data=dat6.25))

SSmodel<-sum(fit6.25$"Sum Sq"[1:4])
Dfmodel<-sum(fit6.25$"Df"[1:4])
MSmodel<-SSmodel/Dfmodel

MSresid<-fit6.25$"Mean Sq"[5]

Fmodel<-MSmodel/MSresid
P.value<-1-pf(Fmodel,Dfmodel,fit6.25$"Df"[5],lower.tail = TRUE)

fit6.25_model<-cbind(Df=Dfmodel,"Sum Sq"=SSmodel,"Mean Sq"=MSmodel,"F value"=Fmodel,"Pr(>F)"=P.value)
rownames(fit6.25_model)<-"Model"

(anova6.25<-rbind(fit6.25_model,fit6.25))



#c
fit6.25.2<-aov(yield~A*B+C,data=dat6.25)

mt6.25.2<-model.tables(fit6.25.2,type="means")$tables


coded6.25<-eff(mt6.25.2)/2
coded6.25[1]<-mt6.25.2$`Grand mean`



#d

qqnorm(rstandard(fit6.25.2), ylab="Standardized Residuals", xlab="Normal Scores", main="Normal QQ-plot", lwd=2)
qqline(y, col="red")


#e
par(mfrow=c(2,3))
plot(as.numeric(dat6.25$A),resid(fit6.25.2), lwd=2, main="Residuals vs A", xlab="A", ylab="Residuals")
abline(0,0,col="red")

plot(as.numeric(dat6.25$B),resid(fit6.25.2), lwd=2, main="Residuals vs B", xlab="B", ylab="Residuals")
abline(0,0,col="red")

plot(as.numeric(dat6.25$C),resid(fit6.25.2), lwd=2, main="Residuals vs C", xlab="C", ylab="Residuals")
abline(0,0,col="red")

plot(as.numeric(dat6.25$D),resid(fit6.25.2), lwd=2, main="Residuals vs D", xlab="D", ylab="Residuals")
abline(0,0,col="red")

plot(as.numeric(dat6.25$E),resid(fit6.25.2), lwd=2, main="Residuals vs E", xlab="E", ylab="Residuals")
abline(0,0,col="red")


#f

interaction.plot(dat6.25$B,dat6.25$A,dat6.25$yield ,col =c(2,4), lwd=2, type="l",trace.label=c("Aperture"),leg.bty="o",
         xlab="Exposure time", ylab="yield", main="Interaction plot", ylim=range(dat6.25$yield))
points(dat6.25$B,dat6.25$yield,col=(2*(dat6.25$A!=-1)+2), cex=1, pch=19)



#g

#To achieve the highest yield, run B at the high level, A at the high level, and C at the high level.


#h
dat6.25.3<-expand.grid(A=c(-1,1),B=c(-1,1),C=c(-1,1))
dat6.25.3<-cbind(dat6.25.3,yield.avg=c(by(dat6.25$yield,dat6.25[,1:3],mean)))


install.packages("rgl")
library(rgl)

plot3d(dat6.25.3$A,dat6.25.3$B,dat6.25.3$C,xlab="x", ylab="y", zlab="z", site=1, type="p", lwd=15)
rgl.texts(dat6.25.3$A,dat6.25.3$B,dat6.25.3$C,dat6.25.3$yield.avg,col="black",adj=0.5, cex=1.2)




##6.36

A<-B<-C<-D<-factor(c(-1,1))
resist<-c(1.92,11.28,1.09,5.75,2.13,9.53,1.03,5.35,1.60,11.73,1.16,4.68,2.16,9.11,1.07,5.30)
dat6.36<-cbind(expand.grid(A=A,B=B,C=C,D=D),resist)

#a

x <- expand.grid(c(-1,1), c(-1,1), c(-1,1), c(-1,1))
A <- x[,1]
B <- x[,2]
C <- x[,3]
D <- x[,4]

fa <- expand.grid(c("A", ""), c("B", ""), c("C", ""), c("D", ""))
u.eff <- numeric(nrow(fa))
names(u.eff) <- apply(fa, 1, paste, collapse="")



y <- unrep.eff(u.eff, resist)


(tmp<-qqnorm(y, ylab="Standardized Residuals", xlab="Normal Scores", main="Normal QQ-plot", lwd=2))
qqline(y, col="red")
text(tmp$x[which(abs(tmp$y) >2)], tmp$y[which(abs(tmp$y) >2)], names(tmp$y[which(abs(tmp$y) >2)]), pos=3)



#b
fit6.36<-anova(lm(resist~A*B,data=dat6.36))

SSmodel<-sum(fit6.36$"Sum Sq"[1:3])
Dfmodel<-sum(fit6.36$"Df"[1:3])
MSmodel<-SSmodel/Dfmodel

MSresid<-fit6.36$"Mean Sq"[4]

Fmodel<-MSmodel/MSresid
P.value<-1-pf(Fmodel,Dfmodel,fit6.36$"Df"[4],lower.tail = TRUE)

fit6.36_model<-cbind(Df=Dfmodel,"Sum Sq"=SSmodel,"Mean Sq"=MSmodel,"F value"=Fmodel,"Pr(>F)"=P.value)
rownames(fit6.36_model)<-"Model"

(anova6.36<-rbind(fit6.36_model,fit6.36))



fit6.36.2<-aov(resist~A*B,data=dat6.36)

par(mfrow=c(2,2))


qqnorm(resid(fit6.36.2), ylab="Standardized Residuals", xlab="Normal Scores", main="Normal QQ-plot", lwd=2)
qqline(resid(fit6.36.2), col="red")

plot(predict(fit6.36.2),resid(fit6.36.2), lwd=2, main="Residuals vs A", xlab="A", ylab="Residuals")
abline(0,0,col="red")

plot(as.numeric(dat6.36$A),resid(fit6.36.2), lwd=2, main="Residuals vs A", xlab="C", ylab="Residuals")
abline(0,0,col="red")

plot(as.numeric(dat6.36$B),resid(fit6.36.2), lwd=2, main="Residuals vs B", xlab="B", ylab="Residuals")
abline(0,0,col="red")





#c

y <- unrep.eff(u.eff, log(resist))


(tmp<-qqnorm(y, ylab="Standardized Residuals", xlab="Normal Scores", main="Normal QQ-plot", lwd=2))
qqline(y, col="red")
text(tmp$x[which(abs(tmp$y) >0.5)], tmp$y[which(abs(tmp$y) >0.5)], names(tmp$y[which(abs(tmp$y) >0.5)]), pos=3)



fit6.36.3<-anova(lm(log(resist)~A+B,data=dat6.36))

SSmodel<-sum(fit6.36.3$"Sum Sq"[1:2])
Dfmodel<-sum(fit6.36.3$"Df"[1:2])
MSmodel<-SSmodel/Dfmodel

MSresid<-fit6.36.3$"Mean Sq"[3]

Fmodel<-MSmodel/MSresid
P.value<-1-pf(Fmodel,Dfmodel,fit6.36.3$"Df"[3],lower.tail = TRUE)

fit6.36.3_model<-cbind(Df=Dfmodel,"Sum Sq"=SSmodel,"Mean Sq"=MSmodel,"F value"=Fmodel,"Pr(>F)"=P.value)
rownames(fit6.36.3_model)<-"Model"

(anova6.36.3<-rbind(fit6.36.3_model,fit6.36.3))




fit6.36.4<-aov(log(resist)~A+B,data=dat6.36)

par(mfrow=c(2,2))


qqnorm(resid(fit6.36.4), ylab="Standardized Residuals", xlab="Normal Scores", main="Normal QQ-plot", lwd=2)
qqline(resid(fit6.36.4), col="red")

plot(predict(fit6.36.4),resid(fit6.36.4), lwd=2, main="Residuals vs A", xlab="A", ylab="Residuals")
abline(0,0,col="red")

plot(as.numeric(dat6.36$A),resid(fit6.36.4), lwd=2, main="Residuals vs A", xlab="C", ylab="Residuals")
abline(0,0,col="red")

plot(as.numeric(dat6.36$B),resid(fit6.36.4), lwd=2, main="Residuals vs B", xlab="B", ylab="Residuals")
abline(0,0,col="red")



#d

mt6.36.4<-model.tables(fit6.36.4,type="means")$tables


coded6.36<-eff(mt6.36.4)/2
coded6.36[1]<-mt6.36.4$`Grand mean`




##7.2
dat7.2<-dat6.1
colnames(dat7.2)[3]<-"block"

fit7.2<-anova(lm(vib~block+A*B,data=dat7.2))

SSmodel<-sum(fit7.2$"Sum Sq"[2:4])
Dfmodel<-sum(fit7.2$"Df"[2:4])
MSmodel<-SSmodel/Dfmodel

MSresid<-fit7.2$"Mean Sq"[5]

Fmodel<-MSmodel/MSresid
P.value<-1-pf(Fmodel,Dfmodel,fit7.2$"Df"[5],lower.tail = TRUE)

fit7.2_model<-cbind(Df=Dfmodel,"Sum Sq"=SSmodel,"Mean Sq"=MSmodel,"F value"=Fmodel,"Pr(>F)"=P.value)
rownames(fit7.2_model)<-"Model"

(anova7.2<-rbind(fit7.2_model,fit7.2))







##7.10

A<-B<-C<-factor(c(-1,1))
fill.1<-c(-3,0,-1,2,-1,2,1,6)
fill.2<-c(-1,1,0,3,0,1,1,5)
fill<-c(fill.1,fill.2)

rep<-factor(c(1,2))

dat7.10<-cbind(expand.grid(A=A,B=B,C=C,block=rep),fill)


fit7.10<-anova(lm(fill~block+A*B+C,data=dat7.10))

SSmodel<-sum(fit7.10$"Sum Sq"[2:5])
Dfmodel<-sum(fit7.10$"Df"[2:5])
MSmodel<-SSmodel/Dfmodel

MSresid<-fit7.10$"Mean Sq"[6]

Fmodel<-MSmodel/MSresid
P.value<-1-pf(Fmodel,Dfmodel,fit7.10$"Df"[6],lower.tail = TRUE)

fit7.10_model<-cbind(Df=Dfmodel,"Sum Sq"=SSmodel,"Mean Sq"=MSmodel,"F value"=Fmodel,"Pr(>F)"=P.value)
rownames(fit7.10_model)<-"Model"

(anova7.10<-rbind(fit7.10_model,fit7.10))


















