apt <- read.csv("../data/분기별아파트매매가격.csv", header=T)
tfr <- read.csv("../data/분기별합계출산율.csv", header=T)

at <- read.csv("../data/분기별아파트매매가격과 합계출산율.csv", header=T)

View(apt)
View(tfr)

View(at)

library(moonBook)
moonBook::densityplot(X2017.1.4 ~ X2017_1_birth_rate, data=mydata)
at$X2017_1_birth_rate
t.test(at$X2017.1.4, at$X2017_1_birth_rate)

wilcox.test(X2017.1.4 ~ X2017_1_birth_rate, data=at)

tapply(at$X2017.1.4, at$X2017_1_birth_rate, mean)



library(reshape2)

at1 <- melt(att, id=("구별",""), variable.name = "GROUP", value.name="RESULT")                                       


att <- read.csv("../data/분기별아파트매매가격과 합계출산율1.csv", header=T)

View(att)

View(at1)


test1 <- read.csv("../data/분기별아파트매매가격과 합계출산율test.csv", header=T)

View(test1)


df <- read.csv("../data/10_rmanova.csv", header = T)

View(df)
str(df)
summary(df)

# wide to long
library(reshape2)

dflong <- melt(df, id = c("group","id"), 
               variable.name = "time", 
               value.name = "month",
               measure.vars = c("month0","month1","month3","month6"))

View(dflong)

with(dflong, interaction.plot(time, group, month))

out <- aov(month ~ group + time + group:time, data = dflong)
out <- aov(month ~ group * time, data = dflong)
shapiro.test(resid(out))                            # p-value <- 0.47 <- 정규분포가 맞다

summary(out)

# 사후 검정
# 각각의 두 집단의 데이터를 시차별로

acl0 <- subset(dflong, subset = (time == "month0"))
acl1 <- subset(dflong, subset = (time == "month1"))
acl3 <- subset(dflong, subset = (time == "month3"))
acl6 <- subset(dflong, subset = (time == "month6"))

acl0

#0.05/(4C2 = 6)
0.05/6

t.test(month ~ group, data = acl0)                  # p-value <- 0.807 <- 차이가 없다
t.test(month ~ group, data = acl1)                  # p-value <- 0.019 <- 차이가 없다.
t.test(month ~ group, data = acl3)                  # p-value <- 0.000 <- 차이가 있다.
t.test(month ~ group, data = acl6)                  # p-value <- 0.000 <- 차이가 있다.