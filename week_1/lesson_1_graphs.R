# general rules to follow when building graphics ----------------
# book beautiful evidence by Edward Tufte

# 1. show comparisons
# evidence for a hypothesis is always relative to another competing hypothesis
# control home vs air cleaner homes

# 2. show causality, mechanism, explanation, systematic structure
# what's the causal framework
# why does air cleaner cause a better env
# particulate matter between control vs air cleaner
# how world works

# 3. show multivariate data
# more than 2 variables, real world is multivariate
# tell richer story

# 4. Integrate evidence
# integrate words, numbers, images, diagrams
# don't let tool drive the analysis

# 5. Describe and document the evidence with appropriate labels, scales, sources, etc

# 6. Content is king
# tell an interesting story
# be critical of quality, relevance and integrity


# Exploratory Graphs part 1 ------------------------------

# why do we use graphs in data analysis?
# understand data properties
# find patterns in data
# suggest modeling strategies
# to debug analyses
# to communicate results - won't focus on this part yet

# characteristics of exploratory graphs
# made quickly
# make a lot of them
# goal is for personal understanding
# axes/legends are generally cleaned up later
# color_size are primarily used for information

# Air pollution in US
# EPA Air Quality System
# mean of pm25 over last 3 years
setwd("Development/courses/coursera_exploratory_data_analysis/week_1")
fileUrl <- "https://raw.githubusercontent.com/jtleek/modules/master/04_ExploratoryAnalysis/exploratoryGraphs/data/avgpm25.csv"
if(!file.exists("./data")){dir.create("./data")}
download.file(fileUrl, destfile="./data/avgpm25.csv", method="curl")
data <- read.csv("./data/avgpm25.csv")

# Simple summaries of data
# 1 dimension: summary, boxplots, histograms, density plot, barplot

# summary
# 6 number - min 1st quartile, median, mean, 3rd quartile, max
summary(data$pm25)

# boxplot
# black line is median
# whiskers are min and max
# box represents values in 2nd and 3rd quartiles
# The "whiskers" of the box (the vertical lines extending above and below the box) relate to the range
# | parameter of boxplot, which we let default to the value 1.5 used by R. The height of the box is the
# | interquartile range, the difference between the 75th and 25th quantiles. In this case that difference is
# | 2.8. The whiskers are drawn to be a length of range*2.8 or 1.5*2.8. This shows us roughly how many, if any,
# | data points are outliers, that is, beyond this range of values.

boxplot(data$pm25, col="blue")

# histogram
# shows distribution and frequency of data
hist(data$pm25, col="green")
# rug shows each individual data point
rug(data$pm25)

# can change breaks, number of bars
hist(data$pm25, col="green", breaks=100)

# overlaying features
boxplot(data$pm25, col="blue")
# 12 is standard, add line at 12 to visualize
abline(h=12)

# overlay on histogram
hist(data$pm25, col="green", breaks=30)
abline(v=12, lwd=2)
abline(v=median(data$pm25), col="magenta", lwd=4)
rug(data$pm25)

# barplot
# group by category
barplot(table(data$region), col="wheat", main="Number of counties in each region")


# Exploratory Graphs Part 2 --------------------------------

# two dimensional plots
# multiple/overlayed 1D plots
# scatterplots, smooth scatterplots

# 2 dimensions
# overlayed/multiple 2D plots coplots
# use color, size, shape to add dimensions
# spinning plots
# actual 3D plots

# multiple boxplots
boxplot(pm25 ~ region, data=data, col="red")

# multiple histograms
par(mfrow= c(2,1), mar=c(4,4,2,1))
hist(subset(data, region=="east")$pm25, col="green")
hist(subset(data, region=="west")$pm25, col="green")

# scatter plot
with(data, plot(latitude, pm25, col=region))
abline(h=12, lwd=2, lty=2)

# multiple scatterplots
par(mfrow=c(1,2), mar=c(5,4,2,1))
with(subset(data, region=="east"), plot(latitude, pm25, main="East"))
with(subset(data, region=="west"), plot(latitude, pm25, main="West"))

# resources
# r graph gallery
# r bloggers

# Plotting Systems in R --------------
# 3 core plotting systems

# base plotting system
# original, artist's palette model, blank and build up from there
# add one by one
# takes more code
# text, lines, points, axes
# convenient
# can't go back/remove items

# base plot
library(datasets)
data(cars)
with(cars, plot(speed, dist))

# 2nd major plotting system - Lattice
# every plot is made with single function call
# have to specify a lot of information
# good for coplots, panel plots
# x and y over z
# can put a lot of plots over page, quickly
# awkward using single function call
# hard to annotate
# can't add anything after it's made

library(lattice)
state <- data.frame(state.x77, region=state.region)
xyplot(Life.Exp ~ Income | region, data=state, layout=c(4,1))


# 3rd system - ggplot2
# grammar of graphics system
# mixes ideas from base and lattice
# deals with spacings, text, titles
# has default mode, that you can change

library(ggplot2)
data(mpg)
qplot(displ, hwy, data=mpg)

# The Base Plotting System --------------------

# graphics package - contains functions for the base system
# includes plot, hist, boxplot, and others
# grDevices - code for X11, PDF, PostScript, PNG
# lattice uses lattice and grid package

# process of making a plot
# where will it be made, screen, file
# how will it be used?
# large amount of data?
# does it need to be scalable

# what system do you want to use?
# base - piecemeal
# lattice - single function call
# ggplot2 - combines both

# base graphics
# 2 steps: create new plot, annotate it
# par

# reset par
par(mfrow = c(1,1))

library(datasets)
hist(airquality$Ozone)

# scatterplot
with(airquality, plot(Wind, Ozone))

# boxplot
# use transform to convert month column to factor
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab="Month", ylab="Ozone")

# base graphics parameters
# pch - plotting symbol
# lty - line type, solid, dashed
# lwd - line width
# col - color
# xlab, ylab - axes labels

# par is used to specify global graphics parameters
# las - orientation of the axis labels
# bg - background color
# mar - margin size
# oma - out margin size
# mfrow - number of plots per row, column - filled row-wise
# mfcol - number of plots per row, column - filled column-wise

# see what default values are
par("lty")
par("mar")
par("bg")

# Base Plotting Functions ------------------------------
# plot - make scatterplot,  or other type
# lines - add line to plot
# points add points to plot
# text - add labels based on x, y coordinates
# mtext - text in margins
# axis - add axis ticks/labels

library(datasets)
with(airquality, plot(Wind, Ozone))
title(main="Ozone and Wind in New York City")

# add title within plot function
with(airquality, plot(Wind, Ozone, main="Ozone and Wind in New York City"))

# subset datset and add points to existing plot
with(subset(airquality, Month==5), points(Wind, Ozone, col="blue"))
with(subset(airquality, Month!=5), points(Wind, Ozone, col="red"))

# add legend
legend("topright", pch=1, col=c("blue","red"), legend=c("May", "Other Months"))

# base plot with regression line
with(airquality, plot(Wind, Ozone,
                      main="Ozone and Wind in New York City",
                      pch=20))
?lm
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd=2)

# multiple base plots
par(mfrow=c(1,1))
par(mfrow=c(1,2))
with(airquality, plot(Wind, Ozone, main="Ozone and Wind"))
with(airquality, plot(Solar.R, Ozone, main="Ozone and Solar Radiation"))

# Base Plotting Demo ---------------------------------------------------
par(mfrow=c(1,1))
x <- rnorm(100)
hist(x)

y <- rnorm(100)
plot(x, y)
par(mar=c(4,4,2,2))

#pch=20 - solid 
example(points)

# Graphics Devices-------------------------------------------------------

# something where you can make a plot appear
# window on screen, pdf, png or jpeg, svg

# full list of devices available on your computer ?Devices

# Graphics File Devices-------------------------------------------------
# pdf, svg, win.metafile, postscript
# bitmap: png, jpeg, tiff, bmp

# copying plots, create on screen, make file from it
with(faithful, plot(eruptions, waiting))
title(main="Old Faithful Geyser data")
dev.copy(png, file="geyserplot.png")
dev.off()
getwd()
