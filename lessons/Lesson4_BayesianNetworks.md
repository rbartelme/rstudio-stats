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

[Bayes Factors in Python with PyMC3](https://docs.pymc.io/notebooks/Bayes_factor.html)

[Bayes Factors by Kass and Raftery](https://www.stat.cmu.edu/~kass/papers/bayesfactors.pdf)

[Bayes Factors for Those Who Hate Bayes Factors](https://www.bayesianspectacles.org/bayes-factors-for-those-who-hate-bayes-factors/)

---

## Markov Chains

```R
#========================================
# Setup
#========================================

#Set seed for reproducibility
set.seed(5)

#Load libraries

#markov chain library
library(markovchain)

#DAG library
library(diagram)

#========================================
# Simple markov chain example
#========================================

#let's define a transition state probability matrix for a weather example
tmA <- matrix(c(0.25,0.65,0.1,.25,0.25,.5,.35,.25,0.4),nrow = 3, byrow = TRUE)

#create the discrete time markov chain
dtmcA <- new("markovchain",transitionMatrix=tmA, states=c("No Rain","Light Rain","Heavy Rain"), name="MarkovChain A")

#now let's visualize this markov chain with the diagram package

#make a character vector of the statenames
stateNames <- c("No Rain","Light Rain","Heavy Rain")

#assign state names as row names for the transition state matrix

#this will assign row names to the matrix for a better plot
row.names(tmA) <- stateNames; colnames(tmA) <- stateNames

#plot the markov chain with plot matrix function
plotmat(tmA,pos = c(1,2),
        lwd = 1, box.lwd = 2,
        cex.txt = 0.8,
        box.size = 0.1,
        box.type = "circle",
        box.prop = 0.5,
        box.col = "light blue",
        arr.length=.1,
        arr.width=.1,
        self.cex = .6,
        self.shifty = -.01,
        self.shiftx = .14,
        main = "Markov Chain")

#========================================
# Extending Markov Models to Forecasting
#========================================

#explore the dataset we will use
help("rain")

#load dataset
data("rain")

#there are 3 states of rainfall: 0 inches, 1-5 inches, and 6+ inches

#find sequence of data (the rain column)
rainseq <- rain$rain

#convert this to a sequence matrix (we'll model our chain this time)
createSequenceMatrix(rainseq)

#The sequence matrix gives us an idea about the quantity of events in all states, but we want to know the probabilities for a transition matrix

#now let's fit a markov chain to the dataset
RainFit <- markovchainFit(data=rainseq, confidencelevel = 0.9, method = "mle")

#What does this new object RainFit look like?
RainFit

#now let's start turning the estimated transition matrix into a graphical model, by subsetting the matrix
RainTM <- RainFit$estimate

#we're going to extract values to start to make a graph like we did for the simple example
a11 <- RainTM[1,1]
a12 <- RainTM[1,2]
a13 <- RainTM[1,3]
a21 <- RainTM[2,1]
a22 <- RainTM[2,2]
a23 <- RainTM[2,3]
a31 <- RainTM[3,1]
a32 <- RainTM[3,2]
a33 <- RainTM[3,3]

#now let's hard code the transition matrix
MyStateNames <- c("No Rain","Light Rain","Heavy Rain")

MatrixOfRain <- matrix(c(a11,a12,a13,a21,a22,a23,a31,a32,a33),nrow=3, byrow=TRUE)

# Let's Plot Our Model again

#set row names
row.names(MatrixOfRain) <- MyStateNames

#set column names
colnames(MatrixOfRain) <- MyStateNames

#round probabilities to 3 decimal places
MatrixOfRain <- round(MatrixOfRain,3)

#plot markov chain transition matrix derived from model
plotmat(MatrixOfRain,pos = c(1,2),
        lwd = 1, box.lwd = 2,
        cex.txt = 0.8,
        box.size = 0.1,
        box.type = "circle",
        box.prop = 0.5,
        box.col = "light blue",
        arr.length=.1,
        arr.width=.1,
        self.cex = .4,
        self.shifty = -.01,
        self.shiftx = .13,
        main = "Markov Chain Transition Matrix")

#Let's do some forecasting

# First define the current state X1

x1 <- matrix(c(1,0,0), nrow=1, byrow=TRUE)

#let's make a prediction based on our model what tomorrow's weather might be
x1 %*% MatrixOfRain

#What about the next week?

#let's define some more days
ra2 <- MatrixOfRain %^% 2
ra3 <- MatrixOfRain %^% 3
ra4 <- MatrixOfRain %^% 4
ra5 <- MatrixOfRain %^% 5
ra6 <- MatrixOfRain %^% 6
ra7 <- MatrixOfRain %^% 7

#day 1 forecast, rounded
cat("Day 1 Forecast")
round(x1%*%MatrixOfRain,3)

#etc

cat("Day 2 Forecast")
round(x1%*%ra2,3)

cat("Day 3 Forecast")
round(x1%*%ra3,3)

cat("Day 4 Forecast")
round(x1%*%ra4,3)

cat("Day 5 Forecast")
round(x1%*%ra5,3)

cat("Day 6 Forecast")
round(x1%*%ra6,3)

cat("Day 7 Forecast")
round(x1%*%ra7,3)

#now let's look at the state after 7 days
ra7=round(ra7,3)

plotmat(ra7,pos = c(1,2),
        lwd = 1, box.lwd = 2,
        cex.txt = 0.8,
        box.size = 0.1,
        box.type = "circle",
        box.prop = 0.5,
        box.col = "light blue",
        arr.length=.1,
        arr.width=.1,
        self.cex = .6,
        self.shifty = -.01,
        self.shiftx = .14,
        main = "The transition matrix after 7 days")
```
Examples drawn from [Rpubs Markov Chain Forecasting](https://rpubs.com/JanpuHou/326048)


### Further reading

[Markov Chains Explained Visually](https://setosa.io/ev/markov-chains/)

[Intro to Markov Chain Monte Carlo](https://towardsdatascience.com/a-zero-math-introduction-to-markov-chain-monte-carlo-methods-dcba889e0c50)

[Bayesian inference problem, MCMC and variational inference](https://towardsdatascience.com/bayesian-inference-problem-mcmc-and-variational-inference-25a8aa9bce29)

---

## Simple Bayesian Networks

Bayesian networks tend to scale very rapidly due to their flexibility, it would be unfeasible to attempt this in a single lesson, but this example dataset should at least get the point across. All variables in the smoking cessation dataset are binary. Continuous distributions of data (like those discussed in Lesson 2), *significantly* increase  necessary compute time.

#### Coronary Dataset from bnlearn

Probable risk factors for coronary thrombosis (aka a heart attack), with data from 1841 male patients.

The coronary data set contains the following 6 variables:

	- Smoking (smoking): a two-level factor with levels no and yes.

	- M. Work (strenuous mental work): a two-level factor with levels no and yes.

	- P. Work (strenuous physical work): a two-level factor with levels no and yes.

	- Pressure (systolic blood pressure): a two-level factor with levels <140 and >140.

	- Proteins (ratio of beta and alpha lipoproteins): a two-level factor with levels <3 and >3.

	- Family (family anamnesis of coronary heart disease): a two-level factor with levels neg and pos.

```R
#================================================
# Setup Dataset
#================================================

# Set Seed number for reproducibility
set.seed(5)

#load bayesian network learn library
library(bnlearn)

#attach coronary dataset (provided with bnlearn)
data(coronary)

#Load coronary dataset as a data frame
bn_df<-data.frame(coronary)

#================================================
# Learning algorithm implementation
#================================================

#learn bayesian network structure by running hill climbing algorithm on
  #the data to be modeled
  #Output the hillclimb results
hc_res <- hc(bn_df)

#plot the hill climb results as graph
plot(hc_res)

#================================================
# Curating Our Model Network
#================================================

#Heuristic curation of graph by removing edge between family and strenuous mental work

#Why? It's unlikely that family history and strenuous mental work are interrelated

#This uses negative indexing in R, and operates on the "arcs", or edges, of the graph

hc_res$arcs <- hc_res$arcs[-which((hc_res$arcs[,'from'] == "M..Work" & hc_res$arcs[,'to'] == "Family")),]

#Plot the graph again and see the edge disappear
plot(hc_res)

#================================================
# Fitting the model
#================================================

#Now let's fit the network with the data
fittedbn <- bn.fit(hc_res, data = bn_df)

#================================================
#Event querying for specific conditions
#================================================

#print output of a Proteins node from the fitted network model, exploring individual node probabilities
  print(fittedbn$Proteins)

#probabilities that a patient exhibits the protein pattern with no smoking
cpquery(fittedbn, event = (Proteins=="<3"), evidence = ( Smoking=="no"))

#probability
cpquery(fittedbn, event = (Proteins=="<3"), evidence = ( Smoking=="no" & Pressure==">140" ) )

cpquery(fittedbn, event = (Pressure==">140"), evidence = ( Proteins=="<3" ) )

bn.fit.xyplot(fittedbn)
```
Note: this example modifies content from Hamed on [Rbloggers](https://www.r-bloggers.com/bayesian-network-in-r-introduction/)

### Further reading

[Another Bayesian Network example with bnlearn](http://gradientdescending.com/bayesian-network-example-with-the-bnlearn-package/)

[Bayesian Networks with Python](https://www.edureka.co/blog/bayesian-networks/)

[Probabilistic Programming with PyMC3](https://peerj.com/articles/cs-55/)
