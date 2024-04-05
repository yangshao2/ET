library(rgdal)
library(raster)

sproj<-readOGR('.',layer='studyarea')

# Your rasterLayer or SpatialGridDataFrame object
for (year in 2001:2001)
{
  filepath<-paste('C:/swat/etdata1633/y',year,sep='')
  setwd(filepath)
  filelist<-list.files('.',pattern='*ETa_C2.tif$')
  for (i in 1:length(filelist)){
  etimage<-raster(filelist[i])
  image_clip<-crop(etimage,sproj)
  image_clip<-mask(image_clip,sproj)
  outfilename <- paste0("s_",filelist[i],sep='')
  print(outfilename)
  writeRaster(image_clip,outfilename,overwrite=T)
}
}