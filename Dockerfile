FROM cyversevice/rstudio-base:latest

#install R packages for lessons 
RUN Rscript =e 'install.packages("BayesFactor","ggplot2","vegan")'

