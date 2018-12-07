clc;
clear;
cd negative;
imagefiles = dir('*.tif');
imagefiles2 = dir('*.jpg');
nfiles = length(imagefiles)
nfiles2 = length(imagefiles2)
mkdir nconverted;

for ii=1:1
    currentfilename = imagefiles(ii).name;
    
    %EXTRACT RED CHANNEL FROM RGB
    rgbimg = imread(currentfilename);
    R = rgbimg(:,:,1);
    
    %RESIZE THE IMAGE
    resize = imresize(R,[600,800]);
    
    %TOP-HAT AND BOTTOM-HAT FILTER 
    se = strel('square',5);
    TB = imsubtract(imadd(resize,imtophat(resize,se)),imbothat(resize,se));
    
    %MEDIAN FILTER
    median = medfilt2(TB,[45,45]);
    
    %SUBTRACT CONTRAST ENHANCED IMAGE FROM MEDIAN
    for i=1:600
         for j=1:800
            contrastEH(i,j)= median(i,j)-TB(i,j);
        end
    end
    contrastEH = imadjust(contrastEH ,stretchlim(contrastEH),[0.01 0.5]);
    figure, imshow(contrastEH);
    
    %BINARY CONVERTION
    BW = im2bw(contrastEH,0.4);
    figure, imshow(BW);
    
    %MORPHOLOGICAL OPENING AND CLOSING
    se = strel('disk', 1);
    afterOpening = imopen(BW,se);
    %figure, imshow(afterOpening);
    closeBW = imclose(afterOpening,se);
    figure, imshow(closeBW);
    
    filepre='nconverted/img_';
    s=num2str(ii); % i is the image number.
    impath=strcat(filepre,s,'.jpg');
    imwrite(contrastEH,impath);
end

for ii=1:nfiles2
    currentfilename = imagefiles(ii).name;
    
    %EXTRACT RED CHANNEL FROM RGB
    rgbimg = imread(currentfilename);
    R = rgbimg(:,:,1);
    
    %RESIZE THE IMAGE
    resize = imresize(R,[600,800]);
    
    %TOP-HAT AND BOTTOM-HAT FILTER 
    se = strel('square',5);
    TB = imsubtract(imadd(resize,imtophat(resize,se)),imbothat(resize,se));
    
    %MEDIAN FILTER
    median = medfilt2(TB,[45,45]);
    
    %SUBTRACT CONTRAST ENHANCED IMAGE FROM MEDIAN
    for i=1:600
         for j=1:800
            contrastEH(i,j)= median(i,j)-TB(i,j);
        end
    end
    contrastEH = imadjust(contrastEH ,stretchlim(contrastEH),[0.01 0.5]);
    
    %BINARY CONVERTION
    BW = im2bw(contrastEH,0.4);
    
    %MORPHOLOGICAL OPENING AND CLOSING
    se = strel('disk', 1);
    afterOpening = imopen(BW,se);
    %figure, imshow(afterOpening);
    closeBW = imclose(afterOpening,se);
    %figure, imshow(closeBW);
    
    %filepre='nconverted/img_';
    %s=num2str(nfiles+ii); % i is the image number.
    %impath=strcat(filepre,s,'.jpg');
    %imwrite(contrastEH,impath);
end




