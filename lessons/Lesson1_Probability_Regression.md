# Lesson 1: Probability and Regression

### Lesson Goal: Understand correlation and probability

#### Lesson Outcomes:
        - Essential aspects of probability
        - Basic Bayesian thinking
        - Basic regression analyses

## Basic probabilities

Some basic rules
  1. The sum of all probabilities for a set of outcomes will always equal 1
  2. In fair probabilities (think a regular coin) the probability of all events is equal
  3. The sample space is where we consider all probable outcomes of a given scenario

```R
set.seed(5)

library(prob)

#What are the possible outcomes from a single coin toss?
tosscoin(1)

#What about 3 coin tosses?
tosscoin(3)

#What happens if you change the tosscoin function 'makespace' argument to true?

```

## Bayesian Probability

Probability forms the foundation of Bayesian Statistics, think about a coin toss. In a deterministic framework, you can only ask the question, "What are the odds of getting a heads or tails?" The answer? 1/2 for either heads or tails.

 However, Bayesian statistics lets us update the probability to account for a coin that may be weighted to come up tails more often. This framework lets us update our hypotheses and probabilities in the light of new information. Consider the probability `P()` of an event, like `Rain`, given `|`, `sunshine`, or `P(Rain|sunshine)`. We might say given our *a priori*, or previous knowledge, that the probability of it raining given sunshine is quite low. Let's say this is a 5% chance.

 If we consider that we live in Tucson, it is monsoon season, and the afternoon, we can update the probability symbolically as `D_rain`. So our new probability would be expressed as `P(D_rain|sunshine, monsoons)`. Since we know that it tends to rain more during monsoon season, we could formally express this as `P(D_rain|sunshine, monsoons) >> P(Rain|sunshine)`.

This is best exemplified in Bayes' Theorem

<br>
<img src="https://render.githubusercontent.com/render/math?math=P(A \mid B) = \frac{P(B \mid A) \, P(A)}{P(B)}">
<br><br>

Where...

*P(A)* is the probability of the hypothesis before we see the data, called the *prior*

*P(A|B)* is the probability of the hypothesis given observation B, called the *posterior*.

*P(B|A)* is the probability of the data given the hypothesis B, or the *likelihood*.

and finally, *P(B)*, the probability of the data under *any* hypothesis, this is also known as the *normalizing constant*

*We'll revisit Bayes' Theorem more formally in Lesson 2 with distribution fitting*

### Further Reading: Where the paths diverge...

Some argue that Bayesian statistics is too subjective, since the practitioner uses prior beliefs to set initial probability values (like we did in the rain thought exercise).
However, it's also easy for scientists to abuse classical statistical tests, or "*p-hack*". (Some best practices are covered in the next lesson).

See [Kwak and Kim](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5370305/) for an in
depth review of the Central Limit Theorem and its applications in medical and biological statistics. Their example
"Central Limit Theorem in the Real World" is excellent extra reading.

For an in depth e-book on Bayesian Statistics in biology, I highly recommend [Modern Statistics for Modern Biology](http://web.stanford.edu/class/bios221/book/index.html) by Susan Holmes and Wolfgang Huber. This goes into Bayesian statistical applications in biology and contrasts these methods with classical statistics.

## Examining Correlations

If you're familiar with line fitting in MS Excel, then you have some experience with correlations and correlation coefficients (such as R<sup>2</sup>). These metrics tell us how our data distribution fits the mathematical function of a line mathematical function. Perhaps a more familiar representation is the algebraic slope intercept form: <img src="https://render.githubusercontent.com/render/math?math=y = mx %2B b">

### Modeling Foundations: Univariate Linear Regression

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
# why might this be a better model for the correlation we're looking at? Add your thoughts to the hackmd.

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

plot(log10(RIKZ$NAP+1),RIKZ$Richness, ylab = "Richness", xlab = "NAP")


#Can benthic species Richness be predicted by the height relative to  mean sea level were the sample was taken
#let's use a linear regression model to see what is the relationship between Richness and NAP. Is there a relationship? Post your thoughts on hackmd

# Let's apply the linear model function to find out. Note how the response variable comes first followed by the ~ symbol and the linear
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
### Further Reading:

[Multiple Linear Regression in Python](https://towardsdatascience.com/multiple-linear-regression-51352d687ecb)

[Generalized Linear Models in R ($$)](https://link.springer.com/book/10.1007/978-1-4419-0118-7)

[Fitting Polynomial Regressions in R](https://datascienceplus.com/fitting-polynomial-regression-r/)
