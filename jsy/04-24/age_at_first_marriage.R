install.packages("readxl")
library(readxl)
mydata <- read_excel("C:/Users/acorn/TEAM_PROJECT/2023-04-21 - 복사본/jsy/df6.xlsx")
mydata
dfw <- as.data.frame(mydata)
dfw
mydata <- read_excel("C:/Users/acorn/TEAM_PROJECT/2023-04-21 - 복사본/jsy/df7.xlsx")
dfh <- as.data.frame(mydata)

dfh


# Fit a cubic regression model to the data
model <- lm(dfw$`합계출산율` ~ poly(dfw$`아내 초혼연령`, 3), data = dfw)
model2 <- lm(dfh$`합계출산율` ~ poly(dfh$`남편 초혼연령`, 3), data = dfw)


######초혼연령 출산율 ######



plot(dfw$`아내 초혼연령`, dfw$합계출산율, main = "아내 초혼연령 vs 합계출산율")
lines(dfw$`아내 초혼연령`, predict(model), col = "red", lwd = 2)

# class(dfw$`아내 초혼연령`)
# class(dfw$`합계출산율`)


plot(dfh$`남편 초혼연령`, dfh$합계출산율, main = "남편 초혼연령 vs 합계출산율")
lines(dfh$`남편 초혼연령`, predict(model2), col = "blue", lwd = 2)


summary(model)
summary(model2)




## change column names
names(dfh)[names(dfh) == "남편 초혼연령"] <- "초혼연령"
names(dfw)[names(dfw) == "아내 초혼연령"] <- "초혼연령"

View(dfh)
View(dfw)

dfw$gender <- rep("F", nrow(dfw))
dfh$gender <- rep("M", nrow(dfh))

View(dfh)
View(dfw)





## rbind

df <- rbind(dfh, dfw)

View(df)

out <- aov(초혼연령 ~ gender, data = df)

shapiro.test(resid(out))

summary(out)


oneway.test(초혼연령 ~ gender, df, var.equal = T)  # p-value < 2.2e-16

kruskal.test(합계출산율 ~ 초혼연령, data = df) # p-value = 0.0006573








