# Lesson 1: Distributions

### Lesson Goal: Better Data Intuition
	- Study Design & Estimating Statistical power
	- Generate random distributions in R
	- Graph Random Distributions
	- Connect to data exploration through graphing

## Designing a Study with Statistics

How do we know what is an adequate sample size for a study?
This is *extremely important* in classical statistics with defined hypothesis tests.

#### First we establish our hypotheses
*H0*: Null hypothesis
*H1*: Alternative hypothesis

#### In addition to hypotheses we need to define:
	1. Sample size
	2. Effect size
	3. Significance level (i.e. false positive; Type I error)
		* Expressed formally as P(Type I error)
		* Or Type I error is statistical rejection of a null hypothesis that is true
		* This is like convicting an innocent defendant in court
	4. Power (i.e. likelihood of finding results despite false negative; Type II error)
		* Expressed formally as 1 - P(Type II), or power = Pr(*reject H0*|*H1 is true*)
		* Type II error is the statistical acceptance of a null hypothesis that is false
		* This is like acquitting a criminal in court


#### Practical Examples with power analysis
Now lets go through some practical examples using power analysis with the *pwr* R library based on [Cohen, 1988](http://www.utstat.toronto.edu/~brunner/oldclass/378f16/readings/CohenPower.pdf). Don't worry about the specific statistical tests at this point, we will go over those in lesson 2. This is exercise is meant to mimic what should be done first when designing a scientific study.

```R
library(pwr)

# For a one-way ANOVA comparing 5 groups, calculate the
# sample size needed in each group to obtain a power of
# 0.80, when the effect size is moderate (0.25) and a
# significance level of 0.05 is employed.

pwr.anova.test(k=5, f=0.25, sig.level=0.05, power=0.8)

# What is the power of a one-tailed t-test, with a
# significance level of 0.01, 25 people in each group,
# and an effect size equal to 0.75?

pwr.t.test(n=25, d=0.75, sig.level=0.01, alternative="greater")

# Using a two-tailed test proportions, and assuming a
# significance level of 0.01 and a common sample size of
# 30 for each proportion, what effect size can be detected
# with a power of .75?

pwr.2p.test(n=30,sig.level=0.01,power=0.75)
```

#### Plotting Power curves

```R
# Plot sample size curves for detecting correlations of
# various sizes.

library(pwr)

# range of correlations
r <- seq(.1,.5,.01)
nr <- length(r)

# power values
p <- seq(.4,.9,.1)
np <- length(p)

# obtain sample sizes
samsize <- array(numeric(nr*np), dim=c(nr,np))
for (i in 1:np){
  for (j in 1:nr){
    result <- pwr.r.test(n = NULL, r = r[j],
    sig.level = .05, power = p[i],
    alternative = "two.sided")
    samsize[j,i] <- ceiling(result$n)
  }
}

# set up graph
xrange <- range(r)
yrange <- round(range(samsize))
colors <- rainbow(length(p))
plot(xrange, yrange, type="n",
  xlab="Correlation Coefficient (r)",
  ylab="Sample Size (n)" )

# add power curves
for (i in 1:np){
  lines(r, samsize[,i], type="l", lwd=2, col=colors[i])
}

# add annotation (grid lines, title, legend)
abline(v=0, h=seq(0,yrange[2],50), lty=2, col="grey89")
abline(h=0, v=seq(xrange[1],xrange[2],.02), lty=2,
   col="grey89")
title("Sample Size Estimation for Correlation Studies\n
  Sig=0.05 (Two-tailed)")
legend("topright", title="Power", as.character(p),
   fill=colors)
```

*Examples are drawn from the following link, but this offers a [more detailed explanation of power.](https://www.statmethods.net/stats/power.html)*


## Generating Random distributions

### Normal, or Gaussian, Distribution

This code will be used to generate a random normal distribution.

```R
# Set Seed number for reproducibility
set.seed(5)
# Our distribution has a mean of 3 and a standard deviation of 2.
dist1<-rnorm(1000, mean = 3, sd = 2)

#plot histogram of the random normal distribution
hist(dist1)

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
# set seed
set.seed(5)

#random binomial distribution with parameter size set to 12

```



### Poisson Distribution
```R

#Poisson Distribution

barplot(dpois(0:12, lambda = 2.3), names.arg = 0:12, main = "Poisson Distribution")

```

### Multinomial Distribution



## Problem Set: Data Intuition

random dataset, what kind of distribution is it??

## Continued in Lesson 2: Where the paths diverge...

Some argue that Bayesian statistics is too subjective, since the statistician uses prior beliefs to set initial probability values.
However, with open source it's easy for scientists abuse classical statistical tests without adequately computing an optimal sample size. See [Kwak and Kim](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5370305/) for an in
depth review of the Central Limit Theorem and its applications in medical and biological statistics. Their example
"Central Limit Theorem in the Real World" is excellent extra reading before Lesson 2.