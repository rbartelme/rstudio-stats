# rstudio-stats
#### For University of Arizona Data Science Fellow Sprint #2: Classical vs. Bayesian Statistics in R


Bayes' Theorem
<img src="https://render.githubusercontent.com/render/math?math=P(A \mid B) = \frac{P(B \mid A) \, P(A)}{P(B)}">
vs.
<img src="https://wikimedia.org/api/rest_v1/media/math/render/svg/fda934052c42d3797714ecd1eaa90910e9f6e050">


This repository contains a modified version of the base rstudio docker images to run in
the CyVerse Discovery Environment: <https://de.cyverse.org>

- Installed the following R packages:
  - [vegan](https://cran.r-project.org/web/packages/vegan/index.html)
  - [BayesFactor](https://cran.r-project.org/web/packages/BayesFactor/index.html)
  - [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html)

# How to Use This Docker Image on the CyVerse Discovery Environment

## Login to RStudio Instance
	- Wait for container to load
	- When prompted at the login screen enter the username as Rstudio and password as Rstudio1

## Import the data into RStudio instance with iRODS
- Configure iRODS from the Terminal in RStudio by running the command iinit:
	- DNS: data.cyverse.org
	- Port number: 1247
	- irods zone: iplant
	- irods user name: cyverse-username
	- Enter current iRODS password: cyverse-password
	- Load a test dataset for the stats class

###For more information on iRODS commands, see:
https://https://wiki.cyverse.org/wiki/display/DS/Using+iCommands
 
