# Line Charts


# Define the x vector with 5 values
x <- c(3, 7, 4, 12, 19)
# Graph the cars vector with all defaults
plot(x)

grid()
#Let's add a title, a line to connect the points, and some color:

plot(x, type="o", col="blue")
grid()
#Create a title with a red, bold/italic font
title(main="Autos", col.main="red", font.main=4)

#Now let's add a red line for trucks and specify the y-axis range directly so it will be large enough to fit the truck data:
x <- c(1, 3, 6, 4, 9)
y <- c(2, 5, 4, 5, 12)

# Graph cars using a y axis that ranges from 0 to 12
plot(x, type="o", col="blue", ylim=c(0,12))

# Graph trucks with red dashed line and square points
lines(y, type="o", pch=22, lty=2, col="red")

# Create a title with a red, bold/italic font
title(main="Autos", col.main="red", font.main=4)
grid()
#Next let's change the axes labels to match our data and add a legend. 
#We'll also compute the y-axis values using the max function so any 
#changes to our data will be automatically reflected in our graph.

# Define 2 vectors
x <- c(1, 3, 6, 4, 9)
y <- c(2, 5, 4, 5, 12)

# Calculate range from 0 to max value of cars and trucks
g_range <- range(0, x, y)

# Graph autos using y axis that ranges from 0 to max 
# value in cars or trucks vector.  Turn off axes and 
# annotations (axis labels) so we can specify them ourself
plot(x, type="o", col="blue", ylim=g_range, axes=FALSE, ann=FALSE)

# Make x axis using Mon-Fri labels
axis(1, at=1:5, lab=c("Mon","Tue","Wed","Thu","Fri"))

# Make y axis with horizontal labels that display ticks at 
# every 4 marks. 4*0:g_range[2] is equivalent to c(0,4,8,12).
axis(2, las=1, at=4*0:g_range[2])

# Create box around plot
box()

# Graph trucks with red dashed line and square points
lines(y, type="o", pch=22, lty=2, col="red")

# Create a title with a red, bold/italic font
title(main="Autos", col.main="red", font.main=4)

# Label the x and y axes with dark green text
title(xlab="Days", col.lab=rgb(0,0.5,0))
title(ylab="Total", col.lab=rgb(0,0.5,0))

# Create a legend at (1, g_range[2]) that is slightly smaller 
# (cex) and uses the same line colors and points used by 
# the actual plots 
legend(1, g_range[2], c("cars","trucks"), cex=0.8, col=c("blue","red"), pch=21:22, lty=1:2);

# BAR CHARTS

# Define the cars vector with 5 values
x <- c(1, 3, 6, 4, 9)

# Graph cars
barplot(x)

# Read values from tab-delimited autos.dat 
autos_data <- read.csv("/Users/home/Desktop/30211_DATA_ANALYSIS/LECTURE/auto.csv", header=T)

# Graph cars with specified labels for axes.  Use blue 
# borders and diagnal lines in bars.
barplot(autos_data$cars, main="Cars", xlab="Days",  ylab="Total", names.arg=c("Mon","Tue","Wed","Thu","Fri"), border="blue", density=c(10,20,30,40,50))


# Graph autos with adjacent bars using rainbow colors
barplot(as.matrix(autos_data), main="Autos", ylab= "Total",beside=TRUE, col=rainbow(5))

# Place the legend at the top-left corner with no frame  
# using rainbow colors
legend("topleft", c("Mon","Tue","Wed","Thu","Fri"), cex=0.6, bty="n", fill=rainbow(5));

# Expand right side of clipping rect to make room for the legend
par(xpd=T, mar=par()$mar+c(0,0,0,4))

# Graph autos (transposing the matrix) using heat colors,  
# put 10% of the space between each bar, and make labels  
# smaller with horizontal y-axis labels
barplot(t(autos_data), main="Autos", ylab="Total", col=heat.colors(3), space=0.1, cex.axis=0.8, las=1,names.arg=c("Mon","Tue","Wed","Thu","Fri"), cex=0.8) 

# Place the legend at (6,30) using heat colors
legend(6, 30, names(autos_data), cex=0.8, fill=heat.colors(3));

# Restore default clipping rect
par(mar=c(5, 4, 4, 2) + 0.1)

# HISTOGRAM

# Concatenate the three vectors
autos <- c(autos_data$cars, autos_data$trucks, autos_data$suvs)

# Create a histogram for autos in light blue with the y axis
# ranging from 0-10
hist(autos, col="lightblue", ylim=c(0,10))


# PIE CHART
# Create a pie chart with defined heading and
# custom colors and labels

# Define cars vector with 5 values
cars <- c(1, 3, 6, 4, 9)

# Define some colors ideal for black & white print
colors <- c("white","grey70","grey90","grey50","black")

# Calculate the percentage for each day, rounded to one 
# decimal place
car_labels <- round(cars/sum(cars) * 100, 1)

# Concatenate a '%' char after each value
car_labels <- paste(car_labels, "%", sep="")

# Create a pie chart with defined heading and custom colors
# and labels
pie(cars, main="Cars", col=colors, labels=car_labels,cex=0.8)

# Create a legend at the right   
legend(1.5, 0.5, c("Mon","Tue","Wed","Thu","Fri"), cex=0.8, fill = colors)


# Create a dotchart for autos
dotchart(t(autos_data))


# view the current settings
par()
# save the current settings in the variable old.par
old.par <- par()

# change the color of the main title to red
par(col.main="red")
# load the airquality dataset
data(airquality)
# create a histogram with the new settings
 hist(airquality$Ozone)
# restore the original settings
par(old.par)

#Another way of getting the same results is by specifying the 
#graphical parameter within the plotting function:
# create a histogram with red title
hist(airquality$Ozone, col.main="red")
#Note that, in this case, the original parameters were not modified. 
#Thus, there is no need of saving the original configuration. 
#In this case, the new option is valid only for this specific graph.

#Changing text size
#Some of the parameters responsible for controlling text size in graphs are:
#   cex: magnification of plotting text and symbols
# 1 = default, 1.5 = 50% larger, 0.5 = 50% smaller cex.lab: 
#magnification of x and y labels relative to cex cex.main: 
#magnification of titles relative to cex
# 1 # plot with the original text sizes
 plot(Ozone~Wind,data=airquality ,main="Ozone vs. Wind")
 # create a plot with modified text sizes
plot(Ozone~Wind,data=airquality ,main="Ozone vs. Wind",cex.main = 2,cex.lab = 1.5)


# Changing plotting symbols
# To change the plotting symbol use the pch= option:
# plot with the original symbol
plot(Ozone~Wind,data=airquality ,main="Ozone vs. Wind")

# create a plot with modified plotting symbols
plot(Ozone~Wind,data=airquality ,main="Ozone vs. Wind",cex = 1.5 ,pch = 16,col = "red" )

# 
# Line types
# You can change lines using the following options: 
#   lty: line type
# lwd: line width relative to the default

# Changing line types
# Let’s add a smoothing line to the plot:
# original plot
plot(Wind~Temp ,data=airquality ,main="Wind vs. Temp")

# add the smoothing line
m.loess <- loess(Wind~Temp, data = airquality)
# fit the smoothing curve
fit.loess <- fitted(m.loess)
# add the smoothing curve to the plot
lines(airquality$Temp, fit.loess)
# We need to sort the values to get a proper smoothing curve.
# Changing line types
# Let’s add a smoothing line to the plot:
# original plot

plot(Wind~Temp , data=airquality ,main="Wind vs. Temp")
# add the smoothing line
m.loess <- loess(Wind~Temp, data = airquality) # fit the smoothing curve
fit.loess <- fitted(m.loess)
# sort the values
ord.1 <- order(airquality$Temp)
# add the smoothing curve to the plot 
lines(airquality$Temp[ord.1], fit.loess[ord.1],lwd = 3,lty = 2,col = "red")
￼￼￼￼￼￼￼￼￼￼￼￼￼
# 
# Titles
# We can use the function title() to add labels to a plot.
# original plot
plot(Wind~Temp ,data=airquality ,main="", xlab="", ylab="" )

# add a red title and a blue subtitle
# make x and y labels 25\% smaller than original
#and green
title(main = "Wind vs. Temperature",col.main = "red",sub = "Data from La Guardia Airport",col.sub = "blue",
        xlab = "Temperature (F)",
        ylab = "Wind (mph)",
        col.lab = "green",
        cex.lab = 0.75)

# A final example

# original plot
boxplot(Ozone~Month , data=airquality ,
        main="", xlab="", ylab="", xaxt="n", col=topo.colors(12))
# add a red title and a blue subtitle
title(main = "Ozone Concentration by Month", col.main = "red",
      sub = "Data from La Guardia Airport", col.sub = "blue",
      xlab = "Month",
      ylab = "Ozone (ppm)") 

