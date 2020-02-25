FROM cyversevice/rstudio-base:latest

#install R packages for lessons 
RUN Rscript =e 'install.packages("BayesFactor","bnlearn","ggplot2","vegan")'

