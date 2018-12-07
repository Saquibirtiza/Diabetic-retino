clc;
clear;
cd positive;
mkdir pprocessed;
imagefiles2 = dir('*.jpg');
nfiles2 = length(imagefiles2);


for ii=1:nfiles2
    currentfilename = imagefiles2(ii).name;
    
    rgbimg = imread(currentfilename);
    R = rgbimg(:,:,1);
    %figure, imshow(rgbimg);

    % REMOVAL OF OPTICAL DISC

    %RESIZE THE IMAGE
    %grayimg = rgb2gray(R);
    grayimg = imresize(R,[600,800]);
    original = imresize(rgbimg,[600,800]);

    %[grayimg, rect] = imcrop(grayimg)
    %figure, imshow(grayimg);

    %MEDIAN FILTER
    grayimg = medfilt2(grayimg,[11,11]);
    %figure, imshow(grayimg);

    %contrastAdjusted = imadjust(grayimg);
    %figure
    %imshow(contrastAdjusted)

    %TOP-HAT FILTER 
    se = strel('disk', 60);
    tophatimg = imtophat(grayimg, se);
    %figure, imshow(tophatimg);

    %CONTRAST STRETCHING
    J = imadjust(tophatimg ,stretchlim(tophatimg),[0.01 0.8]);
    %figure, imshow(J);

    %BINARY CONVERTION
    BW = im2bw(J,0.7);
    %figure, imshow(BW);

    %MORPHOLOGICAL OPENING AND CLOSING
    se = strel('disk', 10);
    afterOpening = imopen(BW,se);
    %figure, imshow(afterOpening);
    closeBW = imclose(afterOpening,se);
    %figure, imshow(closeBW);

    count=0;
    x=0;
    y=0;
    for i=1:600
        for j=1:800
            if closeBW(i,j) >  0
            x=x+i;
            y=y+j;
            count = count +1;
            end
        end
    end

    x=ceil(x/count);
    y=ceil(y/count);

    for i=1:600
        for j=1:800
            t1 = (i-x).^2;
            t2 = (j-y).^2;
            dist = sqrt(t1+t2);
            if dist < 50
               original(i,j,:) = 0;
            end
        end
    end

    %figure, imshow(original);
    
    filepre='pprocessed/img_';
    s=num2str(ii); % i is the image number.
    impath=strcat(filepre,s,'.jpg');
    imwrite(original,impath);
end

cd ..
