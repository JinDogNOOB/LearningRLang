# 트윗 데이터 가져오기 
# library twitteR 필요 설치한 상태임
library(twitteR);
library(tm);

# 인터넷에서부터 가져온다
conn = url("http://www.rdatamining.com/data/RDataMining-Tweets-20160203.rdata");
tweet = get(load(conn));
tweet;
# str(tweet);

tweet_df = twListToDF(tweet);
head(tweet_df);
colnames(tweet_df);

head(tweet_df$text, 6);


# 뭉치로 만들자 (텍스트 마이닝 준비작업)
tw_Corpus = Corpus(VectorSource(tweet_df$text));
inspect(tw_Corpus[5]);
inspect(tw_Corpus[6]);

# 소문자로 변환
tw_Corpus = tm_map(tw_Corpus, content_transformer(tolower));

# 트윗 내용 뒤에 붙어있는 주소 없애야한다
# 정규표현식 사용해서 
# 정규표현식 연습
# test = "http://test.com http htp htp ://test.com";
# test_Corpus = Corpus(VectorSource(test));

removeURL = function(str) gsub("http[^[:space:]]*", "", str);
# test_Corpus = tm_map(test_Corpus, content_transformer(removeURL));
# inspect(test_Corpus);

tw_Corpus = tm_map(tw_Corpus, content_transformer(removeURL));
inspect(tw_Corpus);


# 구두점 제거 
tw_Corpus = tm_map(tw_Corpus, removePunctuation);

# 숫자 제거
tw_Corpus = tm_map(tw_Corpus, removeNumbers);

# 매트릭스로 바꿔준다
tdm = TermDocumentMatrix(tw_Corpus, control = list(wordLengths=c(1, Inf)));
as.matrix(tdm);

tw_Corpus = tm_map(tw_Corpus, removeWords, stopwords('english')); 
# the a 이런거 제거

tdm = TermDocumentMatrix(tw_Corpus, control = list(wordLengths=c(1, Inf)));
m = as.matrix(tdm);
rowSums(m);
v = sort(rowSums(m), decreasing=T);

# 나온단어들 본다
head(v, 30);


d = data.frame(word=names(v), freq=v)
names(v);
str(d);
head(d);

library(ggplot2);
# 이미 정리가 합계가 다 된거여서 막대그래프 GEOM-BAR 그냥하면 안대고 매개변수로 stat="identity" 넣어줘야한다
# flip 뒤집어라
ggplot(d[1:20,], aes(x=reorder(word,freq), y=freq)) + geom_bar(stat="identity") + xlab("Terms") + ylab("Frequency") + coord_flip() + theme(axis.text=element_text(size=14))+
ggtitle("TEXT MINING") + theme(plot.title=element_text(hjust=1, size=16));









# 워드 클라우드 1
library(wordcloud);
# 기본형 워드클라우드 구름형태임
wordcloud(d$word, d$freq, scale=c(8, 0.5), minfreq=5, random.order=F);



# 워드 클라우드 2
# 알록달록 html을 output으로 보낸다
library(wordcloud2);
wordcloud2(d, size=2);
