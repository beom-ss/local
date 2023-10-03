# 요약테이블 tapply를 이용

# 예제)
head(mtcars)
dim(mtcars)

table(mtcars$cyl)
tapply(mtcars$mpg, mtcars$cyl,mean)

table(mtcars$am)
tapply(mtcars$disp, mtcars$am, median)

table(mtcars$gear)
tapply(mtcars$wt, mtcars$gear, var)

table(list(mtcars$am, mtcars$gear))
tapply(mtcars$mpg, list(mtcars$am, mtcars$gear), mean)

table(list(mtcars$gear, mtcars$cyl, mtcars$am))
tapply(mtcars$mpg, list(mtcars$gear, mtcars$cyl, mtcars$am), mean) # Vector로 해야 구해짐.
tapply(mtcars, list(mtcars$am, mtcars$gear, mtcars$cyl), mean)# DataFrame으로 할 경우 오류발생

ftable(tapply(mtcars$mpg, list(mtcars$gear, mtcars$cyl, mtcars$am), mean))

table(mtcars$gear)
table(mtcars$cyl)
table(mtcars$am)

table(mtcars$cyl, mtcars$am)
table(mtcars$cyl, mtcars$am, mtcars$gear)

# 데이터 불러오기
# 파일 불러오기 ( txt파일 <read.table>, excel파일<read.xlsx>, csv파일<read.csv>)

# "," 쉼표 구분자로 이루어진 엑셀 csv파일
data<-read.csv("Data1_CSV.csv") #첫행에 변수명이 있는 경우
data<-read.csv("Data1_CSV.csv", header=F) #첫행에 변수명이 없는 경우
names(data)<-c("column1","column2") #각각의 colum에 변수명을 입력함

# Data의 구분자가 각각 다르기 때문에 Data를 불러올 때 sep명령어로 구분자를 지정해줘야 한다.
# 1. sep="" <- 공백 구분자
# 1. sep="\t" <- 탭 구분자
# 1. sep="," <- , 구분자 이부분은 csv로 불러오면 해결된다.
data<-read.table("Data2_tab.txt", sep="\t")
data<-read.table("Data3_txt.txt", sep="")
data<-read.table("Data4_comma.txt", sep=",")

# Excel파일 불러오기
# http://www.activestate.com/activeperl에서 기본 Perl설치
install.packages("xlsx") # excel 파일명이 .xlsx 인경우
install.packages("gdata") # excel 파일명이 .xls
library("xlsx")
library("gdata")

# 이런식으로 Excel 시트별로 data를 불러 올 수 있지만 다른 소프트 웨어가 필요함. 귀찮게 이것저것 설치 하기 싫으면 Excel을 CSV같은 표준형식으로 저장해서 이용하면 된다.
data<-read.xlsx("Data5_excel.xlsx", sheetIndex=1)
data<-read.xlsx("Data5_excel.xlsx", sheetIndex=2)

data()
fix(mtcars)

data<-mtcars
head(data)

install.packages("ggplot2")
install.packages("gcookbook")

install.packages(c("ggplot2", "gcookbook"))

library(ggplot2)
library(gcookbook)

# 산점도 그리기
attach(data)
plot(hp, drat)
plot(data$wt, data$mpg)
qplot(data$wt, data$mpg)
qplot(wt, mpg, data=data)
plot(data) # 행렬 산점도 그리기
detach(data)

# 선그리기
plot(pressure$temperature, pressure$pressure, type="l")
points(pressure$temperature, pressure$pressure)

lines(pressure$temperature, pressure$pressure/2, col="red")
points(pressure$temperature, pressure$pressure/2, col="red")

qplot(pressure$temperature, pressure$pressure, geom=c("line", "point"))

# 막대 그래프 그리기
barplot(BOD$demand, names.arg=BOD$Time)
table(mtcars$cyl)
# 빈도수 그래프 그리기
barplot(table(mtcars$cyl))

qplot(BOD$Time, BOD$demand, geom="bar", stat="identity")

# factor를 이용해서 연속형을 이산형으로 변경해서 막대그래프 그리기
qplot(mtcars$cyl) # 연속적인 값
qplot(factor(mtcars$cyl)) # 이산형 값으로 변형

# histogram 그리기
hist(mtcars$mpg)
hist(mtcars$mpg, breaks=10) # breaks 상자 갯 수 지정하기

qplot(mtcars$mpg)
qplot(mpg, data=mtcars, binwidth=4) # binwidth 상자넓이 지정 위에 breaks와 같은 개념으로 생각하면 쉽다.

# Boxplot 그리기
head(ToothGrowth)
plot(ToothGrowth$supp, ToothGrowth$len)
boxplot(len ~ supp, data=ToothGrowth)
boxplot(len ~ supp + dose, data=ToothGrowth) # 두변수의 상호작용으로 Boxplot그리기 x축의 이름을보면 2개의 변수가 합쳐진것을 알 수 있다.

qplot(ToothGrowth$supp, ToothGrowth$len, geom="boxplot")
qplot(interaction(ToothGrowth$supp, ToothGrowth$dose), ToothGrowth$len, geom="boxplot") # 두변수의 상호작용으로 Boxplot 그리기

# 함수 곡선 그리기
curve(x^3 -5*x, from=-4, to=4)

# 사용자 정의 함수 만들기
myfun<-function(xvar){
  1/(1+exp(-xvar + 10))
}

curve(myfun(x), from=0, to=20)
curve(1-myfun(x), add=T, col="red")

# 막대를 함께 묶기

library(gcookbook)
cabbage_exp
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) + geom_bar(position="dodge", stat="identity") +
  geom_text(aes(label=Weight), vjust=1.5, color="white", position=position_dodge(.9), size=5)

head(mtcars)
ggplot(mtcars, aes(x=cyl, y=hp, fill=factor(carb))) + geom_bar(position="dodge", stat="identity")