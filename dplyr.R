
# # Using dplyr to group, manipulate and summarize data
# #The package dplyr provides a well structured set of functions 
# for manipulating such data collections and performing typical 
# operations with standard syntax that makes them easier to remember. 
# It is also very fast, even with large collections. 
# To increase it's applicability, 
# the functions work with connections to databases as well as 
# data.frames

# As a data source to illustrate properties with we'll 
# use the flights data that we're already familiar with

library(dplyr)
library(hflights)
str(hflights)
head(hflights)

#Basic manipulations of data
# dplyr has five basic function
# 1. filter
# 2. arrange
# 3. select
# 4. mutate
# 5 summarize

f_df <- filter(hflights, Month == 1, UniqueCarrier == "AA")
head(f_df)

# #Here we got the January flights for AA. This is like 
# subset but the syntax is a little different. We don't need &; 
# it is added to comma separated conditions. 
# For an "or" you add | explicitly.

f_df_or<-filter(hflights, UniqueCarrier == "AA" | UniqueCarrier == "UA")
head(f_df_or)

#arrange
#This function reorders the data based on specified columns.

f_df_arrange<-arrange(hflights_df, Month, DayofMonth, desc(AirTime))

# can be done with order but the syntax is much harder

#select
#This works like the select option to subset.

f_df_select<-select(hflights, Year:DayOfWeek, TailNum, ActualElapsedTime)
head(f_df_select)

# mutate
# This adds new columns, often computed on old ones. 
# But you can refer to new coilumns you just created

f_df_mutate<-mutate(hflights, gain = ArrDelay - DepDelay, gain_per_hour = gain/(AirTime/60))
head(f_df_mutate)


# summarize
# This produces a summary statistic, 
# which when computed on the un-grouped data isn't very interesting.
f_df_summarize<-summarize(hflights, delay = mean(ArrDelay, na.rm = T))

# Grouping
# A major strength of dplyr is the ability to group the data by a 
# variable or variables and then operate on the data "by group". 
# With plyr you can do much the same using the ddply function or 
# it's relatives, dlply and daply. However, there are advantages 
# to having grouped data as an object in its own right.

# Problem: Compute mean arrival delay by plane, 
# along with other useful data.
#First create a version of the data grouped by plane.

planes <- group_by(hflights, TailNum)

#The information we want are summary statistics by plane. 
#Just use the summarize function.

delay2 <- summarize(planes, count = n(), dist = mean(Distance, na.rm = T), delay = mean(ArrDelay, 
                                                                                        na.rm = T))
# aggregate functions
# The function n() is one of several aggregate functions that 
# are useful to employ with summarise on grouped data. 
# Besides the typical ones like mean, max, etc., 
# there are also n_distinct, first, last, nth().

destinations <- group_by(hflights, Dest)
f_df_aggregate<-summarise(destinations, planes = n_distinct(TailNum), flights = n())
head(f_df_aggregate)

# Grouping by multiple variables
# When we do this we have the ability to easily compute 
# summary stats by different combinations of the grouping variables.
# 
# Suppose we group the data into daily flights.

daily <- group_by(hflights, Year, Month, DayofMonth)
# To get the number of flights per day
per_day <- summarize(daily, number_flights = n())
head(per_day)

# 
# We have access to each of the grouping variables. 
# Notice that in the summary data.frame, 
# we have Year and Month as grouping variables. 
# We can get the number of flights per month by summarizing as follows 

per_month <- summarize(per_day, number_flights = sum(number_flights))
head(per_month)


# Chaining
# 
# There is a nice way to pass the result of one function to another. 
# This is possible because so many dplyr functions take a data 
# table as input and output another data table.

# For example:
  
a1 <- group_by(hflights, Year, Month, DayofMonth)
a2 <- select(a1, Year:DayofMonth, ArrDelay, DepDelay)
a3 <- summarise(a2, arr = mean(ArrDelay, na.rm = TRUE), dep = mean(DepDelay,na.rm = TRUE))
a4 <- filter(a3, arr > 30 | dep > 30)
hflights %>% group_by(Year, Month, DayofMonth) %>% #piping operation
  select(Year:DayofMonth, ArrDelay, DepDelay) %>% 
  summarise(arr = mean(ArrDelay, na.rm = TRUE), dep = mean(DepDelay,na.rm = TRUE)) %>% filter(arr > 30 | dep > 30)                                                                                                   
