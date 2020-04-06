# Lesson 3: Dimensionality

---

### Lesson Goal: Understand data dimensionality and clustering

#### Lesson Outcomes:
  - Data clustering
  - What is dimensionality?
  - Ordination and Gradient Dimension Reduction

---

## Data clustering

There are many different ways to cluster data, all varying in their mathematical complexity and scope of application. This is an active area of algorithmic research, so new clustering methods are readily available (particular in the R codebase).

Perhaps the most simplistic method of clustering is agglomerative hierarchical clustering of data. This is often represented as a dendrogram, where more related data are clustered as "leaves", with the same original linkage. The scale of the dendrogram leaves and the clustering (linkage) are generally chosen *a priori* based on mathematical criteria.

#### Euclidean Distance with Ward linkage

```R

#find colnames for mtcars
colnames(mtcars)

#convert mtcars into a matrix
carmat<-as.matrix(mtcars)

#calculate euclidean distance between objects
ed <- dist(carmat, method = "euclidean")

#find ward linkage for distances
wfit <- hclust(ed, method = "ward.D")

plot(wfit, hang = -1, cex = 0.6)
```
#### Manhattan Distance with Ward linkage

```R

#convert mtcars into a matrix
carmat<-as.matrix(mtcars)

#calculate euclidean distance between objects
ed <- dist(carmat, method = "manhattan")

#find ward linkage for distances
wfit <- hclust(ed, method = "ward.D")

plot(wfit, hang = -1, cex = 0.6)
```

#### K-means Clustering or Data Partitioning

One of the most popular partitioning (or clustering) algorithms is k-means clustering. The user specifies the expected number of clusters (k) to extract from the data. In the example below, we'll use the "iris" data set, where we will clearly see our k-clusters. However, if you are determining this for a dataset with an unknown quantity of clusters you will need to derive this and find the breakpoint similar to a [scree plot](http://www.instantr.com/2012/12/19/creating-a-scree-plot-in-r/).

```R
set.seed(5)

#load the iris dataset and look at the head of it
library(datasets)
head(iris)

#exploratory plot of iris dataset
library(ggplot2)
ggplot(iris, aes(Petal.Length, Petal.Width, color = Species)) + geom_point()

#we see there are 3 species of iris in the data
#so it makes sense to use k=3 partitions for kmeans Clustering

#let's cluster by Petal.Length and Petal.Width
#nstart will start the clustering randomly
irisCluster <- kmeans(iris[, 3:4], 3, nstart = 20)

irisCluster

#compare the clusters to the species with table()
table(irisCluster$cluster, iris$Species)

#we can also plot the data to see the clusters

#convert to a factor
irisCluster$cluster <- as.factor(irisCluster$cluster)

#plot with ggplot2
ggplot(iris, aes(Petal.Length, Petal.Width, color = iris$cluster)) + geom_point()

```
[kmeans example from this source](https://www.r-bloggers.com/k-means-clustering-in-r/)

*These concepts are essential for machine learning (ML) and data mining, since cluster and partitioning analyses are another foundational skill for ML.*

### Further Reading

[k-means and hierarchical clustering](http://www.cs.cmu.edu/afs/cs/user/awm/web/tutorials/kmeans11.pdf)

[Unsupervised Learning: k-means vs hierarchical clustering](https://towardsdatascience.com/unsupervised-learning-k-means-vs-hierarchical-clustering-5fe2da7c9554)

---

## What is dimensionality?

We are most familiar with the Euclidean mathematical space (think X-Y, or X-Y-Z plots). However, we often have datasets that consist of multiple variables, and we would like to understand how they are interrelated. This could be analogous to a system of equations, where, we are looking to see which equations intersect with each other in a larger, or hyperdimensional, space. The concepts of dimensionality and dimension reduction are fundamental to understanding what lies behind machine learning and AI algorithms, from the most basic decision tree to the most complex neural network.

### Further reading

[What is dimensionality?](https://www.statisticshowto.com/dimensionality/)

[Dimension Reduction in Data Science](https://www.kdnuggets.com/2019/01/dimension-reduction-data-science.html)

## Ordination or Gradient analysis

Sometimes it is difficult computationally or visually to represent multivariate data. Often times ordination or gradient analyses are deployed to reduce dimensionality for visualization of data or input into complex machine learning models. I have most often encountered ordination in population ecology, so we will be using some functions from the R library `vegan` to explore these concepts, as well as examples using base R.

### Ordination is like ice cream, it comes in a variety of flavors...

An entire course could be taught on this subject alone, since there are many variations on ordination. So I will choose to focus on a select few methods. This is not meant to be exhaustive, but simply to demonstrate the goal of reducing dimensions.  

#### Principal Component Analysis (PCA)
```R
set.seed(5)

#make PCA from the mt cars dataset
mtcars.pca <- prcomp(mtcars[,c(1:7,10,11)], center = TRUE,scale. = TRUE)

#make a scree plot of the components
plot(mtcars.pca)

#this could be extended with a biplot, but that is not natively supported
```

#### Correspondence Analysis (CA or CCA)
```R
set.seed(5)

library(vegan)

#dune are dune meadow vegetation data of 30 species on 20 sites.
# and dune.env contains environmental variables associated with dune
# data are from Jongman et al. 1987

#let's look at how soil thickness at the horizon (A1)
#and management BF (Biological farming), HF (Hobby farming), NM (Nature Conservation Management), and SF (Standard Farming)
#interact with the abundance of dutch dune meadow vegetation composition

ord <- cca(dune ~ A1 + Management, data=dune.env)
```

#### Non-Metric Multidimensional Scaling (nMDS)
```R
set.seed(5)

library(vegan)

#wraps MDS, permutation, distance matrix, and procrustes into a single function for nonmetric Multidimensional scaling
dune_nmds <- metaMDS(dune)

#we can take the output of this and see how well our environmental data fit and the "significance" is assessed for each variable in the model

dune_fit <- envfit(dune_nmds ~ A1 + Management, data=dune.env, perm=999)
```

### Further reading

A lot of the maths behind these analyses is complex and beyond the scope of this short course. If you are interested in resources to explore these ideas in an ecological context, I suggest the book [*Numerical Ecology*](https://www.elsevier.com/books/numerical-ecology/legendre/978-0-444-53868-0) by Pierre and Loic Legendre. These are also two contributing authors to the `vegan` library.

[Ordination in Python with Sklearn and Biological Examples](http://scikit-bio.org/docs/0.4.2/generated/skbio.stats.ordination.html)

[EcoPy Ordination](https://ecopy.readthedocs.io/en/latest/ordination.html)

[nMDS vs PCoA](http://biol09.biol.umontreal.ca/PLcourses/Comparison_nMDS_PCoA.pdf)
