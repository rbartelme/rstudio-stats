FROM cyversevice/rstudio-base:latest

#install R packages for lessons
RUN R -e 'install.packages(c("BayesFactor", "bnlearn", "ggplot2", "vegan", "dplyr", "knitr", "pwr"), dependencies = TRUE)'
#shell entrypoint
RUN chmod +x /usr/local/bin/run.sh
