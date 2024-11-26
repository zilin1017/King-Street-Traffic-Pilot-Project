#### Download data ####

# install.packages("opendatatoronto")
library("opendatatoronto")
# install.packages("dplyr")
library("dplyr")

# get package
package <- show_package("c6a251fb-e5dc-4d9e-803a-8941501d94a3")
package

# get all resources for this package
resources <- list_package_resources("c6a251fb-e5dc-4d9e-803a-8941501d94a3")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()
data
