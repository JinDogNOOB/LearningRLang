x <- 3

x <- c(1,3)
y <- c(5,6)
z <- c(1,2,3)

print (x)
print(y)
print(x+y);
print(2-3);
print(z);

print(2.7)
print("hello")
print(FALSE)

matrix(
    c(1,2,3,4,5,6),
    nrow=2,
    ncol=3
)


if(x == y | z == z){
    print(TRUE);
}else{
    print(FALSE);
}


divTwoArg <- function(n, m){
    return (n/m)
}

print(divTwoArg(5,2))


name = c("aaa", "bbb", "ccc");
score_1 = c(90, 100, 85)
score_2 = c(82, 80, 90)

total_score = score_1 + score_2
print(total_score/2)


df1 = data.frame(name, score_1, score_2)
print("데이타 프레임 할때 data.frame 하면된다 그러면 넣은 매개변수배열 인덱스로 묶어줌 ")
print(df1);
# comment

print(head(df1, 3));
# 앞에꺼 6개 보여준다
print(tail(df1, 3));
# 뒤엣거 세개 보여준다.
str(df1);
# data structure를 본다.

print(score_1 + score_2);

print(data.frame(df1, score_1 + score_2));
# print(df1 / 2);
# 글자가 있으면 데이터 프레임에 나눗셈이나 그런거 못함 

# R에서 if, else if, else 쓸수있는데
# 벡터연산이 불편함

# R은 ifelse 줌 
# 사용법 (조건, true일때 리턴값, false일때 리턴값)

ifelse(score_1 >= 90, "AAA", ifelse(score > 80, "B", ifelse(score > 70, "C", "F")));

# 90이상이면 A 80이상이면 B 70이상이면 C 미만이면 F
testScore = c(70, 30, 89, 90, 100, 85, 97);
testName = c("a", "b", "c", "d", "e", "f", "f");
result = ifelse(testScore >= 90, "A", ifelse(testScore >= 80, "B", ifelse(testScore >= 70, "C", "F")));
print(result);

df2 = data.frame(testName, testScore, result);
print(df2);

print(summary(df2));

print(summary(score_1));
print(score_1);
print(sd(score_1));
# 값이 퍼진 정도 standard deviation

# 평균을 중심으로 퍼진정도
# 상한값
print(91.67 + sd(score_1));

#하한값
print(91.67 - sd(score_1));
