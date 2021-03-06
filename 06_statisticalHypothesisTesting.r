data1 = read.csv("./dataset/data5.csv");
mean(data1$before) - mean(data1$after);
# 2.58의 차이

# 가설설정
# h0 : 한달동안 유산소 후 몸무게 차이 없다
# h1 : 한달동안 유산소 후 몸무게 차이 있다


# h0(귀무가설) 참을 가정할시
# r 활용 분석을 수행, 대응표본 t 검정을 적용(쌍으로 표본이 대응되는게 있을시 사용하기 좋음) t.test() 함수 활용할 것임
t.test(data1$before - data1$after);
# t값은 검정통계량 



# 결과 판정 (유의수준 5%(0.05)만 허락하겠다) 유의수준은 분석 요구하는 사람이 정해주는것
# 결과를 보면 p-value = 0.000418 
# pvalue가 유의수준 내이다 따라서 h0기각, h1 채택


# 결론 보고서
# 유의수준 5% 하에서, 운동전 평균 몸무게와 유산소 운동 1개월 후 평균 몸무게는 차이가 있다.
# 추가로 평균 sd표준편차 넣어도 됨

