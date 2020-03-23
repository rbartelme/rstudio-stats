FROM cyversevice/rstudio-base:latest

#install R packages for lessons
RUN Rscript -e 'install.packages(c("BayesFactor","bnlearn","ggplot2","vegan"), dependencies = TRUE)'
