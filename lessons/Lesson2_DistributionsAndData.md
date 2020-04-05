# Lesson 2: Study Designs and Data Distributions

---

### Lesson Goal: Better Data Intuition

#### Lesson Outcomes:
	- Basics of hypothesis testing
	- Designing with Power
	- Modeling data distributions in R
	- Fitting distributions to data

---

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

### Further Reading

[Study Design and Choosing a Statistical Test](https://www.bmj.com/about-bmj/resources-readers/publications/statistics-square-one/13-study-design-and-choosing-statisti)

[Bayesian Experimental Design: A Review](https://projecteuclid.org/euclid.ss/1177009939)

---

## Statistical Power in Classical Deterministic Statistics

	- What is the right number of samples for a study?
	- What are we testing?
	- What actually is statistical power?

We are trying to establish *significance* thresholds to avoid false positives, and we want to make sure we have a large enough sample size to offset false positives and generate a statistical test with adequate *power*.

#### Practical Examples with power analysis

Now lets go through some practical examples using power analysis with the *pwr* R library based on [Cohen, 1988](http://www.utstat.toronto.edu/~brunner/oldclass/378f16/readings/CohenPower.pdf). This is exercise is meant to mimic what should be done first when designing a scientific study.

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
		    result <- pwr.r.test(n = NULL, r = r[j], sig.level = .05, power = p[i], alternative = "two.sided")
		    samsize[j,i] <- ceiling(result$n)
		  }
		}

# set up graph
xrange <- range(r)
yrange <- round(range(samsize))
colors <- rainbow(length(p))
plot(xrange, yrange, type="n", xlab="Correlation Coefficient (r)", ylab="Sample Size (n)" )

# add power curves
for (i in 1:np){
		  lines(r, samsize[,i], type="l", lwd=2, col=colors[i])
		}

# add annotation (grid lines, title, legend)
abline(v=0, h=seq(0,yrange[2],50), lty=2, col="grey89")
abline(h=0, v=seq(xrange[1],xrange[2],.02), lty=2, col="grey89")
title("Sample Size Estimation for Correlation Studies\n
		  Sig=0.05 (Two-tailed)")
legend("topright", title="Power", as.character(p), fill=colors)
```
#### Further Reading

*Examples are drawn from the following link, which offers a [more detailed explanation of power.](https://www.statmethods.net/stats/power.html)*

[Intro to Statistical Power and Power Analysis in Python](https://machinelearningmastery.com/statistical-power-and-power-analysis-in-python/)

---

## Modeling Random distributions

Modeling random distributions can be useful for creating toy data to test statistical code *before* running our actual data through the analyses.

### Normal, or Gaussian, Distribution

This code will be used to generate a random normal distribution. This can be useful for testing your statistical code before you get data, or just for debugging.

```R
# Set Seed number for reproducibility
set.seed(5)
# Our distribution has a mean of 3 and a standard deviation of 2.
dist1<-rnorm(1000, mean = 3, sd = 2)

#plot histogram of the random normal distribution
hist(dist1)

```

### Bernoulli Distribution

Think about a coin toss, there's a 50% chance that it will come up heads (0) or tails (1). We're only going to flip a single coin each trial, so size = 1. The first number 15 indicates how many times (n trials) we will toss the coin.

```R
#use the same seed set
set.seed(5)

#random binomial distribution with two outcomes 0 or 1 or a 'bernoulli trial'
bern<-rbinom(15, prob = 0.5, size = 1)
#print our random bernoulli trial output
bern
#rough plot of frequency of 0 vs. 1, notice the frequency is pretty close to 50%,
# but we told R to use an odd number of trials
hist(bern, ylim = c(0,10))
```

### Poisson Distribution

This is a distribution of the probability of a given number of events occurring at a fixed time interval or inside a fixed space.

![](https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/Poisson_pmf.svg/650px-Poisson_pmf.svg.png)
<br>
<br>
The horizontal axis is the index k, the number of occurrences. λ is the expected number of occurrences, which need not be an integer. The vertical axis is the probability of k occurrences given λ. The function is defined only at integer values of k. The connecting lines are only guides for the eye. From [wikipedia](https://en.wikipedia.org/wiki/Poisson_distribution)




```R

#Poisson Distribution
barplot(dpois(0:12, lambda = 2.3), names.arg = 0:12, main = "Poisson Distribution")

```

---

## Tests for distribution fitting

What if we have some *actual* data? How do we know if we should use parametric (tests for normal distributions) or non-parametric (tests for non-normal distributions) even though we designed the study with power calculations?
There is a whole ecosystem of statistical tests to determine how well a dataset fits a given distribution.

### Shapiro-Wilk Test of Normality

In base R we can invoke `shapiro.test()` on a vector. We are looking to see if the p-value from this test is greater than our significance threshold. Remember p-values are asking about significant deviation from a distribution. Since we are asking if our data are normally distributed, a p-value less than our threshold would indicate type 1 error.

```R

set.seed(5)

#Generate random normal distribution
dist1 <- rnorm(1000, mean = 3, sd = 2)

#generate random Poisson Distribution
dist2 <- rpois(12, lambda=1.2)

#Shapiro-Wilk testing (approximation when n > 3)
	#random normal distribution test
	shapiro.test(dist1)
	#random poisson distribution test
	shapiro.test(dist2)

```
### Maximum-likelihood Estimation of Distributions

Shapiro-Wilk works on basic cases, but what if we have a large amount of data and need to figure out the distribution in a more robust manner? This is where the `library(MASS)` function `fitdistr(x, densfun, start, …)` comes in handy. This uses Maximum-Likelihood Estimates to find the most likely distribution that fits the dataset.  

```R
library(MASS)

set.seed(5)

#lets read in the RIKZ benthic fauna data again
#remember to run wget 'https://de.cyverse.org/dl/d/EA6332AE-D4C6-4E33-B86A-5F21B3807049/RIKZ.txt' in the terminal

#Reading the RIKZ data set
RIKZ <- read.table(file = "RIKZ.txt",header = TRUE)


#creating a variable with the richness of benthic fauna species (i.e., the number of different species)
# observed in each station (information for each station corresponds to a row in the table)
RIKZ$Richness <- rowSums(RIKZ[,2:76] > 0)

#Now let's see what richness looks like as a histrogram
#we'll make a histogram of probability densities of Richness

hist(RIKZ$Richness, probability = TRUE)

#since we loaded the MASS library at the beginning
# we can use the fitdistr() function to fit a normal distribution to the dataset

#fit the model using maxmimum likelihood estimates
Richness_fit_normal<-fitdistr(RIKZ$Richness, densfun = "normal")

#let's see the mean and sd of a normal distribution fit to the model
Richness_fit_normal

#plot the elements of the fitted distribution as a curve across the histogram
curve(dnorm(x, mean = Richness_fit_normal$estimate[1], sd = Richness_fit_normal$estimate[2]), col ="red", lwd=2, add=TRUE)

#now let's look at the log likelihood
Richness_fit_normal$loglik

#How does that look? Does it fit well?

#lets try another model
Richness_pois <- fitdistr(RIKZ$Richness, densfun = "poisson")

#Is this a better fit? Slightly...
Richness_pois$loglik

#let's try one last distribution
Richness_ge <- fitdistr(RIKZ$Richness, densfun = "geometric")

#This is a poor fit by MLE
Richness_ge$loglik

```

### Further Reading

[Fitting Distributions with R](https://cran.r-project.org/doc/contrib/Ricci-distributions-en.pdf)

[Bayesian Fitting with Probabilistic Morphable Models](http://shapemodelling.cs.unibas.ch/pmm2017/slides/bayes.pdf)
