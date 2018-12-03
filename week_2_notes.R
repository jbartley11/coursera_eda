# exploratory data analysis
# week 2 notes

# Lattice plotting part 1 ----------------------------
# good for making many plots at once

# uses grid package
# all plotting done with single function call

# xyplot
# bwplot
# histogram
# stripplot

# xyplot
# xyplot( y ~ x | f * g, data)
# y is y axis, x is x
# f/g are conditioning variables
# * indictes an interaction between two variables

# simple lattice plot
library(lattice)
library(datasets)
xyplot(Ozone ~ Wind, data = airquality)

airquality <- transform(airquality, Month=factor(Month))
xyplot(Ozone ~ Wind | Month, data=airquality, layout=c(5,1))

# lattice returns an object

# panel functions
# controls what happens inside each panel

set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each=50)
y <- x + f - f * x + rnorm(100, sd=0.5)
f <- factor(f, labels=c("Group 1", "Group 2"))
xyplot(y~x |f, layout=c(2,1))

# use function to add median line
xyplot(y~x|f, panel=function(x,y, ...){
  panel.xyplot(x,y,...)
  panel.abline(h=median(y), lty=2)
})

# add regression line
xyplot(y~x|f, panel=function(x,y, ...){
  panel.xyplot(x,y,...)
  panel.lmline(x,y, col=2)
})

# can't use base annotation functions, can't mix

# many panel lattice - mouse allergen and asthma cohort study


# ggplot2 ------------------------
# grammar of graphics implementation
# shorten the distance from the mind to page" hadley

# qplot uses dataframe
# plots are made of aesthetics(size, shape, color)
# and geoms(points, lines)

# use factors because they indicate subsets of the data - should be labeled

# ggplot is underlying function with more flexibility than qplot


library(ggplot2)
str(mpg)
mpg$manufacturer <- as.factor(mpg$manufacturer)
mpg$model <- as.factor(mpg$model)
mpg$trans <- as.factor(mpg$trans)
mpg$drv <- as.factor(mpg$drv)
mpg$fl <- as.factor(mpg$fl)
mpg$class <- as.factor(mpg$class)

qplot(displ, hwy, data=mpg)
qplot(displ, hwy, data=mpg, color=drv)
qplot(displ, hwy, data=mpg, geom=c("point","smooth"))

# histogram
qplot(hwy, data=mpg, fill=drv)

# facets, like panels in lattice
qplot(displ, hwy, data=mpg, facets=.~drv)
# rows ~ columns

# basic components of ggplot2 plot
# dataframe
#aesthetic mappings: color, size
# geoms - points lines shapes
# facets - conditional plots
# stats - transformations like binning, quantiles, smoothing
# scales - what scale an aesthetic map uses( male=red, female=blue)
# coordinate system

# build using individual functions
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
print(g) # will error
p<- g +geom_point()
print(p) # will plot

# add more layers: smooth
g + geom_point() + geom_smooth()
geom_smooth(method="lm")
# loess smoother
# linear regression line
# add facets
g + facet_grid(. ~ bmicat)

# annotation
# xlab(), ylab(), labs, ggtitle()
# each geom has options you can modify
# aes function
g + geom_point(aes(color=bmicat), size=4, alpha=1/2)

# axis limits
g <- ggplot(testdat, aes(x=x, y=y))
g + geom_line()

# if you use lims it will remove outliers
ylim(-3,3) # will compress data
g+geom_line() + coord_cartesian(ylim=c(-3,3))

