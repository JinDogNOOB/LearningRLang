
library(readxl);
library(writexl);

df_1 = read_xlsx(".\\dataset\\xlsx_1.xlsx");
print(df_1);
## ***시각화 분석

## 막대 그래프 -> 그냥 나열
barplot(df_1$average, names=df_1$name, xlab="이름", ylab="평균점수", main="1차 시험 점수 공고", col=rainbow(7));

## 히스토그램 -> 빈도분석
hist(df_1$average, xlab="평균점수", ylab="빈도", col="red", main="평균점수 빈도");


nameWithAvg = paste(df_1$name, df_1$average, "\n", "(" ,round(df_1$average / sum(df_1$average), 3)*100 , ")%"); ## 이름과 점수를 이은 하나의 값 밑에 레이블로 넣자
## 파이 차트 -> 어떤놈이 많은 파이를 먹고있나
pie(df_1$average, labels=nameWithAvg, col=rainbow(length(df_1$name)));

## %를 구해보자
print(df_1$average / sum(df_1$average));
## 반올림
print( round(df_1$average / sum(df_1$average), 3) );


## 꺽은선 그래프  i선 o원+선 b원+선+공백
plot(df_1$average, type="b", axes=F, ann=F);

axis(1, at=1:5, lab=df_1$name);
axis(2);
title(xlab="Name", ylab="averageScore", main="우하하~");
## plot 매개변수로 넣을수있다
box();

## 두개를 묶어서 하고싶다 비교하고싶다
print(cbind(df_1$average, df_1$average+4));
averages = cbind(df_1$average, df_1$average+4);
matplot(averages, type="b", pch=c(1, 2), axes=F, ann=F);
axis(1, at=1:5, lab=df_1$name);
axis(2);
title(xlab="Name", ylab="averageScore", main="우하하~"); ## plot 매개변수로 넣을수있다
box();
legend(x="topright", y=0.8, c("1차 평균", "2차 평균"), lty=1:2, col=c("black", "red")); ## 범례


## 중앙값이 들어가는걸 그리고싶다..
boxplot(df_1$average, horizontal=FALSE, col="yellow", main="평균점수박스플롯");
print(summary(df_1$average));
df_1$name = factor(df_1$name);  ## 문자열을 범주형으로 바꿔서 summary에서 돌아가도록한다. factor() 함수
print(";");
print(summary(df_1));

## Q_3 : 제 3사분위수 = 데이터를 크기순으로 나열했을때 75%에 위치한 값
## Q_2 : 제 2사분위수 = 데이터를 크기순으로 나열했을때 50%에 위치한 값 == 중앙값(median)
## Q_1 : 제 1사분위수 = 데이터를 크기순으로 나열했을때 25%에 위치한값


## 사분위수 범위와 범위

## 범위(Range) == Max - Min
## 사분위수 범위(Inter-Quartile Range[IQR]) == Q_3 - Q_1

## 그 위에 botplot 에서 앞뒤쪽 짝대기는 min 과 max 범위를 나타내고
## 그 안에있는 박스는 사분위수 범위를 나타냄

## 퍼진정도를 알고싶을때 쓸수있는거는 분산과 표준편차가있다
## 분산(Variance)
## 표준편차(Standard Deviation [sd])



## 여러개의 plot 을 같이 그려보자
## 박스플랏안에다가 여러 플랏을 넣는 방법과
## 영역을 세분화해서 플랏을 여러개넣는 방법 있음

scores = cbind(df_1$average, df_1$score_1);
boxplot(scores, col=c("yellow", "pink"), names=c("평균", "스코어1"),main="스코어1과 평균");


## 여러 그림을 같이 출력 x행 y열로 그 그려라
par(mfrow=c(3,2));
boxplot(scores, col=c("yellow", "pink"), names=c("평균", "스코어1"),main="스코어1과 평균");
hist(df_1$average, col="yellow");
boxplot(scores, col=c("yellow", "pink"), names=c("평균", "스코어1"),main="스코어1과 평균");
hist(df_1$average, col="yellow");
boxplot(scores, col=c("yellow", "pink"), names=c("평균", "스코어1"),main="스코어1과 평균");
hist(df_1$average, col="yellow");