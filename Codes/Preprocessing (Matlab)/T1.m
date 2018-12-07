clc;
clear;

%EXTRACT RED CHANNEL FROM RGB
rgbimg = imread('img7.jpeg');
%rgbimg = imread('img1.tif');
R = rgbimg(:,:,1);
figure, imshow(rgbimg);

%% REMOVAL OF OPTICAL DISC

%RESIZE THE IMAGE
%grayimg = rgb2gray(R);
grayimg = imresize(R,[600,800]);
original = grayimg;
original2 = grayimg;

%[grayimg, rect] = imcrop(grayimg)
figure, imshow(grayimg);

%MEDIAN FILTER
grayimg = medfilt2(grayimg,[11,11]);
figure, imshow(grayimg);

%contrastAdjusted = imadjust(grayimg);
%figure
%imshow(contrastAdjusted)

%TOP-HAT FILTER 
se = strel('disk', 60);
tophatimg = imtophat(grayimg, se);
figure, imshow(tophatimg);

%CONTRAST STRETCHING
J = imadjust(tophatimg ,stretchlim(tophatimg),[0.01 0.8]);
figure, imshow(J);

%BINARY CONVERTION
BW = im2bw(J,0.7);
figure, imshow(BW);

%MORPHOLOGICAL OPENING AND CLOSING
se = strel('disk', 10);
afterOpening = imopen(BW,se);
%figure, imshow(afterOpening);
closeBW = imclose(afterOpening,se);
figure, imshow(closeBW);

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
          original(i,j) = 0;
       end
    end
end

figure, imshow(original);

