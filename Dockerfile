FROM cyversevice/rstudio-base:latest

#install R packages for lessons
RUN R -e 'install.packages(c("BayesFactor", "bnlearn", "ggplot2", "vegan", "traits", "dplyr", "knitr"), dependencies = TRUE)'
#shell entrypoint
RUN chmod +x run.sh
