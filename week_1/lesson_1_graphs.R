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

# plotting systems in R --------------
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
