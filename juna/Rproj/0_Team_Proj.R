install.packages("car")
library(car)


mulga <- read.csv("C:\\juna27\\Git\\data\\data1\\물가지수(품목별).csv", header=T, encoding = "EUC-KR")
mulga <- mulga[, -c(1, 2)]
#### 물가지수 ####
full.model <- lm(출산율 ~ . , data = mulga)
back.model <- step(full.model, direction = "backward", trace = 0)
back.model


fit <- lm(formula = 출산율 ~ 농축수산물 + 공업제품 + 공공서비스 + 개인서비스, 
          data = mulga)

summary(fit)
#Multiple R-squared:  0.9485,	Adjusted R-squared:  0.9473 
#농축수산물  -0.004325   0.001050  -4.117 5.96e-05 ***
#공업제품     0.014550   0.001756   8.287 3.25e-14 ***
#공공서비스   0.008610   0.002253   3.821 0.000186 ***
#개인서비스  -0.026925   0.001783 -15.100  < 2e-16 ***
shapiro.test(resid(fit))
#p-value = 0.4785
sqrt(vif(fit))

#####################################################################
## 개인서비스는 외식, 외식제외로 분류됨.
# 농축수산물과, 외식이 비슷한 품목으로 추측
# 결과는 농축수산물과 외식제외가 유사한 결과로 나왔음.

mulga2 <- read.csv("C:\\juna27\\Git\\data\\data1\\물가지수(품목별_외식).csv", header=T, encoding = "EUC-KR")
View(mulga2)
mulga2 <- mulga2[, -c(1, 2)]
View(mulga2)
#### 물가지수 ####
full.model <- lm(출산율 ~ . , data = mulga2)
back.model <- step(full.model, direction = "backward", trace = 0)
back.model


fit2 <- lm(formula = 출산율 ~ 농축수산물 + 공업제품 + 공공서비스 + 외식제외, 
           data = mulga2)

summary(fit2)
#Multiple R-squared:  0.9508,	Adjusted R-squared:  0.9496 
#농축수산물  -0.004438   0.001010  -4.393 1.96e-05 ***
#공업제품     0.009242   0.001629   5.675 5.83e-08 ***
#공공서비스   0.006797   0.002124   3.201  0.00163 ** 
#외식제외    -0.025435   0.001621 -15.691  < 2e-16 ***
shapiro.test(resid(fit2))
#p-value = 0.4785
sqrt(vif(fit2))

##########################################################

mulga3 <- read.csv("C:\\juna27\\Git\\data\\data1\\물가지수(단어_추출).csv", header=T, encoding = "EUC-KR")
View(mulga3)
mulga3 <- mulga3[, -c(1, 2)]
View(mulga3)
#### 물가지수 ####
full.model <- lm(출산율 ~ . , data = mulga3)
back.model <- step(full.model, direction = "backward", trace = 0)
back.model


fit3 <- lm(formula = 출산율 ~ 이유식 + TV + 휴대용멀티미디어기기 + 유아용학습교재 + 
             초등학교학습서 + 중학교학습서 + 고등학교학습서 + 아동화 + 
             반려동물용품 + 기타문구 + 필기구 + 보육시설이용료 + 요양시설이용료 + 
             반려동물관리비 + 노래방이용료 + 놀이시설이용료 + 영화관람료 + 
             공연예술관람료 + 관람시설이용료 + 문화강습료 + 온라인콘텐츠이용료 + 
             고등학생학원비 + 가정학습지 + 이러닝이용료 + 학교보충교육비 + 
             운동강습료 + 산후조리원이용료, data = mulga3)

summary(fit3)
#Multiple R-squared:  0.9508,	Adjusted R-squared:  0.9496 
#농축수산물  -0.004438   0.001010  -4.393 1.96e-05 ***
#공업제품     0.009242   0.001629   5.675 5.83e-08 ***
#공공서비스   0.006797   0.002124   3.201  0.00163 ** 
#외식제외    -0.025435   0.001621 -15.691  < 2e-16 ***
shapiro.test(resid(fit3))
#p-value = 0.4785
sqrt(vif(fit3))