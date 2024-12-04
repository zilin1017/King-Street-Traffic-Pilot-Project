library("opendatatoronto")
library("dplyr")

# get all resources for this package
resources <- list_package_resources("c6a251fb-e5dc-4d9e-803a-8941501d94a3")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))
data <- filter(datastore_resources, row_number()==1) %>% get_resource()
selected_data <- data[, c("intersection_name", "classification", "period_name", "volume")]
set.seed(42)
unique_intersections <- unique(selected_data$intersection_name)
test_intersections <- sample(unique_intersections, size = length(unique_intersections) * 0.2) 
simulate_data <- selected_data[selected_data$intersection_name %in% test_intersections, ]
write.csv(simulate_data, "simulate_data.csv")
