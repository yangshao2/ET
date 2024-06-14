Step1: resample all ET data using R_resample.R 
Results will be saved in a folder named as resampled_files

Step2: Download et_ref from Gridmet 
https://www.northwestknowledge.net/metdata/data/

Step3: extract daily ET from nc files 
extract_dailyetr_from_gridmet.R

Step4: calculate et ratio or fraction (eta/etref)
generate_etratio.R
