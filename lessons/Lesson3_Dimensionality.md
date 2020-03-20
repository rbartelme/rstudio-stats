# Lesson 3: Dimensionality

### Lesson Goal: Understand when/how to reduce dimensions in data

- How to deal with multidimensional data
- What works best with missing data?
- How to decide how many dimensions are important

## Data clustering

There are many different ways to cluster data, all varying in their mathematical complexity and scope of application. This is an active area of algorithmic research, so new clustering methods are readily available (particular in the R codebase).

Perhaps the most simplistic method of clustering is hierarchical clustering of data. This is often represented as a dendrogram, where more related data are clustered as "leaves", with the same original linkage. The scale of the dendrogram leaves and the clustering (linkage) are generally chosen *a priori* based on mathematical criteria.

These concepts are essential for machine learning (ML) and data mining, since hierarchical cluster analysis is another foundational framework of ML.

## What is dimensionality?

We are most familiar with the Euclidean mathematical space (think X-Y, or X-Y-Z plots). However, we often have datasets that consist of multiple variables, and we would like to understand how they are interrelated. This could be analogous to a system of equations, where, we are looking to see which equations intersect with each other in a larger, or hyperdimensional, space. The concepts of dimensionality and dimension reduction are fundamental to understanding what lies behind machine learning and AI algorithms, from the most basic decision tree to the most complex neural network.

## Ordination or Gradient analysis



### Correspondence Analysis (CA)

### Principal Component Analysis (PCA)

### Principal Coordinate Analysis (PCoA)

### Multidimensional Scaling (MDS)

### Non-Metric Multidimensional Scaling (nMDS)
