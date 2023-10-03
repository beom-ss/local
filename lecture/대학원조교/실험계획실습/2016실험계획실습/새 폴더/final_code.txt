


#effect function
###################################################################################################################

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
###################################################################################################################



##1

Mix<-factor(c("A","B","C"))
Lab<-factor(c(1,2))
Temp<-factor(c(145,155))
rep<-factor(c(1,2))

dat1<-expand.grid(rep=rep, Lab=Lab, Mix=Mix, Temp=Temp)
y<-c(11.2,11.1,11.8,11.8,
	11.2,11.5,12.3,12.3,
	11.5,11.4,12.3,11.9,
	6.7,6.8,7.3,7.2,
	6.8,6.7,7.5,7.7,
	7.0,7.0,7.5,7.3)

dat1<-cbind(dat1,y)


##1.1

fit1<-aov(y~Mix*Lab*Temp, data=dat1)
summary(fit1)



##1.2

par(mfrow=c(1,3))
# interaction plot
interaction.plot(dat1$Mix,dat1$Lab,response=dat1$y, col =c(2,4), lwd=2, type="l",trace.label=c("Laboratory"),leg.bty="o",
         xlab="Mix", ylab="effect", main="Interaction plot")
interaction.plot(dat1$Mix,dat1$Temp,response=dat1$y, col =c(2,4), lwd=2, type="l",trace.label=c("Temperature"),leg.bty="o",
         xlab="Mix", ylab="effect", main="Interaction plot")
interaction.plot(dat1$Lab,dat1$Temp,response=dat1$y, col =c(2,4), lwd=2, type="l",trace.label=c("Temperature"),leg.bty="o",
         xlab="Laboratory", ylab="effect", main="Interaction plot")





##2

##2.1

##2.2

##3

##3.1

##3.2





##4

A<-B<-C<-D<-c(-1,1)

dat4<-expand.grid(A=A,B=B,C=C,D=D)

E<-factor(dat2$A*dat2$B*dat2$C)
F<-factor(dat2$B*dat2$C*dat2$D)
G<-factor(dat2$A*dat2$C*dat2$D)

dat4$A<-factor(dat4$A)
dat4$B<-factor(dat4$B)
dat4$C<-factor(dat4$C)
dat4$D<-factor(dat4$D)

Pitch<-c(74,190,133,127,115,101,54,144,121,188,135,170,126,175,126,193)

dat4<-cbind(dat4,E,F,G,Pitch)


##4.2
fit4<-aov(Pitch~A*B*C*D*E*F*G,data=dat4)
summary(fit4)



mt4<-model.tables(fit4,type="effect")$tables

y<-eff(mt4)


##4.3
tmp <- qqnorm(y, ylab="Effect", xlab="Normal Scores", main="Normal QQ-plot", lwd=2)
qqline(y, col="red")
text(tmp$x, tmp$y, names(y), pos=3)























