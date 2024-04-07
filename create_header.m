%create header files for the above et_estimates
% Define the source file you want to copy
sourceFile = './temp/template.hdr';
% Loop through, create new filenames, and copy the file
for i = 1:365
    doynew=sprintf('%03d', i)
    newFilename = sprintf('./eta_estimate/eta_%s.hdr',doynew);
    
    % Copy the source file to the new filename
    copyfile(sourceFile, newFilename);
end