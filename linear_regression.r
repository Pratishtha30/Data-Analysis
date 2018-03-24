# Linear regression

rm(list=ls())
library(foreign)
crimes.df <- read.dta("http://www.ats.ucla.edu/stat/data/crime.dta")
# Linear model 1!
# We are going to use poverty to predict crime!

poverty.model <- lm(crime ~ poverty, data=crimes.df)
summary(poverty.model)
plot(crimes.df$crime~crimes.df$poverty)
abline(poverty.model, col = 'red')
grid()
# Multiple Regression = More than one predicting variable
pov.single.model <- lm(crime ~ poverty + single, data = crimes.df)
summary(pov.single.model)

# Let's say that we want to predict the crime level, !
# for new poverty and single levels.!
new.data <- data.frame(poverty=c(8.0,12.0, 12.0),single=c(10,10,20)) 
# PREDICTING USING MODEL 1!
#What are the 95% confidence intervals for the new.data?!
predict(pov.single.model, new.data, interval="confidence")


plot(pov.single.model)
plot(pov.single.model, which =1)
