clear variables;
close all;
clc;
myImg = imread("chocolate_original.jpg");
% figure(1);
% subplot(3, 4, 1);
% imshow(myImg);

newImg = imresize(myImg,[480, 640]);
% figure(2)
% imshow(newImg)
imwrite(newImg, "newImg.jpg");
[r,g,b] = imsplit(newImg);
figure(2);
subplot(1,3,1);
imshow(r);
subplot(1,3, 2);
imshow(g);
subplot(1,3,3);
imshow(b);
title("RGB channels");
testImage = rgb2gray(newImg);
% figure(3);
% imshow(testImage);

% q5 threshold
level = graythresh(testImage);
BW = imbinarize(testImage, level);
figure(4);
% imshow(BW);

% q6
fprintf("threhold for r is %f\n", graythresh(r))
fprintf("threhold for g is %f\n", graythresh(g))
fprintf("threhold for b is %f\n", graythresh(b))

% q7
% for iI = 0.0:0.01:1.0 
%     thresholdedImg = imbinarize(testImage, iI); 
%     figure(5); 
%     imshow(thresholdedImg); 
%     pause(0.05); 
% end 

% q8
% histogram(testImage)
% imhist(testImage)
imhist(b);
figure(6)
t1 = imbinarize(b, 80/255);
t2 = imbinarize(b, 36/255);
text = t1-t2;
imshow(text)
