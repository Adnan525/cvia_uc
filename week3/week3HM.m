clear variables;
close all;
clc;
frame = imread("DINGO3_Frame0.jpeg");
bg = imread("DINGO3_Background.jpeg");
diff = frame - bg;

lowestPixelValue = min(min(diff))/255.0;
maxPixelValue = max(max(diff))/255.0;
disp(lowestPixelValue);
disp(maxPixelValue);

imshow(diff)

% Display difference image with rescaling
rescaledDiffImg = imadjust(diff,[lowestPixelValue(1) lowestPixelValue(2) lowestPixelValue(3); 
                    maxPixelValue(1) maxPixelValue(2) maxPixelValue(3)],[]);
figure(4);
imshow(rescaledDiffImg);
