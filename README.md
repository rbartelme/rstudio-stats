# rstudio-stats
#### For University of Arizona Data Science Fellow Sprint #2: Classical vs. Bayesian Statistics in R

This repository contains a modified version of the base rstudio docker images to run in
the CyVerse Discovery Environment: <https://de.cyverse.org>

- Installed the following R packages:
  - [vegan](https://cran.r-project.org/web/packages/vegan/index.html)
  - Bayes
  - Etc.

# How to Use This Docker Image on the CyVerse Discovery Environment

## Login to RStudio Instance
	* Wait for container to load
	* When prompted at the login screen enter the username as Rstudio and password as Rstudio1

## Import the data into RStudio instance with iRODS
	* Configure iRODS from the Terminal in RStudio by running the command iinit:
	+ DNS: data.cyverse.org
	+ Port number: 1247
	+ irods zone: iplant
	+ irods user name: cyverse-username
	+ Enter current iRODS password: cyverse-password
	* Change to the directory with the hapmap file:
	+ icd /iplant/home/shared/terraref/genomics/derived_data/bap/resequencing/danforth_center/version1/hapmap
	* Get the data into RStudio container environment (NOTE: This may take some time)
	+ iget -K all_combined_genotyped_lines_SNPS_052217.recalibrated_vcftools.filtered.recode.hmp.txt (this will take a while)
	+ After loading file, rename with mv to sorghumhap.hmp.txt
 
###For more information on iRODS commands, see:
https://https://wiki.cyverse.org/wiki/display/DS/Using+iCommands
 
