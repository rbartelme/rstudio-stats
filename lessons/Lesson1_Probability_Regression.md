# Lesson 2: Probability and Regression

### Lesson Goal: Understand the difference between correlation and probability

        - Essentials from probability theory
        - Regression Analysis: Foundations
        - Bayesian thinking, or applied probability

## Examining Correlations



### Gaussian (Normal) distributions

There are a number of statistical tests for normal distributions in the base R language. Additionally, this distribution  forms the basis of most introductory statistical courses and training. If you're familiar with line fitting in MS Excel, then you may have some familiarity with correlations and correlation coefficients (such as R<sup>2</sup>). These metrics tell us how our data distribution fits a mathematical function.

In the most simplistic cases we can utilize _univariate linear regression_ or perhaps a more familiar representation is the algebraic slope intercept form: <img src="https://render.githubusercontent.com/render/math?math=y = mx %2B b">. In machine learning this is often written in the form: <img src="https://render.githubusercontent.com/render/math?math=h_{\theta}(x) = \theta_{0} %2B \theta_{1}x">


```R

set.seed(5)



```

## Basic probabilities

## Bayesian Probability

Probability forms the foundation of Bayesian Statistics, think about a coin toss. In a deterministic framework, you can only ask the question, "What are the odds of getting a heads or tails?" The answer? 1/2 for either heads or tails. However, Bayesian statistics lets us update the probability to account for a coin that may be weighted to come up tails more often. In a pragmatic scientific sense, this allows for more robust meta-analyses.