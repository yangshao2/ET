% set working directory
cd 'C:/lydia/LC_ET'

%import et and land cover data; Note they need to have the sample dimension
et=imread('ET169_2.tif');
lc=imread('lc.tif');

%extract et values for each land cover type (1-5);
et_lc1 = et(lc==1);
et_lc2 = et(lc==2);
et_lc3 = et(lc==3);
et_lc4 = et(lc==4);
et_lc5 = et(lc==5);

% Concatenate all data into a single vector
allData = [et_lc1; et_lc2; et_lc3; et_lc4; et_lc5];

% Create a vector indicating group membership
group = [ones(size(et_lc1)); 2*ones(size(et_lc2)); 3*ones(size(et_lc3));4*ones(size(et_lc4)); 5*ones(size(et_lc5))];

% Use boxplot with group labels
boxplot(allData, group,'notch','on')


%You may also generate samples from dataset. 
sampleSize = 1000; % Sample size
et_lc1_sample = datasample(et_lc1, sampleSize);
et_lc2_sample = datasample(et_lc2, sampleSize);
et_lc3_sample = datasample(et_lc3, sampleSize);
et_lc4_sample = datasample(et_lc4, sampleSize);
et_lc5_sample = datasample(et_lc5, sampleSize);
allData = [et_lc1_sample et_lc2_sample et_lc3_sample et_lc4_sample et_lc5_sample]
boxplot(allData, 'notch','on')


% Create a box plot of the sampled data
boxplot(sampleData, 'notch', 'on');
title('Box Plot of Sampled Data');
