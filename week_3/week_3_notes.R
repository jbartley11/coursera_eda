# Hierarchical Clustering Part 1 -------------------
# clustering organizes things that are close into groups
# how do we define close?
# how do we group things?
# how do we visualize the grouping?
# how do we interpret the grouping?

# get a sense for what's going on with high dimensional data set

# widely applied method

# hierarchical clustering
# an agglomerative approach
## find closest two things, put them together, find next closest
## requires - a defined distance, a merging approach
## produces a tree(dendrogram) showing how close things are to each other

# how define close?
# important, garbage in garbage out, pick right method for your problem
# continuous, euclidean distance, point a to point b
# continuous, correlation similarity
# binary - manhattan distance

# euclidean
# dc to new york
# sqrt((x1-x2)2 + (y1-y2)2 )

# manhattan distance
# look at points on a grid, travel along city blocks
# |A1-A2| + |B1-B2|
# useful in some context, might more accurately represent true distance

# Hierarchical clustering part 2 --------------

# an example
set.seed(1234)
par(mar=c(0,0,0,0))
x <- rnorm(12, mean=rep(1:3, each=4), sd=0.2)
y <- rnorm(12, mean=rep(c(1,2,1), each=4), sd=0.2)
plot(x,y,col="blue", pch=19, cex=2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))

# calculate distance between all points, pairwise distances
# dist function
# defaults to euclidean
df <- data.frame(x=x, y=y)
distxy <- dist(df)

# take two closest points, 5 and 6
# next two are 10 and 11

# clustering functin hclust
hClustering <- hclust(distxy)
plot(hClustering)

# need to cut tree to determine how many clusters there are
# then you can get cluster assignment

# Hierarchical Clustering Part 3----------------

# prettier 
myplclust <- function(hclust, lab=hclust$labels, lab.col = rep(1, length(hclust$labels)), hang=0.1, ...) {
  ## modification of plclust for plotting hclust objects in color
  y <- rep(hclust$height, 2)
  x <- as.numeric(hclust$merge)
  y <- y[which(x<0)]
  x <- x[which(x<0)]
  x <- abs(x)
  y <- y[order(x)]
  x <- x[order(x)]
  plot(hclust, labels=FALSE, hang=hang, ...)
  text(x = x, y=y[hclust$order] - (max(hclust$height) * hang), labels=lab[hclust$order],
       col=lab.col[hclust$order], srt=90, adj=c(1,0.5), xpd=NA, ...)
}

myplclust(hClustering, lab=rep(1:3, each=4), lab.col=rep(1:3, each=4))

# even prettier dendrograms: gallery.r-enthusiasts.com/RGraphGallery

# merging points - complete
# averaging - middle between two points, centroid of clusters distance between
# complete - distance between two furtherest points another option

#heatmap
df <- data.frame(x=x, y=y)
set.seed(143)
dataMatrix <- as.matrix(df)[sample(1:12),]
heatmap(dataMatrix)

# K-means Clustering Part 1 -----------------------
# how do we determine similiarity and difference
# close - need to give it a distance metric
# different definitions of distance - euclidean(straight line), or correlation, or manhattan distance

# partioning approach, fix a number of clusters
# get centroids, assign things to closest, recalculate centroids
# requires: dinstance, number of clusters, initial guess of cluster centroids
# produces: estimate of cluster centroids, assignment of each point to cluster

# example
set.seed(1234)
par(mar=c(0,0,0,0))
x <- rnorm(12, mean=rep(1:3, each=4), sd=0.2)
y <- rnorm(12, mean=rep(c(1,2,1), each=4), sd=0.2)
plot(x, y, col="blue", pch=19, cex=2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))

# starting centroids
# assign point to closest centroid
# recalculate centroids
# iterate over update centroid and assign points to cluster

# K-means Clustering Part 2 -----------------------

kmeansObj <- kmeans(df, centers=3)
# view elements in kmeans object
names(kmeansObj)
# return vector of cluster
kmeansObj$cluster

# plot results
par(mar=rep(0.2,4))
plot(x,y, col=kmeansObj$cluster, pch=19, cex=2)
points(kmeansObj$centers, col=1:3, pch=3, cex=3, lwd=3)

# view clustering info as heatmap
set.seed(1234)
dataMatrix <- as.matrix(df)[sample(1:12),]
kmeansObj2 <- kmeans(dataMatrix, centers=3)
par(mfrow=c(1,2), mar=c(2,4,0.1,0.1))
image(t(dataMatrix)[,nrow(dataMatrix):1], yaxt="n")
image(t(dataMatrix)[,order(kmeansObj2$cluster)], yaxt="n")

# k-means requires that you know number of clusters
# have to use eye/intuition
# cross validation information theory can help determine number of clusters
# not deterministic: not stable results, different # of clusters, different iterations

# Dimension Reduction Part 1 -------------------
