library(terra)
library(rgdal)
#all et_ref images (tifs) should be in the folder
etr_path<-"C:/lydia/gridmet/"

#setwd 
#setwd("C:/etdata1435/resampled_files")
filelist<-Sys.glob('*.tif')

# Create an output folder for resampled files
outputFolder <- "../etratio"
if (!dir.exists(outputFolder)) {
  dir.create(outputFolder)
}


for (i in 1:length(filelist)){
doy<-substr(filelist[i],14,16)
year<-substr(filelist[i],10,13)

a<-rast(filelist[1])

et_ref<-paste0(etr_path,"etr_",year,"_",doy,".tif")
r<-rast(et_ref)
r_p <- project(r, a)
et_ratio <- a/r_p

outfile<-paste0(outputFolder,'/etratio_',year,'_',doy,'.tif')
writeRaster(et_ratio,outfile,overwrite=T)
}
