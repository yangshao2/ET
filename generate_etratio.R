library(raster)
library(rgdal)

setwd("~/work/lydia")

filelist<-list.files('./eeflux',pattern='.tif')

for (i in 1:length(filelist)){
  eeflux_file<-paste0('./eeflux/',filelist[i])
  eta<-raster(eeflux_file)
  #create a pattern (partical file name)
  namepattern<-paste0('./etr_gridmet/p*',substr(filelist[i],12,15),"_",substr(filelist[i],16,18),'*')
  #list etr file matching the file name pattern
  etr_file<-Sys.glob(namepattern)
  etr<-raster(etr_file)
  #compute ratio of eta and etr
  et_ratio<-eta/etr
  outfile<-paste0('./et_ratio/etratio',substr(filelist[i],12,15),'_',substr(filelist[i],16,18),'.tif')
writeRaster(et_ratio,outfile,overwrite=T)
  }
  