# Lesson 4: Bayesian Networks

### Goal: Build a simple Bayesian Network
	- Apply probability knowledge from Lesson 3 on more complex data
	- Explore hill climbing as a learning method
	- Learn network graph plotting in R

Note: this lesson modifies content from Hamed on [Rbloggers](https://www.r-bloggers.com/bayesian-network-in-r-introduction/)



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
#learn bayesian network structure by running hill climbing algothim on 
  #the data to be modeled
  #Output the hillclimb results
hc_res <- hc(bn_df)
#plot the hill climb results as graph
plot(hc_res)
#Heuristic curation of graph by removing link between family and work
#why? you don't generally work with family, so this seems an improbable link
#This uses negative indexing in R, and operates on the "arcs" of the graph
hc_res$arcs <- hc_res$arcs[-which((hc_res$arcs[,'from'] == "M..Work" & hc_res$arcs[,'to'] == "Family")),]
#Plot the graph again and see the link disappear
plot(hc_res)
#Now let's fit the network with the data
fittedbn <- bn.fit(hc_res, data = bn_df)

#print output of a Proteins node from the fitted network model
  print(fittedbn$M..Work)

#Network inference
cpquery(fittedbn, event = (Proteins=="<3"), evidence = ( Smoking=="no"))

cpquery(fittedbn, event = (Proteins=="<3"), evidence = ( Smoking=="no" & Pressure==">140" ) )

cpquery(fittedbn, event = (Pressure==">140"), evidence = ( Proteins=="<3" ) )
bn.fit.xyplot(fittedbn)

```


