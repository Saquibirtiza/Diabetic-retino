clc;
clear;
cd positive;
imagefiles = dir('*.tif');
imagefiles2 = dir('*.jpg');
nfiles = length(imagefiles)
nfiles = length(imagefiles2)

mkdir converted;

for ii=1:10
    currentfilename = imagefiles(ii).name;
    
    %EXTRACT RED CHANNEL FROM RGB
    rgbimg = imread(currentfilename);
    R = rgbimg(:,:,1);
    imshow(R);
    
    filepre='converted/img_';
    s=num2str(ii); % i is the image number.
    impath=strcat(filepre,s,'.jpg');
    imwrite(R,impath);
end




