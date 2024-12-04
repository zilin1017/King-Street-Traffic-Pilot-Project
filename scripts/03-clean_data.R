# Load necessary libraries
library(dplyr)


# Create binary variable for Bathurst and Jarvis intersections
data <- data %>%
  mutate(intersection_binary = ifelse(grepl("Bathurst|Jarvis", intersection_name, ignore.case = TRUE), 1, 0))

# Conversion factor variables
data$classification <- as.factor(data$classification)

# Conversion factor variables
data$period_name <- as.factor(data$period_name)

# Logarithmic transformation of the dependent variable
data$log_volume <- log(data$volume + 1)  