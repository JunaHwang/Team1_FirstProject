library(dplyr)
library(tidyr)
library(reshape2)

tfr1 <- read.csv("../data/분기별합계출산율_final.csv", header=T)

View(tfr1)

tfrlong <- melt(tfr1, id = c("연도", "구별"),
                variable.name = "quarter",
                value.name = "tfr",
                measure.vars = c("X1","X2","X3","X4"))

View(tfrlong)


#out <- aov(tfr ~ 구별 + quarter + 구별:quarter, data = tfrlong)


# shapiro.test(resid(out))   # 정규분포 아님

# summary(out)   # 차이가 있다. 격렬하게

acl1 <- subset(tfrlong, subset = (quarter == "X1"))
acl2 <- subset(tfrlong, subset = (quarter == "X2"))
acl3 <- subset(tfrlong, subset = (quarter == "X3"))
acl4 <- subset(tfrlong, subset = (quarter == "X4"))


# t-test 못함, MWW 해야함

out <- aov(tfr ~ quarter, tfrlong)

interaction.plot(tfrlong$quarter, tfrlong$구별, tfrlong$tfr)
shapiro.test(resid(out))
bartlett.test(tfr ~ quarter, tfrlong)
summary(out)
TukeyHSD(out)



