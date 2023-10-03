#effect funciont
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


#Ex 8.1

A<-factor(c(-1,1))
B<-factor(c(-1,1))
C<-factor(c(-1,1))
D<-factor(c(-1,1,1,-1,1,-1,-1,1))

dat_8.1<-expand.grid(A=A,B=B,C=C)
count<-c(45,100,45,65,75,60,80,96)
dat_8.1<-cbind(dat_8.1,D,count)

fit_8.1<-aov(count~A+B+C+D+A:B+A:C+A:D,data=dat_8.1)
summary(fit_8.1)
mt8.1<-model.tables(fit_8.1,methods="effect")$table
y_8.1<-eff(mt8.1)



#Ex 8.2

A<-factor(c(-1,1))
B<-factor(c(-1,1))
C<-factor(c(-1,1))
D<-factor(c(-1,1))
dat_8.2<-expand.grid(A=A,B=B,C=C,D=D)
E<-factor(c(1,-1,-1,1,-1,1,1,-1,-1,1,1,-1,1,-1,-1,1))

count<-c(8,9,34,52,16,22,45,60,6,10,30,50,15,21,44,63)
dat_8.2<-cbind(dat_8.2,E,count)
fit_8.2<-aov(count~A+B+C+D+E+A:B+A:C+A:D+A:E+B:C+B:D+B:E+C:D+C:E+D:E,data=dat_8.2)
summary(fit_8.2)


mt8.2<-model.tables(fit_8.2,type="effect")$tables

y<-eff(mt8.2)
tmp <- qqnorm(y)
qqline(y)
text(tmp$x, tmp$y, names(y), pos=3)


fit_8.2_2<-aov(count~A+B+C+A:B,data=dat_8.2)
summary(fit_8.2_2)
par(mfrow=c(2,2))
plot(fit_8.2_2)
interaction.plot(dat_8.2$A,dat_8.2$B,response=dat_8.2$count,col=c(1:2))



# Ex 8.4


A<-factor(c(-1,1))
B<-factor(c(-1,1))
C<-factor(c(-1,1))
D<-factor(c(-1,1))
E<-factor(c(-1,1,1,-1,1,-1,-1,1,-1,1,1,-1,1,-1,-1,1))
F<-factor(c(-1,-1,1,1,1,1,-1,-1,1,1,-1,-1,-1,-1,1,1))
dat_8.4<-expand.grid(A=A,B=B,C=C,D=D)
count<-c(6,10,32,60,4,15,26,60,8,12,34,60,16,5,37,52)
dat_8.4<-cbind(dat_8.4,E,F,count)

fit_8.4<-aov(count~(A+B+C+D+E+F)^2+A:B:D+A:B:F,data=dat_8.4)
summary(fit_8.4)

mt8.4<-model.tables(fit_8.4,type="effect")$tables

y<-eff(mt8.4)
tmp <- qqnorm(y)
qqline(y)
text(tmp$x, tmp$y, names(y), pos=3)

interaction.plot(dat_8.4$A,dat_8.4$B,response=dat_8.4$count,col=c(1:2))

fit_8.4_2<-aov(count~A*B,data=dat_8.4)
summary(fit_8.4_2)
par(mfrow=c(2,2))
plot(fit_8.4_2)
