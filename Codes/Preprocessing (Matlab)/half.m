clc;
clear;
cd negative;
mkdir nshortened3;
%imagefiles = dir('*.tif');
imagefiles2 = dir('*.jpg');
%nfiles = length(imagefiles);
nfiles2 = length(imagefiles2);
%nfiles = nfiles/2;
nfiles2 = nfiles2/2;

%arr = rand(1,nfiles);
arr2 = rand(1,nfiles2);

%arr = arr*nfiles;
arr2 = arr2*nfiles2;

%arr = ceil(arr);
arr2 = ceil(arr2);

for ii=1:nfiles2
    ind = arr2(ii);
    %if ind <= 334
    currentfilename = imagefiles2(ind).name;
    
    rgbimg = imread(currentfilename);
    %imshow(R);
    
    %filepre='pshortened2/img_';
    filepre='nshortened3/';
    s=num2str(ii); % i is the image number.
    impath=strcat(filepre,currentfilename);
    imwrite(rgbimg,impath);
    %end
end

cd ..




