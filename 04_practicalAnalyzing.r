library(ggplot2);
df_data = read.csv(file = ".\\dataset\\NHIS_OPEN_GJ_2016.csv", header = TRUE,  sep = ",", row.names = NULL,  stringsAsFactors = FALSE);
str(df_data);
# 인텔리제이키바인딩세트 disable 시켜랏

sort(unique(df_data$연령대코드.5세단위.));
colnames(df_data)[3] = "gender";
colnames(df_data)[4] = "age";
colnames(df_data)[6] = "height";
colnames(df_data)[7] = "weight";
print("oioi~");


# BMI = kg(weight) / (키/100)^ 
# 
new_data = subset(df_data, select=c("gender","age","height","weight"));
print(new_data);

new_data$bmi = new_data$weight / ((new_data$height / 100)^2 );
str(new_data);

new_data$bmi_level = ifelse(new_data$bmi >= 30, "고도비만", ifelse(new_data$bmi >= 25, "비만", ifelse(new_data$bmi >= 23, "과체중", ifelse(new_data$bmi >= 18.5, "정상", "저체중"))));
print(head(new_data, 10));

summary(new_data);

# NA는 결측치 not applicable
# 결측치 빼고 나머지 평균해서 채워넣는 경우도 있음
# 아예 없애버리는 방법도 있음
# 없애버리는 방법
new_data = na.omit(new_data);


# factor 범주화
new_data$gender = factor(new_data$gender, levels=c(1,2), labels= c("male", "female") );
new_data$age = factor(new_data$age);
new_data$bmi_level = factor(new_data$bmi_level);
summary(new_data$age);


# 성별끼리 분석을 해보자
table(new_data$gender, new_data$bmi_level);
print(table(new_data$gender, new_data$bmi_level));

# 비율로 만들어서 분석하자 위엣거를
# 행방향으로 더해서 비율로 margin=1(행) 
# margin=2(열)
prop.table(table(new_data$gender, new_data$bmi_level), margin=1);
# 반올림
round(prop.table(table(new_data$gender, new_data$bmi_level), margin=1), 4);
round(prop.table(table(new_data$gender, new_data$bmi_level), margin=1), 4)*100;
# 전체 : 정상>비만>과체중>저체중>고도비만
# 남자 : 비만>정상>과체중>고도비만>저체중
# 여자 : 정상>비만>과체중>저체중>고도비만

# 분석함에있어서 {중요한변수}를 빠뜨리지마라라라라라라룰루랄라

table(new_data$age, new_data$bmi_level);


new_data$new_age = ifelse(new_data$age==5|new_data$age==6, "20대",
ifelse(new_data$age==7|new_data$age==8, "30대",
ifelse(new_data$age==9|new_data$age==10, "40대",
ifelse(new_data$age==11|new_data$age==12, "50대",
ifelse(new_data$age==13|new_data$age==14, "60대",
ifelse(new_data$age==15|new_data$age==16, "70대", "80대"))))));

new_data$new_age = factor(new_data$new_age);
summary(new_data);

table(new_data$age, new_data$bmi_level);
table(new_data$new_age, new_data$bmi_level);

round(prop.table(table(new_data$new_age, new_data$bmi_level), margin=1),3)*100;

# female 자료만 뽑는다
new_data2 = new_data[new_data$gender=="female", ];

summary(new_data2);
round(prop.table(table(new_data2$new_age, new_data2$bmi_level), margin=1),3)*100;

# 문제(대상, 세부조사문제)를 파악 - 데이터를 수집 - 테이터 요약(수치&그림) - 데이터 분석(통계적 가설검정) & 결론 (맞으면 멈추고 안맞으면 다시 1번째로 ㄱㄱ 싸이크을~~~)
# 객관적으로 분석



## ggplot2 를 쓰자

## 막대그래프
## 기본 뼈대 만들고 + 로 더 추가한다 fill:범례주기 geon_bar:막대그래프
ggplot(new_data, aes(x=gender, fill=gender)) + geom_bar();

ggplot(new_data, aes(x=bmi_level, fill=gender)) + geom_bar();


## 히스토그램   aes:x축결정 xlim:x축한계
ggplot(new_data, aes(x=weight, fill=gender)) + geom_histogram();
ggplot(new_data, aes(x=bmi, fill=gender)) + geom_histogram();
ggplot(new_data, aes(x=bmi, fill=bmi_level)) + geom_histogram() + xlim(10,45);

ggplot(new_data[new_data$gender == "male",], aes(x=bmi, fill=bmi_level)) + geom_histogram() + xlim(10,45);
ggplot(new_data[new_data$gender == "female",], aes(x=bmi, fill=bmi_level)) + geom_histogram() + xlim(10,45);

## 점포인트
ggplot(new_data, aes(x=height, y=weight, shape=gender, color=gender)) + geom_point(aes(size=weight)) + scale_size(range=c(1,3));

##박스플랏
ggplot(new_data, aes(x=new_age, y=bmi, fill=new_age)) + geom_boxplot() + xlab("연령") + ylab("BMI") + theme(axis.title.x = element_text(size=12)) + ggtitle("상자그림(boxploit)을 활용한 BMI 분석") + theme(plot.title=element_text(hjust=0.5, size=14)) + scale_fill_discrete(name="연령")
ggplot(new_data, aes(x=bmi_level, y=bmi, fill=bmi_level)) + geom_boxplot() + xlab("비만도수준") + ylab("BMI") + theme(axis.title.x = element_text(size=12)) + ggtitle("상자그림(boxploit)을 활용한 비만도 수준별 분석") + theme(plot.title=element_text(hjust=0.5, size=14)) + scale_fill_discrete(name="비만도수준", limits=c("고도비만", "비만", "과체중", "정상", "저체중")) + scale_x_discrete(limits=c("고도비만", "비만", "과체중", "정상", "저체중"))

