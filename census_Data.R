###Test script to pull and plot census data
# Written by: Ayman Alafifi
# Date: 01/16/2020


# Load Packages -----------------------------------------------------------
library(tidycensus) 
library(tidyverse)
library(mapview)
options(tigris_use_cache = TRUE)


# Load API Key ------------------------------------------------------------
# You need to request an API key from this website:
# http://api.census.gov/data/key_signup.html
# The link will send you a key and a link to activate the key
# Make sure you click on the link to activate the key

api_key <- "aace908b2ef975e4ca556a682cf9ee45366e4e0f"
census_api_key(api_key, install = TRUE)


# Find desired census variable --------------------------------------------
Cen2018 <- load_variables(2018, "acs5", cache = TRUE) #Loads a list of all variables in 2018 census
View(Cen2018) #view variables

# Fetch Census data -------------------------------------------------------
King <- get_acs(geography = "tract", 
               variables = "B19019_003", 
               state = "WA", 
               county = "King", 
               geometry = TRUE, 
               cb = FALSE)

# Create a simple map ----------------------------------------------------------
mapview(King, zcol = "estimate", legend = TRUE) #"estimate is the field with values


# Write to a shapefile -------------------------------------------------------
library(sf)
st_write(King, "King.shp")
