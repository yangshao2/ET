%nevigatge to your working diretory (et_ratio) 

files = dir('*.tif')
temp=[];
for i = 1:length(files)
    
    fprintf('%s\n', files(i).name);

startPos = 13; % Starting position
endPos = 15; % Ending position

% Extracting the substring from filename; here we extract DOY and save to
% an array
substr = (extractBetween(files(i).name, startPos, endPos));
index(i)=str2double(substr{1});

%read all tif files; reshape each file to a single column; put them into a
%big matrix;
a=imread(files(i).name);
[r c]=size(a);
temp=[temp reshape(a,r*c,1)];

end

%sort columns by anotehr array (i.e., index)
[~, sortedIndices] = sort(index);  % Sort index arracy to get sorting indices
sorted_temp = temp(:, sortedIndices);  % Use indices to sort columns of temp
sorted_temp(sorted_temp<0)=-1;


%Linear or spline Interpolation
[r c]=size(sorted_temp)
doy=index(sortedIndices);
doy_twoyear=[doy doy+365];
%bigtemp includes all zeros ininitally. We'll save estimated daily
%ET_Ratio in bigtemp matrix
bigtemp=zeros(r,365);

for i=1:r
    
u=sorted_temp(i,:);
[rr cc]=size(u(u>-1)); %find out how many valid data points in the time-series
if cc>=20
    i
    %create a time-series with 2 years' ET ratio values (replicates)
etratio_twoyear=[u u];
dd=[doy_twoyear' etratio_twoyear'];
%remove nodata (nodata was coded as -1);
dd=dd(dd(:,2)>-1,:);

yi_spline = interp1(dd(:,1), dd(:,2), 1:365, 'linear'); 
bigtemp(i,:)=yi_spline;
end
end