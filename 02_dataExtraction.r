## 미러에서 라이브러리 다운로드
## install.packages("writexl");

## 라이브러리 함수는 import 같은 include 같은 역할인듯
library(writexl);

## install.packages("readxl");
library(readxl);

name = c("A", "B", "C", "D", "E");
score_1 = c(100,20,70,30, 35);
score_2 = c(20, 18, 50, 39, 12);
average = c(40, 19, 60, 34, 24);
grade = c("A", "F", "A", "C", "B");

df_1 = data.frame(name, score_1, score_2, average, grade);

## 데이터 일부분 추출 df[행(데이터레코드 몇개가지고올건데), 열(컬럼 뭐 가지고올건데)]
print(df_1[1:4, c(1,2,3)]);
print(df_1[,1:3]);
print(df_1[2:3,]);
print(df_1[, c(1:2, 4)]);




## 숫자 조건으로 추출
print(df_1[average>=50 & average <=70, ]);
print(df_1[average>=50 | average <=70, ]);

## 문자열 조건으로 추출
print(df_1[grade == "A", ]);
print(df_1[grade == "A" | grade == "B", ]);
print(df_1[grade != "C", ]);

## 섭셋을 사용할수도있는데 subset은 너무 길어서 조금 에에에에에
print(subset(df_1, select=1:4));


## 파일로 저장
## csv 방식과 excel방식이 있는데 엑셀을 패키지나 그런것들 필요함...


## write.csv(df_1, file = "c:\\Users\\mrrie\\Desktop\\r\\dataset\\df_1", append = FALSE, quote = TRUE, sep = " ");
write.csv(df_1, file = ".\\dataset\\df_1", append = FALSE, quote = TRUE, sep = " ");
print("read___");
a = read.csv(file = ".\\dataset\\df_1", header = TRUE,  sep = ",", row.names = NULL,  stringsAsFactors = FALSE);
print(a);



write_xlsx(df_1, ".\\dataset\\xlsx_1.xlsx");
b = read_xlsx(".\\dataset\\xlsx_1.xlsx");
print("xlsx!!!");
print(b);
