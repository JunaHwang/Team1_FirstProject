library(readxl)


unm_deb <- read.csv("C:/Users/acorn/TEAM_PROJECT/2023-04-20/mer_unm_deb.csv")

View(unm_deb)
str(unm_deb)
# rename the column names

colnames(unm_deb) <- c("year", "unmarried_ratio", "avg_debt_under30")

print(colnames(unm_deb))

View(unm_deb)

cor.test(unm_deb$unmarried_ratio, unm_deb$avg_debt_under30, method = "pearson")


# Pearson's product-moment correlation
# 
# data:  unm_deb$unmarried_ratio and unm_deb$avg_debt_under30
# t = 8.0987, df = 8, p-value = 3.997e-05
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
#  0.7753167 0.9870103
# sample estimates:
#       cor 
# 0.9440807 



