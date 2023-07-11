#### 20-29 Debt _ 30_34 unm_ratio analy ####

library(readxl)

unm_deb <- read.csv("C:/Users/acorn/TEAM_PROJECT/2023-04-20/jsy/04-20/mer_unm_deb.csv")

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





#####  30_39 Debt _ 40_44 unm_ratio ####

unm <- read.csv("C:/Users/acorn/TEAM_PROJECT/2023-04-21/40_44_ratio.csv")

unm
# # Create a scatter plot of the data
plot(x = unm$시점, y =unm$ratio)

# # Fit a polynomial regression model with degree 2
model <- lm(ratio ~ poly(시점, 2), data = unm)
 
# # Add the fitted curve to the scatter plot
lines(sort(unm$시점), fitted(model)[order(unm$시점)])

summary(model)


# Create a sequence of years from 2012 to 2021
years <- seq(2012, 2021, by = 1)


# Use the predict() function to get the predicted y values for each year
predicted_y <- predict(model, newdata = data.frame(시점 = years))


# Print the predicted y values for each year
print(predicted_y)

str(predicted_y)
names(predicted_y) <- 2012:2021

df_predicted_y <- as.data.frame(predicted_y)
df_predicted_y


debt <- read.csv('C:/Users/acorn/TEAM_PROJECT/2023-04-19/jsy/2012-2022_debt_2030.csv'
                 , header = TRUE, skip =1, row.names = 1, check.names = FALSE)


View(debt)


debt_30_39 <- subset(debt, row.names(debt) == "30-39세")


View(debt_30_39)

debt_cols <- debt_30_39[, colnames(debt_30_39) %in% as.character(2012:2021)]

debt_cols

str(debt_cols)

View(df_merged)
View(df_predicted_y)
View(debt_cols)

debt_cols<- t(debt_cols)


df_merged <- merge(df_predicted_y, debt_cols, by ="row.names")
View(df_merged)
names(df_merged) <- c("year", "pred_unm_ratio", "debt_30_39")
df_merged

plot(x = df_merged$debt_30_39, y = df_merged$pred_unm_ratio, main ="title")


result <- cor.test(df_merged$pred_unm_ratio, df_merged$debt_30_39, method = 'pearson')


print(result)








##### plot two graphs together#####


library(ggplot2)

p <- ggplot() + 
  geom_point(data = unm_deb, aes(x = avg_debt_under30, y=unmarried_ratio ), color = "red") +
  geom_point(data = df_merged, aes(x =  debt_30_39, y = pred_unm_ratio), color = "blue") +
  
  xlab("average debt") +
  ylab("unmarried ratio") +
  ggtitle("Scatter Plot of Unmarried Ratio vs. Average Debt") 

p


## 30대 미만은 부채가 늘수록 미혼자 비율은 더 가파르게 증가
## 30-39세 는 부채가 늘수록 미혼자 비율은 덜 가파르게 증가.
# 부채가 늘어도 미혼율 증가에 영향 미미
## 30대 미만의 부채를 집중적으로 공략해야 됨



##### Linear Regression Model #####
model_20_29 <- lm(unmarried_ratio ~ avg_debt_under30, data = unm_deb)

model_30_39 <- lm(pred_unm_ratio ~ debt_30_39, data = df_merged)


# Obtain the regression coefficients and their standard errors for each group
coef_20_29 <- coef(summary(model_20_29))
coef_30_39 <- coef(summary(model_30_39))

# Examine the regression output for each group
summary(model_20_29)
summary(model_30_39)



# Plot the scatter plot and regression lines for each group
plot(unm_deb$avg_debt_under30, unm_deb$unmarried_ratio, col = "red", xlab = "Average Debt", ylab = "Unmarried Ratio", main = "20-29 Age Group")
abline(model_20_29, col = "red")


plot(df_merged$debt_30_39, df_merged$pred_unm_ratio, col = "blue", xlab = "Average Debt", ylab = "Unmarried Ratio", main = "30-39 Age Group")
abline(model_30_39, col = "blue")



p <- ggplot() + 
  geom_point(data = unm_deb, aes(x = avg_debt_under30, y=unmarried_ratio ), color = "red") +
  geom_point(data = df_merged, aes(x =  debt_30_39, y = pred_unm_ratio), color = "blue") +
  
  xlab("average debt") +
  ylab("unmarried ratio") +
  ggtitle("Scatter Plot of Unmarried Ratio vs. Average Debt") +
  
  geom_smooth(data = unm_deb, aes(x = avg_debt_under30, y = unmarried_ratio), method = "lm", color = "red") +
  geom_smooth(data = df_merged, aes(x = debt_30_39, y = pred_unm_ratio), method = "lm", color = "blue")

p








##### t-test to see if there is a significant difference between the two.#######



# Obtain the estimated slope coefficients and their standard errors for each group
slope_20_29 <- coef(model_20_29)[2]
slope_30_39 <- coef(model_30_39)[2]
se_slope_20_29 <- coef(summary(model_20_29))[2, 2]
se_slope_30_39 <- coef(summary(model_30_39))[2, 2]

slope_20_29
se_slope_20_29


# Calculate the standard error of the difference between the two slopes
SE_diff <- sqrt(se_slope_20_29^2 + se_slope_30_39^2)
SE_diff


# Calculate the t-statistic for the difference between the two slopes
t_stat <- (slope_20_29 - slope_30_39) / SE_diff

# Calculate the degrees of freedom for the t-test
df <- nrow(unm_deb) + nrow(df_merged) - 2



# Calculate the p-value for the t-test
p_value <- 2 * pt(abs(t_stat), df = df, lower.tail = FALSE)

# Print the results
cat("t-statistic:", t_stat, "\n")
cat("Degrees of freedom:", df, "\n")
cat("p-value:", p_value, "\n")

# Compare the p-value to the level of significance (e.g., 0.05) to determine significance
if (p_value < 0.05) {
  cat("The slopes are significantly different between the two age groups\n")
} else {
  cat("There is not enough evidence to suggest that the slopes are different between the two age groups\n")
}

















##### ANOVA TEST #######



# Fitting linear models for each dataset
model1 <- lm(unmarried_ratio ~ avg_debt_under30, data = unm_deb)
model2 <- lm(pred_unm_ratio ~ debt_30_39, data = df_merged)


unm_deb

df_merged

# Calculating ANOVA table
anova_table <- anova(model1, model2)

# Displaying ANOVA table
anova_table



df_merged$year <- as.integer(df_merged$year)

str(df_merged)


merged_data <- merge(unm_deb, df_merged, by = 'year')


merged_data

new_colnames <- c("year", "ratio", "debt")
colnames(unm_deb) <- new_colnames


unm_deb


new_colnames <- c("year", "ratio", "debt")
colnames(df_merged) <- new_colnames
df_merged




str(unm_deb)
str(df_merged)


# combine dataframes by row using rbind
combined_df <- rbind(unm_deb, df_merged)
combined_df


## example
# y <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20)
# x <- c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19)
# age_group <- factor(rep(c("20-29", "30-39"), each = 10))
# data <- data.frame(y, x, age_group)
# 
# str(age_group)
# str(data)


combined_df$age_group <- age_group
combined_df
str(combined_df)

model <- lm(ratio ~ debt * age_group, data = combined_df)
anova(model)
summary(model)
















