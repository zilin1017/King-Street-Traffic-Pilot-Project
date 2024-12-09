#### Preamble ####
# Purpose: Test the simulated dataset.
# Author: Irene Liu
# Date: 20 November 2024
# Contact: liuzilin.liu@mail.utornto.ca
# License: MIT
# Pre-requisites: The `opendatatorotno` and `dplyr` packages must be installed to load data.

## Test the test data set to see if "intersection_name" contains Bathurst or Jarvis, 
## and what the proportion is. 
## If it does, it is recorded as 1, otherwise it is recorded as 0

simulate_data$contains_bathurst_or_jarvis <- ifelse(
  grepl("Bathurst|Jarvis", test_data$intersection_name, ignore.case = TRUE), 1, 0
)

## Statistical proportion
proportion <- mean(simulate_data$contains_bathurst_or_jarvis)
## 0.4395604
