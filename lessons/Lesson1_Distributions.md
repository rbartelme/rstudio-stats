# Lesson 1: Distributions

### Goal: Better Data Intuition:
	- Generate random distributions in R
	- Graph Random Distributions
	- Connect to data exploration through graphing

## Normal, or Gaussian, Distribution
```R
# Set Seed number for reproducibility
set.seed(5)
#Normal, or Gaussian, Distribution
dist1<-rnorm(1000,mean = 3, sd=2)
hist(dist1)
```

## Bernoulli Distribution
```R
#use the same seed set
set.seed(5)
#random binomial distribution with two outcomes 0 or 1
rbinom(15, prob = 0.5, size = 1)
#Can we plot this?
```
## Binomial Distribution
```R
# same seed
set.seed(5)
#random binomial distribution with parameter size set to 12
```



## Poisson Distribution
```R
#Poisson Distribution
barplot(dpois(0:12, lambda = 2.3), names.arg = 0:12, main = "Poisson Distribution")
```

## Multinomial Distribution




