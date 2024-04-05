# Install packages if you haven't already
install.packages("raster")
install.packages("ncdf4")

# Load the libraries
library(raster)
library(ncdf4)


# Replace "etr_2019.nc" with your NetCDF file
inputfile <- 'etr_2019.nc'
ncFile <- brick(inputfile)
# Get the number of days (or time steps) in the dataset
numDays <- dim(ncFile)[3]

# Loop through each day
for (day in 1:numDays) {
  # Extract the raster for the specific day
  dailyRaster <- raster(inputfile, band = day)
  # Create a file name for the TIFF
  # This example creates a name like "etr_2001_001.tif", "etr_2001_002.tif", etc.
  tiffName <- paste0(substr(inputfile,1,8),sprintf("_%03d.tif", day))
  
  # Write the daily raster to a TIFF file
  writeRaster(dailyRaster, filename = tiffName, format = "GTiff", overwrite = TRUE)
}



