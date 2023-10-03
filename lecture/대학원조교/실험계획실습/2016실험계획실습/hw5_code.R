##7.18

Glucose<-factor(c(20,60))
NH4NO3<-factor(c(2,6))
FeSO4<-factor(c(6,30))
MnSO4<-factor(c(4,20))
y<-c(23,15,16,18,25,16,17,26,28,16,18,21,36,24,33,34)

A<-B<-C<-D<-c(-1,1)
dat<-expand.grid(A=A,B=B,C=C,D=D)
block<-factor(ceiling(abs(dat[,1]*dat[,2]*dat[,3]*dat[,4]+0.5)))

dat7.18<-cbind(block,expand.grid(A=Glucose,B=NH4NO3,C=FeSO4,D=MnSO4),y)

