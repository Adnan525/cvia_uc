% Background subtraction example on thermal images
% Author: Roland Goecke, (c) 2018
clear variables;    % This is similar to 'clear all' but more efficient.
close all;
clc;
% Load images *** Change file path to your current settings ***
backgroundImg = imread('DINGO3_Background.jpeg');
dingoImg = imread('DINGO3_Frame0.jpeg');
% Compute difference image
% (Literally, subtract the background image from the current image.)
diffImg = dingoImg - backgroundImg;
% Find the minimum pixel value. Divide by 255 as we will need this value
% to be in the range of 0 to 1.
minPixelValue = double(min(min(diffImg)))/255.0;
disp('Min Pixel Value for Red, Green, Blue channels:');
disp(minPixelValue);
% Find the maximum pixel value. Divide by 255 as we will need this value
% to be in the range of 0 to 1.
maxPixelValue = double(max(max(diffImg)))/255.0;
disp('Max Pixel Value for Red, Green, Blue channels:');
disp(maxPixelValue);
% Display difference image with rescaling
rescaledDiffImg = imadjust(diffImg, ...
                    [minPixelValue(1) minPixelValue(2) minPixelValue(3); ...
                     maxPixelValue(1) maxPixelValue(2) maxPixelValue(3)], ...
                 []);
% Convert into greyscale image
greyDiffImg = rgb2gray(rescaledDiffImg);
% Threshold image - Experiment with different threshold values!
level = graythresh(greyDiffImg);
thresholdedImg = imbinarize(greyDiffImg, level);
thresholdedImg1 = imbinarize(greyDiffImg, 0.1);
montage({thresholdedImg, thresholdedImg1});

% Dilation adds pixels to the boundaries of objects in an image, 
% while erosion removes pixels on object boundaries. The number of pixels added or removed 
% from the objects in an image depends on the size and shape of the structuring element 
% used to process the image.

% Create a vertical line shaped structuring element.
% se = strel('line',11,90);
se = strel("disk", 4, 4);
dilatedImage = imdilate(thresholdedImg, se);
imshow(dilatedImage);
erodedImage = imerode(thresholdedImg, se);
imshow(erodedImage);
% Multiply the matrices by using the element-wise multiplication operator . * . 
% This operator multiplies each element of the first matrix by 
% the corresponding element of the second matrix.
maskedImage = dingoImg .*cast(thresholdedImg1, "uint8");
imshow(maskedImage);