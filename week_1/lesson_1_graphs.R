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

