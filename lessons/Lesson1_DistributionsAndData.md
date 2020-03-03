# Lesson 1: Distributions

### Lesson Goal: Better Data Intuition
	- Study Design & Estimating Statistical power
	- Generate random distributions in R
	- Graph Random Distributions
	- Connect to data exploration through graphing

## Designing a Statistical Study

## Generating Random distributions

### Normal, or Gaussian, Distribution

This code will be used to generate a random normal distribution.

```R
# Set Seed number for reproducibility
set.seed(5)
#Normal, or Gaussian, Distribution
# Our distribution has a mean of 3 and a standard deviation of 2.
dist1<-rnorm(1000, mean = 3, sd = 2)
#plot histogram of the random normal distribution
hist(dist1)
# now we'll go through some parametric statistical tests

```

### Bernoulli Distribution
```R
#use the same seed set
set.seed(5)
#random binomial distribution with two outcomes 0 or 1
rbinom(15, prob = 0.5, size = 1)
#Can we plot this?
```
### Binomial Distribution
```R
# same seed
set.seed(5)
#random binomial distribution with parameter size set to 12
```



### Poisson Distribution
```R
#Poisson Distribution
barplot(dpois(0:12, lambda = 2.3), names.arg = 0:12, main = "Poisson Distribution")
```

### Multinomial Distribution



## Data Intuition

random dataset, what kind of distribution is it??

## Where the paths diverge...

Perhaps one of the biggest discrepencies between classical and Bayesian statistics is the concept of statistical power.
Some argue that Bayesian statistics is too subjective, since the statistician establishes the prior probability values.
However, a fair number of scientists use classical statistical tests without adequately computing an optimal sample size.
This leads to posthoc application of parametric tests (tests designed to be used on data from a normal distribution), or
the overuse of non-parametric tests. See [Kwak and Kim](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5370305/) for an in
depth review of the Central Limit Theorem and its applications in medical and biological statistics. Their example
"Central Limit Theorem in the Real World" is excellent extra reading before Lesson 2.

But what do we mean by "
