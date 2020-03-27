# Lesson 1: Probability and Regression

### Lesson Goal: Understand the difference between correlation and probability

        - Essentials from probability theory
        - Bayesian thinking, or applied probability
        - Regression Analysis: Foundations of Modeling

## Basic probabilities

Some basic rules
  1. The sum of all probabilities for a set of outcomes will always equal 1
  2. In fair probabilities (think a regular coin) the probability of all events is equal

```R
set.seed(5)

library(prob)

#What are the possible outcomes from a single coin toss?
tosscoin(1, makespace=TRUE)

#What about 3 coin tosses?
tosscoin(3, makespace=TRUE)


```

## Bayesian Probability

Probability forms the foundation of Bayesian Statistics, think about a coin toss. In a deterministic framework, you can only ask the question, "What are the odds of getting a heads or tails?" The answer? 1/2 for either heads or tails. However, Bayesian statistics lets us update the probability to account for a coin that may be weighted to come up tails more often. In a pragmatic scientific sense, this allows for more robust meta-analyses.

```R
set.seed(5)

```
## Examining Correlations

If you're familiar with line fitting in MS Excel, then you have some experience with correlations and correlation coefficients (such as R<sup>2</sup>). These metrics tell us how our data distribution fits the mathematical function of a line mathematical function. Perhaps a more familiar representation is the algebraic slope intercept form: <img src="https://render.githubusercontent.com/render/math?math=y = mx %2B b">

## Modeling Foundations: Univariate Linear Regression

In the most simplistic cases we can utilize _univariate linear regression_, which is just fitting a line <img src="https://render.githubusercontent.com/render/math?math=y = mx %2B b">. to a dataset and assessing how well it fits our dataset.

_Note: In machine learning this is often written in the form:_ <img src="https://render.githubusercontent.com/render/math?math=h_{\theta}(x) = \theta_{0} %2B \theta_{1}x">

### Basic use case for linear regression
```R

set.seed(5)

#mtcars is a test dataset built into R that we can use as toy data for exploring concepts
#basic linear regression using miles per gallon as the dependent variable
# and
plot(x=mtcars$hp, y=mtcars$mpg, ylab = "Miles per Gallon", xlab = "Engine Horsepower")
#make a linear model of our data
model1<-lm(mpg~hp, data=mtcars)
#add our model to the scatterplot as a line to see the fit
abline(model1, col = "blue", lty=2)
#look at the summary statistics of our model
summary(model1)

#loess: locally estimated scatterplot smoothing
# why might this be a better model for the correlation we're looking at?
library(ggplot2)
ggplot(data=mtcars,aes(x = hp, y = mpg)) +
  geom_point() +
  geom_smooth()


```

### Linear Regressions with Variable Transformation

This R code is from a course I took that was taught by [Dr. Filipe Alberto](https://uwm.edu/biology/people/alberto-filipe/). This uses the RIKZ dataset which looks at benthic (ocean bottom-dwelling) fauna community diversity. This code chunk extends the linear regression modeling by incorporating: 1) real world data and 2) log10 transformation of a variable

To import the data into the Rstudio container on CyVerse, open the `terminal` tab in Rstudio. And run `wget 'https://de.cyverse.org/dl/d/EA6332AE-D4C6-4E33-B86A-5F21B3807049/RIKZ.txt'`. This will load the `RIKZ` dataset into the container. 

```R

set.seed(5)

#Reading the RIKZ data set
RIKZ <- read.table(file = "RIKZ.txt",header = TRUE)


#creating a variable with the richness of benthic fauna species (i.e., the number of different species)
# observed in each station (information for each station corresponds to a row in the table)
RIKZ$Richness <- rowSums(RIKZ[,2:76] > 0)


#Plotting the x y plot with: the explanatory variable NAP, the height of the sampling station relative to the mean
# tidal level, in the x axis, and the response variable Richness in the y axis, as is the convention.

plot(RIKZ$NAP,RIKZ$Richness, ylab = "Richness", xlab = "NAP")


#Can benthic species Richness be predicted by the height relative to  mean sea level were the sample was taken
#let's use a linear regression model to see what is the relationship between Richness and NAP. Is there a relationship?
# (i.e., slope is not zero), how much of the total variation in Richness is explained by NAP?

# applying the linear model function. Note how the response variable comes first followed by the ~ symbol and the linear
# combinations of the explanatory variables, in this case only one.
RIKZ_model.1<-lm(log10(Richness+1) ~ NAP, data = RIKZ)
#adding the regression line using the abline() function
abline(RIKZ_model.1,col="Red",lty=1)

#The object RIKZ_model.1 now stores the results the linear model object
# to look in more detail we can use

summary(RIKZ_model.1)

#How does this look without the log transform?
#Try rerunning the code above by removing the references to log10(variable)
RIKZ_model.2<-lm(Richness ~ NAP, data = RIKZ)

#Do the summary stats change?
summary(RIKZ_model.2)

#let's add this model to our plot
abline(RIKZ_model.2, col="Gray", lty=2)
```
