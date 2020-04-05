# Lesson 4: Extending Bayes into Networks

---

### Goal: Deepen Understanding of Bayesian Statistics

#### Lesson Outcomes:
	- Bayes Factors
	- Markov Chains
	- Simple Bayesian Networks

---

## Bayes Factors - Revisiting Probability

### Using Bayes Factors to Fit Regression models
```R
set.seed(5) #very important for reproducibility

#load the Bayes Factor library
library(BayesFactor)

#lets look at some survey data

#use the help function to find out about the dataset
help("attitude")

#load dataset into the environment
data("attitude")

#classical linear regression model of our data
fm1 <- lm(rating ~ ., data = attitude)

#summarize our linear regression model
summary(fm1)

#now compute bayes factors for all possible regression models
bm1 <- regressionBF(rating ~ ., data = attitude, progress = FALSE)

#let's look at the bayesfactors for all the models
bm1
#the full model appears last, how do our models compare to it?
bm1 / bm1[63]

#what is the best fit model? What was most different about this approach compared to frequentist fitting?
```

### Bayes Factor Alternative for Analysis of Variance (ANOVA)
```R
set.seed(5) #very important for reproducibility

#load the Bayes Factor library
library(BayesFactor)

#lets look at the dataset we will be using with help
help("sleep")

#Load sleep study datasets
data("sleep")

#let's nest the classical anova inside summary
summary(aov(extra ~ group + Error(ID/group), data = sleep))

#now let's try the same with Bayes Factors  
anovaBF(extra ~ group + ID, data = sleep, whichRandom = "ID", progress=FALSE)
```
### Further reading


---

## Markov Chains

```R

set.seed(5)


```

### Further reading

---

## Simple Bayesian Networks

Bayesian networks tend to scale very rapidly due to their flexibility, it would be unfeasible to attempt this in a single lesson, but this example dataset should at least get the point across. All variables in the smoking cessation dataset are binary. Continuous distributions of data (like those discussed in Lesson 2), *significantly* increase  necessary compute time.

#### The coronary data set contains the following 6 variables:

	- Smoking (smoking): a two-level factor with levels no and yes.

	- M. Work (strenuous mental work): a two-level factor with levels no and yes.

	- P. Work (strenuous physical work): a two-level factor with levels no and yes.

	- Pressure (systolic blood pressure): a two-level factor with levels <140 and >140.

	- Proteins (ratio of beta and alpha lipoproteins): a two-level factor with levels <3 and >3.

	- Family (family anamnesis of coronary heart disease): a two-level factor with levels neg and pos.

```R
# Set Seed number for reproducibility
set.seed(5)

#load bayesian network learn library
library(bnlearn)

#attach coronary dataset (provided with bnlearn)
data(coronary)

#Load coronary dataset as a data frame
bn_df<-data.frame(coronary)

#learn bayesian network structure by running hill climbing algorithm on
  #the data to be modeled
  #Output the hillclimb results
hc_res <- hc(bn_df)

#plot the hill climb results as graph
plot(hc_res)

#Heuristic curation of graph by removing link between family and work
#This uses negative indexing in R, and operates on the "arcs" of the graph

hc_res$arcs <- hc_res$arcs[-which((hc_res$arcs[,'from'] == "M..Work" & hc_res$arcs[,'to'] == "Family")),]

#Plot the graph again and see the link disappear
plot(hc_res)

#Now let's fit the network with the data
fittedbn <- bn.fit(hc_res, data = bn_df)

#print output of a Proteins node from the fitted network model
  print(fittedbn$Proteins)

#Network inference
cpquery(fittedbn, event = (Proteins=="<3"), evidence = ( Smoking=="no"))

cpquery(fittedbn, event = (Proteins=="<3"), evidence = ( Smoking=="no" & Pressure==">140" ) )

cpquery(fittedbn, event = (Pressure==">140"), evidence = ( Proteins=="<3" ) )

bn.fit.xyplot(fittedbn)
```
Note: this example modifies content from Hamed on [Rbloggers](https://www.r-bloggers.com/bayesian-network-in-r-introduction/)

### Further reading
