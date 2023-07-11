mydata <- read.csv("C:/Users/acorn/TEAM_PROJECT/2023-04-19/merged_df.csv",
                   col.names  = c('pct_unmarried_30_34', "birth_rate"))
View(mydata)
str(mydata)

model <- lm(birth_rate ~ pct_unmarried_30_34, data =mydata)


png("console_output.png")
summary(model)
dev.copy(png, "console_output.png")

dev.off()


