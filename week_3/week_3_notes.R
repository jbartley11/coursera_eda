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
