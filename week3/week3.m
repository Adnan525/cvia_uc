clear variables;
close all;
clc;
myImg = imread("barcode_cropped.jpg");
[r, g, b] = imsplit( myImg);
greyImage = rgb2gray(myImg);
images = {r,g,b,greyImage};
montage({r,g,b},'Size',[1 3])

for i = 1: length(images)
    figure(i);
    im_ = images{i}; 
    imhist(im_);
end

% figure(2)
% imhist(r)
% figure(3)
% imhist(g)
% figure(4)
% imhist(b)
% figure(5)
% imhist(greyImage)

% histeq
rEq = histeq(r);
gEq = histeq(g);
bEq = histeq(b);
figure(2)
montage({rEq,gEq,bEq},'Size',[1 3])

% back to rgb
newMyImg = cat(3, rEq, gEq, bEq);
figure(3);
montage({myImg, newMyImg}, "Size", [1 2]);

% edge detection
% only works for grey
canny_img = edge(greyImage, "sobel");
figure(6)
imshow(canny_img);
