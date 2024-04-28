library(sf)
library(raster)
library(spgwr)
library(sp)

points_sf <- st_read("rpnew.shp")
coords <- st_coordinates(points_sf)

# Add coordinates to the original sf object as new columns
points_sf$lon <- coords[, "X"]
points_sf$lat <- coords[, "Y"]

twi<-raster('twi.tif')
# Extracting raster values
twi_value <- extract(twi, points_sf)
points_sf$twi<-twi_value

# Convert sf object to data frame and drop geometry
df <- as.data.frame(points_sf, drop = TRUE)

#remove nodata
df<-na.omit(df)

# gwr bandwidth
bandwidth <- gwr.sel(et_v ~ dem_v + slope_v + aspect_v + forest_v+ ag_v + urban_v + twi, data=df, coords=cbind(df$lon, df$lat))

# Fit the GWR model
gwr_model <- gwr(et_v ~ dem_v + slope_v + aspect_v + forest_v+ ag_v + urban_v +twi , data=df, bandwidth=bandwidth, coords=cbind(data_df$lon, data_df$lat), hatmatrix=TRUE)

