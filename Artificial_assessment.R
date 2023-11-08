# Your submission should be published to a GitHub repository with a README with
# instructions on how to run the program and how to run the tests.

#### load packages ####
library( jsonlite) # to read JSON file
library( dplyr) # for rapid manipulation

##### Earthquakes ####

get_earthquakes <- function( date = Sys.time()) {
  
  # consideration needs to be made regarding the users time of access, therefore accessing the system date is required
  set_date <- as.Date( date)
  last_30_days <- as.Date( set_date) - 30
  
  # Download data
  download.file(url = paste("https://earthquake.usgs.gov/fdsnws/event/1/query.geojson?starttime=", last_30_days, "&endtime=", set_date, sep = ""), destfile = "~/Data/Artificial/30_days_data.json")
  
  # Read data
  all_30_days <- fromJSON(txt = "~/Data/Artificial/30_days_data.json")
  
  # Filter by using dplyr. One can rapidly 'cut corners' but using code freely available in different libraries
  recent_earthquakes <- all_30_days$features$properties %>%
    filter(mag > 4.5 & type == "earthquake") %>% # Greater than magnitude 4.5.
    filter(!grepl(x = place, pattern = "Afghanistan")) %>% # Do not include Afghanistan.
    arrange(desc(time)) %>% # Sorted by timestamp (descending).
    mutate(time = as.POSIXct(time / 1000, origin = "1970-01-01")) %>% # converted the time to check the arrange() call and increase readability 
    head(3)  # Only print the top 3 in that list.
  
  # I have not refined the output columns as the user may require all the information in the table
  
  return(recent_earthquakes)
}

##### Tsunamis ####

tsunamis <- all_30_days$features$properties %>% 
  filter(tsunami == 1)  # include the total number of tsunamis across all events in the last 30 days

tsunamis[which.max(tsunamis$sig),]$place # print the location of the event with the largest significance/impact

#### Tests ####

library( testthat)

# Call the function with custom date
get_earthquakes( date = "2023-02-04")

# Call the function with default date (Sys.time())
get_earthquakes()

context("Earthquakes")

test_that("get_earthquakes", code = {
  result <- get_earthquakes(date = "2023-02-04")
  
  # Check the result returns a magnitude of more than 4.5
  expect_true(all(result$mag > 4.5))
  
})

test_that("get_earthquakes", code = {
  result <- get_earthquakes(date = "2023-02-04")
  
  # Check the result does not return Afghanistan
  expect_true(all(!grepl("Afghanistan", result$place)))
  
})





