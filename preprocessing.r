# The data set used is iris swhich is in  R 
str(iris)
names(iris)
head(iris)
nrow(iris)
table(iris$Species)

# Single variable Frequency plot

hist(iris$Sepal.Length, breaks = 10, prob = T)

#plot the density curve
lines(density(iris$Sepal.Length))

# For category data, bar plot is a good choice
categories <- table(iris$Species)
barplot(categories, col = c("red", "green", "blue"))

# Two variable plot
# Box plot can be used to visualize teh distribution of a numeric
# value across different categories

boxplot(Sepal.Length~Species, data = iris)

# scatter plot for all pairs
pairs(iris[, c(1,2,3,4)])
 # compute the correlation matrix
cor(iris[,c(1,2,3,4)])


# we can further drill down by analyzing the relatioship between two
# numeric value by fitting a regression line or  regression curve

# First plot the 2 variables
 plot(Petal.Width~Sepal.Length, data=iris)
# Learn the regression model
model <- lm(Petal.Width~Sepal.Length, data=iris)
# Plot the regression line
abline(model)
# Now learn the local linear model
model2 <- lowess(iris$Petal.Width~iris$Sepal.Length)
lines(model2, col="red")


# Prepare training data

# If the amount of raw data is huge, processing all of them 
# may require an extensive amount of processing power which 
# may not be practical.  In this case it is quite common to 
# sample the input data to reduce the size of data that need 
# to be processed.
# 
# There are many sampling models.  Random sampling is by far 
# the most common model which assign a uniform probability to 
# each record for being picked.  On the other hand, stratified 
# sampling allows different probability to be assigned to 
# different record type.  It is very useful in case of highly 
# unbalanced class occurrence so that the high frequency class 
# will be down-sampled.  Cluster sampling is about sampling at 
# a higher level of granularity (ie the cluster) and then pick 
# all members within that cluster.  An example of cluster 
# sampling is to select family (rather than individuals) to 
# conduct a survey.
# 
# Sample can also be done without replacement (each record 
# can be picked at most once) or with replacement (same 
# record can be picked more than once)

# select 10 records out from iris with replacement
index <- sample(1:nrow(iris), 10, replace=T)
index
irissample <- iris[index,]
irissample

#Not a Number
# Understanding NaN

Inf/Inf #one way to create NaN
x <- 4/0
x/x
class(x)
class(x/x) #Note the type. Not a number is also of type numeric

# To determine if a value is missing (NA) use is.na. Thsi si useful for finidng missing values
# and removing them, or doing something else with them.
x <- c(1,5,7,NA,6)
is.na(x)
#But some functions do not tolerate missing values.
mean(x)
mean(x, na.rm=TRUE)

#To get the number of missing values in a vector,
sum(is.na(x))


#' Understanding NA's 
#' 
x <- c(3,4, NA, 6)
x
x[3]
class(x[3]) #numeric
is.na(x)
na.omit(x)


#Start by creating a matrix with missing data:
h=matrix(c(NA,3,1,7,-8,NA), nrow=3,ncol =2, byrow=TRUE); h

#To see if any of the elements of a vector are missing useis.na():
is.na(h)

#To obtain the element number of 
#the matrix of the missing value(s), use which() and is.na():
which(is.na(h))
#
#To keep only the rows without missing value(s), use na.omit()

na.omit(h)

#There are other ways to handle missing values. 
#See ?na.action.

# Dealing with missing values
# two aspects removing the data or data impetus

airquality$Ozone #make sure that we do see some NA's

#First, run is.na() on the column.
is.na(airquality$Ozone)

#How many Ozone values are NA?
sum(is.na(airquality$Ozone))

#Shortcut. Simply use summary()
summary(airquality) #Notice that Summary tells us how many NA's there are

#Print ROWS that DON'T have an NA for Ozone
airquality[!is.na(airquality$Ozone) , ]

#But wait, airquality$Solar.R has NA's too.
na.omit(airquality)

# USING COMPLETE CASES
airquality[complete.cases(airquality), ]

#Finally, let's convert these NA's to 0s
#Note this is not always a good idea. 0s are very different from NA's
tf <- is.na(airquality$Solar.R) # TRUE FALSE conditional vector
airquality$Solar.R[tf] <- 0
summary(airquality)

# 
# Impute missing data
# It is quite common that some of the input records are 
# incomplete in the sense that certain fields are missing or 
# have input error.  In a typical tabular data format, we need 
# to validate each record contains the same number of fields 
# and each field contains the data type we expect.
# 
# In case the record has some fields missing, we have the 
# following choices
# Discard the whole record if it is incomplete
# Infer the missing value based on the data from other records.  
# A common approach is to fill the missing data with the average, 
# or the median.


# Create some missing data
irissample[10, 1] <- NA
irissample

library(e1071) 
fixIris1 <- impute(irissample[,1:4], what='mean')
fixIris1
fixIris2 <- impute(irissample[,1:4], what='median')
fixIris2

# Transfromation of Data 
#Normalize numeric value
# Normalize data is about transforming numeric data into a 
# uniform range.  Numeric attribute can have different 
# magnitude based on different measurement units.  To compare
# numeric attributes at the same scale, we need to normalize 
# data by subtracting their average and then divide by the 
# standard deviation.

# scale the columns
# x-mean(x)/standard deviation
scaleiris <- scale(iris[, 1:4])
head(scaleiris)

# min max nomalization

minmaxnor<-function(x){
  data_nor = (x-min(x))/(max(x)-min(x))
  return(data_nor)
}

minmaxnor(iris[,1:4])

# Add derived attributes
# In some cases, we may need to compute 
# additional attributes from existing attributes.

iris2 <- transform(iris, ratio=round(Sepal.Length/Sepal.Width, 2))
head(iris2)

# Discretize numeric value into categories
# Discretize data is about cutting a 
# continuous value into ranges and assigning the numeric 
# with the corresponding bucket of the range it falls on.  
# For numeric attribute, a common way to generalize it is to 
# discretize it into ranges, which can be either 
# constant width (variable height/frequency) or variable 
# width (constant height).

> # Equal width cuts
segments <- 10
maxL <- max(iris$Petal.Length)
minL <- min(iris$Petal.Length)
theBreaks <- seq(minL, maxL, by=(maxL-minL)/segments)
cutPetalLength <- cut(iris$Petal.Length, breaks=theBreaks, include.lowest=T)
newdata <- data.frame(orig.Petal.Len=iris$Petal.Length, cut.Petal.Len=cutPetalLength)
head(newdata)

# Constant frequency / height
myBreaks <- quantile(iris$Petal.Length, probs=seq(0,1,1/segments))
cutPetalLength2 <- cut(iris$Petal.Length, breaks=myBreaks,include.lowest=T)
newdata2 <- data.frame(orig.Petal.Len=iris$Petal.Length, cut.Petal.Len=cutPetalLength2)
head(newdata2)

# Binarize categorical attributes
# Certain machine learning models 
# only take binary input (or numeric input).  In this case, 
# we need to convert categorical attribute into multiple 
# binary attributes, while each binary attribute corresponds 
# to a particular value of the category.  
# (e.g. sunny/rainy/cloudy can be encoded as sunny == 100 
#  and rainy == 010)

cat <- levels(iris$Species)
cat
binarize <- function(x) {return(iris$Species == x)}
newcols <- sapply(cat, binarize)
colnames(newcols) <- cat
data <- cbind(iris[,c('Species')], newcols)
data[45:55,]

# Select, combine, aggregate data
# Designing the form of training data in my opinion is 
# the most important part of the whole predictive modeling 
# exercise because the accuracy largely depends on whether 
# the input features are structured in an appropriate form 
# that provide strong signals to the learning algorithm.
# 
# Rather than using the raw data as is, it is quite common 
# that multiple pieces of raw data need to be combined 
# together, or aggregating multiple raw data records along 
# some dimensions.
# 
# In this section, lets use a different data source CO2, 
# which provides the carbon dioxide uptake in grass plants.

head(CO2)
data <- CO2[CO2$conc>400 & CO2$uptake>40,]
head(data)

# ascend sort on conc, descend sort on uptake
CO2[order(CO2$conc, -CO2$uptake),][1:20,]

# To look at each plant rather than each raw record, 
# lets compute the average uptake per plant.

aggregate(CO2[,c('uptake')], data.frame(CO2$Plant), mean)

# We can also group by the combination of type and treatment 

aggregate(CO2[,c('conc', 'uptake')],data.frame(CO2$Type, CO2$Treatment), mean)


#To join multiple data sources by a common key, we can use the merge() function

state <- c('California', 'Mississippi', 'Fujian','Shandong', 'Quebec', 'Ontario')
country <- c('USA', 'USA', 'China', 'China', 'Canada', 'Canada')
geomap <- data.frame(country=country, state=state)
geomap

# Need to match the column name in join
colnames(geomap) <- c('country', 'Type')
joinCO2 <- merge(CO2, countrystate, by=c('Type'))
head(joinCO2)

########################
#AGGREGATE
########################

#---- 
# Aggregate WITHOUT USING THE FORMULA SYNTAX
# You can also use aggregate without the formula syntax.
# Here are some examples.

aggregate(airquality, by=list(airquality$Month), FUN=mean)
aggregate(airquality, by=list(airquality$Month), FUN=mean, na.rm=TRUE)
aggregate(airquality, by=list(airquality$Month, airquality$Day), FUN=mean, na.rm=TRUE)

#BONUS Example
aggregate(state.x77, list(Region = state.region), mean)


#-----
# USING FORUMLA SYNTAX
#------

aggregate(data=airquality, Ozone~Month, mean)
aggregate(data=airquality, Ozone~Month+Day, mean)

#use cbind if you want to aggregate more than one variable
aggregate(data=airquality, cbind(Ozone,Wind)~Month+Day, mean)

#Bonus Example: IRIS DATA SET
aggregate(. ~Species, data=iris, FUN='length')
aggregate(Sepal.Length ~ Species, data=iris, FUN='length') 
aggregate(Species ~ Sepal.Length, data=iris, FUN='length') #this is NOT what we want

aggregate(Sepal.Length ~ Species, data=iris, FUN='mean') 



#--------------------------------
# A P P L Y Family of Functions
#-------------------------------

apply(mtcars, 1, max) #take each row of mtcars, and find its max value.

apply(iris[,1:4], 1, mean) #caution: This is just for illustration.
#taking the mean of a bunch of different columns usually doesn't make mathematical sense.

#applying functions to columns
apply(mtcars, 2, summary)


summary(movies)

# L A P P L Y

lst <- list(1,"abc", 1.3, TRUE)
listClasses <- lapply(lst, class)
listClasses

#--- SAPPLY might be even better 
#--- understand the difference between the two commands:
lClasses <- lapply(lst, class)
sClasses <- sapply(lst,class)
str(lClasses)
str(sClasses)


lClasses <- lapply(mtcars, mean)
sClasses <- sapply(mtcars,mean)
str(lClasses)
str(sClasses)



lapply(airquality$Ozone, round)
sapply(airquality$Ozone, round)

sapply(airquality, max)
head(airquality)


#-------BY------------
# Notice the contrast when using BY
# By is a "group by" for different factors
by(iris[, 1:4], Species, colMeans)


# L A P P L Y

l <- lapply(iris, class)
s <- sapply(iris,class)

lapply(airquality$Ozone, round)
sapply(airquality$Ozone, round)

sapply(airquality, max)
head(airquality)


# T A P P L Y

#hts of 10 people 
heights <- c(177, 153, 133, 121, 164, 161, 127, 122, 180, 161, 131, 128)
groupIndex <- c("Male", "Woman", "Child", "Child","Male", "Woman", "Child", "Child","Male", "Woman", "Child", "Child")
#IMPORTANT: heights and index should be of the same length. 
# Each element of the vector should have an group identified in the Index vector.
tapply(heights, groupIndex, mean)



gdp <- read.csv("~/data/countries_wide.csv") #replace this with the right path for your file
str(gdp)
tapply(gdp$POP, gdp$country.isocode, mean)
tapply(gdp$POP, list(gdp$country.isocode,gdp$year), mean)




############
# D D P L Y 
############
library(plyr)
#Let's use the in-built Titanic dataset to understand ddply
#what does ddply do?
# DDPLY: For each subset of a data frame, apply function then combine results into a data frame

str(Titanic)
titanic <- as.data.frame(Titanic)
titanic
ddply(titanic, .(Class), summarize, Total=sum(Freq))
ddply(titanic, .(Class, Survived), summarize, Total=sum(Freq))
ddply(titanic, .(Sex, Survived), summarize, Total=sum(Freq))
ddply(titanic, .(Class, Sex, Survived), summarize, Total=sum(Freq))


str(titanic)



## M E R G E
x <- data.frame(hrs=c(3,4,7), values=1:3)
x
We want to fill in all missing hrs from 1 to 10, and fill in the value 0 for those.
allhours <- data.frame(hours=1:10) 
allhours

merge(x, allhours, all=T, by.y="hours", by.x="hrs")
df <- merge(x, allhours, all.y=TRUE, by=c("hrs"))
df # convert the NA to 0
df$values[is.na(df$values)] <- 0
df

### TIDY DATA
##  RESHAPING
############

str(iris)
iris
dim(iris)
names(iris)
library(reshape2)

m.iris <- melt(iris)
names(m.iris)
dcast(m.iris, Species~variable)

m.iris <- melt(data=iris, id.var="Species")
#Once you melt it this way, no way to "remember" which rows came from where.

#need a row ID
iris$id <- row.names(iris)
irislong <- melt(iris, c("Species", "id"))
dcast(irislong, Species+id~variable)

gdp
melt(gdp)
m.gdp <- melt(gdp, id.vars=c("country","country.isocode", "year"))
names(m.gdp)
dcast(m.gdp, country.isocode+year ~ variable)

# 
# Power and Log transformation
# A large portion of machine learning models are based on 
# assumption of linearity relationship (ie: the output is 
# linearly dependent on the input), as well as normal 
# distribution of error with constant standard deviation.  
# However the reality is not exactly align with this 
# assumption in many cases.
# 
# In order to use these machine models effectively, it is 
# common practice to perform transformation on the input or 
# output variable such that it approximates normal 
# distribution (and in a multi-variate case, multi-normal 
# distribution).
# 
# The commonly use transformation is a class call Box-Cox 
# transformation which is to transform a variable x to 
# (x^k - 1) / k  where k is a parameter that we need to 
# determine.  (when k = 2, this is a square transform, when 
# k = 0.5, this is a square root transform, when k = 0, this 
# will become log y, when k = 1, there is no transform)
# 
# Here is how we determine what k should be 
# for input variable x and then transform the variable.

# Use the data set Prestige
library(car)
library(rgl)   # 3d plot
names(Prestige)
head(Prestige)

plot(density(Prestige$income))
qqnorm(Prestige$income)
qqline(Prestige$income)
summary(box.cox.powers(cbind(Prestige$income)))

transformdata <- box.cox(Prestige$income, 0.18)
plot(density(transformdata))
qqnorm(transformdata)
qqline(transformdata)