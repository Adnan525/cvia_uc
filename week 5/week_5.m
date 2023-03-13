clear variables;    % This is similar to 'clear all' but more efficient.
close all;
clc;

% Load image
myImgBarcode = imread('barcode.jpg');
figure(1);
% subplot(2, 4, 1);
% imshow(myImgBarcode);
% title('Original Image');

barcodeGray = rgb2gray(myImgBarcode);
% subplot(2, 4, 2);
% imshow(barcodeGray);
% title('Grascale');

% barcodeEdgeSobel = edge(barcodeGray,"sobel");
% subplot(2, 4, 3);
% imshow(barcodeEdgeSobel);
% title('Sobel');

barcodeEdgeCanny = edge(barcodeGray,"canny");
figure(1)
imshow(barcodeEdgeCanny);
title('Canny');

% hough
[H, T, R] = hough(barcodeEdgeCanny, "RhoResolution", 0.5, "Theta", -90:0.5:89);

% Display the Hough matrix (rho and theta value pairs) 
subplot(2,3,4); 
imshow(imadjust(mat2gray(H)),'XData',T,'YData',R,'InitialMagnification','fit'); 
title('Hough Transform'); 
xlabel('\theta'), ylabel('\rho'); 
axis on, axis normal, hold on; 
colormap(hot); 
