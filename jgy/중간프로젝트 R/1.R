setwd("C:\\nineten\\Rwork\\data")



birth_rate <- read.csv("C:\\Users\\acorn\\Downloads\\시군구_성_월별_출생.csv", header = T)

View(birth_rate)

birth_rate <- birth_rate %>% filter(!grepl("특별시",시군구별))
birth_rate <- birth_rate %>% filter(!grepl("광역시",시군구별))
birth_rate <- birth_rate %>% filter(!grepl("북도",시군구별))
birth_rate <- birth_rate %>% filter(!grepl("남도",시군구별))
birth_rate <- birth_rate %>% filter(!grepl("강원도",시군구별))
birth_rate <- birth_rate %>% filter(!grepl("경기도",시군구별))
birth_rate <- birth_rate %>% filter(!grepl("특별자치",시군구별))

unique(birth_rate$시군구별)

birth_rate <- birth_rate[,-(2:3)]

str(birth_rate)


library(dplyr)
library(reshape2)

birth_rate <- melt(data=birth_rate, id="시군구별")
names(birth_rate) <- c("시군구별","시점","합계출산율")

birth_rate_1 <- birth_rate %>% filter(grepl("\\.01", 시점) %in% c(TRUE) | grepl("\\.02", 시점) %in% c(TRUE) | grepl("\\.03", 시점) %in% c(TRUE))
birth_rate_1 <- as.data.frame(birth_rate_1)
birth_rate_1$분기 <- 1

birth_rate_2 <- birth_rate %>% filter(grepl("\\.04", 시점) %in% c(TRUE) | grepl("\\.05", 시점) %in% c(TRUE) | grepl("\\.06", 시점) %in% c(TRUE))
birth_rate_2 <- as.data.frame(birth_rate_2)
birth_rate_2$분기 <- 2

birth_rate_3 <- birth_rate %>% filter(grepl("\\.07", 시점) %in% c(TRUE) | grepl("\\.08", 시점) %in% c(TRUE) | grepl("\\.09", 시점) %in% c(TRUE))
birth_rate_3 <- as.data.frame(birth_rate_3)
birth_rate_3$분기 <- 3

birth_rate_4 <- birth_rate %>% filter(grepl("\\.10", 시점) %in% c(TRUE) | grepl("\\.11", 시점) %in% c(TRUE) | grepl("\\.12", 시점) %in% c(TRUE))
birth_rate_4 <- as.data.frame(birth_rate_4)
birth_rate_4$분기 <- 4

unique(birth_rate_1$시점)
unique(birth_rate_2$시점)
unique(birth_rate_3$시점)
unique(birth_rate_4$시점)

birth_rate <- rbind(birth_rate_1,birth_rate_2,birth_rate_3,birth_rate_4)

View(birth_rate)

write.csv(birth_rate, "../data/korea_baby_cnt.csv", row.names = F)



---------------------------------------------------------------------------

#### 전국 시도별 합계출산율 ####


#female.cnt <- read.csv("C:\\Users\\acorn\\Downloads\\시군구_성_연령_1세_별_주민등록연앙인구_20230421181032.csv", header = T)

  
library(dplyr)  

female.cnt <- read.csv("C:\\nineten\\Rwork\\data\\서울시.csv", header = T)

f1 <- read.csv("C:\\nineten\\Rwork\\data\\서울시_20230425165111.csv", header=T)

f2 <- read.csv("C:\\nineten\\Rwork\\data\\대구인천광주대전울산세종시_20230425125220.csv", header=T)

f3 <- read.csv("C:\\nineten\\Rwork\\data\\경기도_20230425125648.csv", header=T)

f4 <- read.csv("C:\\nineten\\Rwork\\data\\경기도반_20230425125738.csv", header=T)
f5 <- read.csv("C:\\nineten\\Rwork\\data\\충북강원도_20230425125843.csv", header=T)
f6 <- read.csv("C:\\nineten\\Rwork\\data\\충남전북_20230425125924.csv", header=T)
f7 <- read.csv("C:\\nineten\\Rwork\\data\\전남경북_20230425130010.csv", header=T)
f8 <- read.csv("C:\\nineten\\Rwork\\data\\경남제주.csv", header=T)



f1 <- f1[, -4]
f1$합계 <- rowSums(select(f1, starts_with("X")))
f1 <- f1 %>% filter(!grepl("소계", 행정구역.시군구.별.2.))
View(f1)


f2 <- f2[, -4]
f2$합계 <- rowSums(select(f2, starts_with("X")))
f2 <- f2 %>% filter(!grepl("소계", 행정구역.시군구.별.2.))
View(f2)


f3 <- f3[, -4]
f3$합계 <- rowSums(select(f3, starts_with("X")))
f3 <- f3 %>% filter(!grepl("소계", 행정구역.시군구.별.2.))
View(f3)


f4 <- f4[, -4]
f4$합계 <- rowSums(select(f4, starts_with("X")))
f4 <- f4 %>% filter(!grepl("소계", 행정구역.시군구.별.2.))
View(f4)


f5 <- f5[, -4]
f5$합계 <- rowSums(select(f5, starts_with("X")))
f5 <- f5 %>% filter(!grepl("소계", 행정구역.시군구.별.2.))
View(f5)


f6 <- f6[, -4]
f6$합계 <- rowSums(select(f6, starts_with("X")))
f6 <- f6 %>% filter(!grepl("소계", 행정구역.시군구.별.2.))
View(f6)


f7 <- f7[, -4]
f7$합계 <- rowSums(select(f7, starts_with("X")))
f7 <- f7 %>% filter(!grepl("소계", 행정구역.시군구.별.2.))
View(f7)


f8 <- f8[, -4]
f8$합계 <- rowSums(select(f8, starts_with("X")))
f8 <- f8 %>% filter(!grepl("소계", 행정구역.시군구.별.2.))
View(f8)


f12 <- rbind(f1, f2)
f123 <- rbind(f12, f3)
f1234 <- rbind(f123, f4)
f12345 <- rbind(f1234, f5)
f123456 <- rbind(f12345, f6)
f1234567 <- rbind(f123456, f7)
f12345678 <- rbind(f1234567, f8)

View(f12345678)


f12345678 <- f12345678 %>% select(c("행정구역.시군구.별.1.", "행정구역.시군구.별.2.", "시점", 합계))
f12345678

f12345678 <- select(f12345678, -행정구역.시군구.별.1., -행정구역.시군구.별.2., 시점, 합계)




write.csv(f12345678, "C:\\nineten\\Rwork\\data\\시도별_가임여성.csv", row.names = F)




bc1 <- read.csv("C:\\nineten\\Rwork\\data\\출생아수_20230425175425.csv", header=T)

bc2 <- read.csv("C:\\nineten\\Rwork\\data\\출생아수1_20230425175545.csv", header=T)



b1 <- bc1 %>% filter(grepl("\\.01", 시점) %in% c(TRUE) | grepl("\\.02", 시점) %in% c(TRUE) | grepl("\\.03", 시점) %in% c(TRUE))
b1 <- as.data.frame(b1)
b1$분기 <- 1

b2 <- bc1 %>% filter(grepl("\\.04", 시점) %in% c(TRUE) | grepl("\\.05", 시점) %in% c(TRUE) | grepl("\\.06", 시점) %in% c(TRUE))
b2 <- as.data.frame(b2)
b2$분기 <- 2

b3 <- bc1 %>% filter(grepl("\\.07", 시점) %in% c(TRUE) | grepl("\\.08", 시점) %in% c(TRUE) | grepl("\\.09", 시점) %in% c(TRUE))
b3 <- as.data.frame(b3)
b3$분기 <- 3

b4 <- bc1 %>% filter(grepl("\\.1", 시점) %in% c(TRUE) | grepl("\\.11", 시점) %in% c(TRUE) | grepl("\\.12", 시점) %in% c(TRUE))
b4 <- as.data.frame(b4)
b4$분기 <- 4



bc1 <- rbind(b1,b2,b3,b4)

bc1 <- bc1 %>% filter(!grepl("소계", 시군구별.2.))



View(bc1)

b1 <- bc2 %>% filter(grepl("\\.01", 시점) %in% c(TRUE) | grepl("\\.02", 시점) %in% c(TRUE) | grepl("\\.03", 시점) %in% c(TRUE))
b1 <- as.data.frame(b1)
b1$분기 <- 1

b2 <- bc2 %>% filter(grepl("\\.04", 시점) %in% c(TRUE) | grepl("\\.05", 시점) %in% c(TRUE) | grepl("\\.06", 시점) %in% c(TRUE))
b2 <- as.data.frame(b2)
b2$분기 <- 2

b3 <- bc2 %>% filter(grepl("\\.07", 시점) %in% c(TRUE) | grepl("\\.08", 시점) %in% c(TRUE) | grepl("\\.09", 시점) %in% c(TRUE))
b3 <- as.data.frame(b3)
b3$분기 <- 3

b4 <- bc2 %>% filter(grepl("\\.1", 시점) %in% c(TRUE) | grepl("\\.11", 시점) %in% c(TRUE) | grepl("\\.12", 시점) %in% c(TRUE))
b4 <- as.data.frame(b4)
b4$분기 <- 4



bc2 <- rbind(b1,b2,b3,b4)

bc2 <- bc2 %>% filter(!grepl("소계", 시군구별.2.))


View(bc2)





bc12 <- rbind(bc1, bc2)


View(bc12)

write.csv(bc12, "C:\\nineten\\Rwork\\data\\시도별_출생아수.csv", row.names = F)



write.csv(f1, "C:\\nineten\\Rwork\\data\\서울시_가임여성.csv", row.names = F)
write.csv(f2, "C:\\nineten\\Rwork\\data\\대구인천광주대전울산세종시_가임여성.csv", row.names = F)
write.csv(f3, "C:\\nineten\\Rwork\\data\\경기도_가임여성", row.names = F)
write.csv(f4, "C:\\nineten\\Rwork\\data\\경기도반_가임여성.csv", row.names = F)
write.csv(f5, "C:\\nineten\\Rwork\\data\\충북강원도_가임여성", row.names = F)
write.csv(f6, "C:\\nineten\\Rwork\\data\\충남전북_가임여성", row.names = F)
write.csv(f7, "C:\\nineten\\Rwork\\data\\전남경북_가임여성", row.names = F)
write.csv(f8, "C:\\nineten\\Rwork\\data\\경남제주_가임여성", row.names = F)











View(female.cnt)

female.cnt <- female.cnt[,c(1,2,39)]
names(female.cnt) <- c("시점","시군구별","가임여성수")
View(female.cnt)





female.cnt <- female.cnt[-1,]
female.cnt$합계 <- rowSums(female.cnt[,-c(1:3)])
View(female.cnt)

female.cnt <- female.cnt[,c(1,2,39)]
names(female.cnt) <- c("시점","시군구별","가임여성수")
View(female.cnt)

# female.cnt[,"시도별"] <- "서울특별시"

write.csv(female.cnt, "../data/korea_female_1_cnt.csv", row.names = F)


female.cnt <- female.cnt %>% filter(!grepl("특별시",시군구별))
female.cnt <- female.cnt %>% filter(!grepl("광역시",시군구별))
female.cnt <- female.cnt %>% filter(!grepl("북도",시군구별))
female.cnt <- female.cnt %>% filter(!grepl("남도",시군구별))
female.cnt <- female.cnt %>% filter(!grepl("강원도",시군구별))
female.cnt <- female.cnt %>% filter(!grepl("경기도",시군구별))
female.cnt <- female.cnt %>% filter(!grepl("특별자치",시군구별))


unique(female.cnt$시점)

write.csv(female.cnt, "../data/korea_female_cnt.csv", row.names = F)




--------------------------------------------------------------------------------------







kfc <- read.csv("../data/korea_female_cnt.csv", encoding = "cp949")
kbc <- read.csv("../data/korea_baby_cnt.csv", encoding = "euc-kr")


View(kbc)
View(kfc)


library(tidyr)

View(kbc1)



tr.cnt <- read.csv("C:\\Users\\acorn\\Downloads\\시군구_합계출산율__모의_연령별_출산율_20230424161437.csv", header = T)

View(tr.cnt)

tr.cnt <- tr.cnt %>% filter(!grepl("특별시",시군구별))
tr.cnt <- tr.cnt %>% filter(!grepl("광역시",시군구별))
tr.cnt <- tr.cnt %>% filter(!grepl("북도",시군구별))
tr.cnt <- tr.cnt %>% filter(!grepl("남도",시군구별))
tr.cnt <- tr.cnt %>% filter(!grepl("강원도",시군구별))
tr.cnt <- tr.cnt %>% filter(!grepl("경기도",시군구별))
tr.cnt <- tr.cnt %>% filter(!grepl("특별자치",시군구별))

View(tr.cnt)
unique(tr.cnt$시군구별)


write.csv(tr.cnt, "../data/korea_true_cnt.csv", row.names = F)
