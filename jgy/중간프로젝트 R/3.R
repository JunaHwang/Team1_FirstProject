final1 <- read.csv("../data/시도별합계출산율_final.csv", header = T)

View(final1)

out <- aov(합계출산율2 ~ 분기, final1)


shapiro.test(resid(out))
interaction.plot(final1$분기, final1$구별, final1$합계출산율2)
bartlett.test(합계출산율2 ~ 분기, final1)


#######################################################

oneway.test(합계출산율2 ~ 분기, final1, var.equal=F) # 인자만 바꿔주면 됨,

#install.packages("nparcomp")
library(nparcomp)

result <- mctp(합계출산율2 ~ 분기, final1)
summary(result)

0.05/4
