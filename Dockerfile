FROM cyversevice/rstudio-base:latest

#install R packages for lessons
RUN R -e 'install.packages(c("prob","BayesFactor", "bnlearn", "ggplot2", "vegan", "dplyr", "knitr", "pwr"), dependencies = TRUE)'
#install BAS library
RUN R -e 'install.packages("BAS", dependencies = TRUE)'
#shell entrypoint
RUN chmod +x /usr/local/bin/run.sh
