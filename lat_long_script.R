# This script is a slightly modified version of the original here: 
# http://www.storybench.org/geocode-csv-addresses-r/

# Geocoding a csv column of "addresses" in R

#load ggmap
library(ggmap)
library(tidyverse)

# Read in the CSV data and store it in a variable 
origAddress <- read.csv("infected_data.csv", stringsAsFactors = FALSE)

# Initialize the data frame
geocoded <- data.frame(stringsAsFactors = FALSE)

#Google api key (hidden for obvious reasons)

register_google(key = "***************************************")

# Loop through the addresses to get the latitude and longitude of each address and add it to the
# origAddress data frame in new columns lat and lon
for(i in 1:nrow(origAddress))
{
  # Print("Working...")
  result <- geocode(origAddress$Province.State[i], output = "latlona", source = "google")
  origAddress$lon[i] <- as.numeric(result[1])
  origAddress$lat[i] <- as.numeric(result[2])
  origAddress$geoAddress[i] <- as.character(result[3])
}
# Write a CSV file containing origAddress to the working directory
write.csv(origAddress, "infected_data_coords.csv", row.names=FALSE)
