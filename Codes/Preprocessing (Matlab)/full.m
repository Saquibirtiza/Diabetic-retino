clc;
clear;
cd negative;
mkdir noriginal;
imagefiles = dir('*.tif');
imagefiles2 = dir('*.jpg');
nfiles = length(imagefiles);
nfiles2 = length(imagefiles2);

for ii=1:nfiles
    currentfilename = imagefiles(ii).name;
    
    rgbimg = imread(currentfilename);
    %imshow(R);
    
    filepre='noriginal/img_';
    s=num2str(ii); % i is the image number.
    impath=strcat(filepre,s,'.jpg');
    imwrite(rgbimg,impath);
end

for ii=1:nfiles2
    currentfilename = imagefiles(ii).name;
    
    rgbimg = imread(currentfilename);
    %imshow(R);
    
    filepre='noriginal/img_';
    s=num2str(ii+nfiles); % i is the image number.
    impath=strcat(filepre,s,'.jpg');
    imwrite(rgbimg,impath);
end

cd ..




