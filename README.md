# rstudio-stats
#### For University of Arizona Data Science Fellow Sprint #2: Classical vs. Bayesian Statistics in R


Bayes' Theorem:
<br>
<img src="https://render.githubusercontent.com/render/math?math=P(A \mid B) = \frac{P(B \mid A) \, P(A)}{P(B)}">
<br><br>
**VS.**
<br><br>
Lindeberg-Levy Central Limit Theorem:
<br>
<img src="https://wikimedia.org/api/rest_v1/media/math/render/svg/883b2b657efe266f298d80f8f6ae876b101307e3">


This repository contains a modified version of the base rstudio docker images to run in
the CyVerse Discovery Environment: <https://de.cyverse.org>

- Installed the following R packages:
  - [prob](https://cran.r-project.org/web/packages/prob/index.html): Elementary Probability on Finite Sample Spaces
  - [vegan](https://cran.r-project.org/web/packages/vegan/index.html): Community Ecology Statistics Package
  - [BayesFactor](https://cran.r-project.org/web/packages/BayesFactor/index.html): Computation of Bayes Factors for Common Designs
  - [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html): Create Visualizations with the Grammar of Graphics
  - [bnlearn](https://cran.r-project.org/web/packages/bnlearn/index.html): Bayesian Network Structure Learning, Parameter Learning & Inference
  - [BAS](https://cran.r-project.org/web/packages/BAS/index.html): Bayesian Variable Selection and Model Averaging using Bayesian Adaptive Sampling
  - [pwr](https://cran.r-project.org/web/packages/pwr/index.html): Basic Functions for Power Analysis 

# How to Use This Docker Image on the CyVerse Discovery Environment

## Spin up container for VICE

This should be shared with your CyVerse account, if not, please let me know.

## Login to RStudio Instance
	- Wait for container to load
	- When prompted at the login screen enter the username as rstudio and password as rstudio1
