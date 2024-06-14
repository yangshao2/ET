library(terra)
library(sf)
#setting working directory 
setwd("C:/etdata1435")

#list all tif files
filelist<-Sys.glob('*C2.tif')
#use the first image as reference
ref<-rast(filelist[1])

# Create an output folder for resampled files
outputFolder <- "resampled_files"
if (!dir.exists(outputFolder)) {
  dir.create(outputFolder)
}

#Copy the first tif (or reference file) to the same output folder
referenceOutputFileName <- file.path(outputFolder, paste0(tools::file_path_sans_ext(basename(filelist[1])), "_resampled.tif"))
file.copy(filelist[1], referenceOutputFileName, overwrite = TRUE)

# Loop through each TIF file and resample it to match the reference grid
for (i in 2:length(filelist)) {
  # Read the current TIF file
  currentRaster <- rast(filelist[i])
  
  # Resample the current raster to match the reference raster
  resampledRaster <- resample(currentRaster,ref, method = "near")
  
  # Create the output filename
  outputFileName <- file.path(outputFolder, paste0(tools::file_path_sans_ext(basename(filelist[i])), "_resampled.tif"))
  
  # Write the resampled raster to a new file
  writeRaster(resampledRaster, outputFileName, overwrite = TRUE)
}

print("Resampling completed.")
