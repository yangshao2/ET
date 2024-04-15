library(raster)
library(sf)
library(rgdal)
library(dplyr)
library(terra)

setwd('/media/newhd/yshao/va/')
a<-st_read('alltiles.shp')

newshape<-st_read('et_studyarea.shp')
newshape_proj<-st_transform(newshape,st_crs(a))


intersection_result <- st_intersection(a,newshape_proj)
tilelist<-intersection_result$tile

pattern1<-paste0(tilelist[1],'.tif$')
files <- list.files(pattern = pattern1, full.names = TRUE, recursive = TRUE)

for (i in 1:length(tilelist)){
  pattern1<-paste0(tilelist[i],'.tif$')
  tif_files <- list.files(pattern = pattern1, full.names = TRUE, recursive = TRUE)
  files<-c(files,tif_files)
}


for (i in 1:length(files)){
  source_file<-files[i]
destination_file <- paste0("/media/newhd/yshao/va/t",i,'.tif')
file.copy(source_file, destination_file)
}
