# for()를 이용하여 1, 2, 3, 4 값 출력하기 

	for(i in 1:4) print(i)

# 100부터 200까지의 합을 구해보자 
	start=100; end=200
	isum=0
	for(i in start:end) isum=isum+i
	
print(isum)

# 문자 변수의 루핑 예
	transport = c("bus", "subway", "car", "bike")
	for(vehicle in transport){
		print(vehicle)
	}

#while

	n=0
	sum.sofar=0
	while(sum.sofar<=100) {
	n=n+1
	sum.sofar=sum.sofar+n
	}
	print(n) ; print(sum.sofar)


#repeat

	n=0
	sum.sofar=0
	repeat{
	n=n+1
	sum.sofar=sum.sofar+n
	if(sum.sofar>100) break
	}
	print(n) ; print(sum.sofar)


#for & if
	x=c(1,-2,0,4,5)
	pos=rep(0,5)
	for( i in 1:5){
		if(x[i]>0) pos[i]=1
		else pos[i]=0
	}
	print(pos)
	
#for & if 2
	pos=rep(0,5)
	for(i in 1:5){
		if(x[i]>0) pos[i]=1
		else if(x[i]==0) pos[i]=2
		else pos[i]=3
	}
	print(pos)

#ifelse 

score=c(2,1,0,14,19,20,31)
	ifelse(score>=2,1,0)


#missing value

	x=c(1,6,2,NA)
	is.na(x)

	mean(x)  # NA로 표시
	mean(x,na.rm=TRUE) #NA를 제외하고 계산


	xx=na.omit(x)
	na.action(na.omit(x)) #결측값의 위치 찾기

# rank 
	r=rank(x)
	r=rank(x,na.last=FALSE) 

# read data in library

data(Orange)
head(Orange)

data()

# read data (txt, csv)
txtdata=read.table("ch2_test_data.txt",header=T)
csvdata=read.csv("ch2_test_data.csv",header=T)

test1=cbind(txtdata,csvdata)
write.csv(test1,"test1.csv")


#data merge 
authors=data.frame(surname=c("Tukey","Venables","Tierney","Ripley","McNeil"),
nationality=c("US","Australia","US","UK","Australia"))


books=data.frame(name=c("Tukey","Venables","Tierney","Ripley","McNeil"),
year=c(1976,1995,1996,1998,2000))

d=merge(authors,books)
d=merge(authors,books,by.x="surname",by.y="name")


books2=data.frame(name=c("Tukey","Venables","Tierney","Ripley","McNeil","Kim"),
year=c(1976,1995,1996,1998,2000,2008))

d2=merge(authors,books2,by.x="surname",by.y="name")

d3=merge(authors,books2,by.x="surname",by.y="name",all=TRUE)


#make simple plot
x=1:10
y=(x-5)^2

plot(x,y)
plot(y~x)

