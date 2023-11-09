# Earthquake_analysis

A programme to extract significant earthquakes for the past 30 days which are:
○ Greater than magnitude 4.5.
○ Sorted by timestamp (descending).
○ Only print the top 3 in that list.
○ Do not include Afghanistan.

Separately, I have included the total number of tsunamis across all events in the last 30 days for the same data set.
Finally, the programme returns the location of the tsunami with the largest significance/impact.

The code in R represents the core part of the application. To run either download the .R script and run in R studio or in the command line using 'Rscript Artificial_assessment.R'.

To run tests.R either download the .R script and run in R studio or in the command line using 'Rscript tests.R' in your current directory. 

Input: N/A

The outputs are R objects as data frames

Requirements:
R version > 3.6.2 
jsonlite installed, see https://cran.r-project.org/web/packages/jsonlite/index.html
dplyr installed, see https://cran.r-project.org/web/packages/dplyr/index.html
