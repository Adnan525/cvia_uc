% Image thresholding is a simple, 
% yet effective, way of partitioning an image 
% into a foreground and background. 
% This image analysis technique is a type of 
% image segmentation that isolates objects 
% by converting grayscale images into 
% binary images. 
% Image thresholding is most effective 
% in images with high levels of contrast.

clear variables;
close all;
clc;
myImg = imread("chocolate_original.jpg");
figure(1);
% imshow(myImg);

newImg = imresize(myImg,[480, 640]);
subplot(3, 4, 2);
% imshow(newImg);
imwrite(newImg, "newImg.jpg");
% split
[r,g,b] = imsplit(newImg);
subplot(1,3,1);
% imshow(r);
subplot(1,3, 2);
% imshow(g);
subplot(1,3,3);
% imshow(b);
title("RGB channels");
testImage = rgb2gray(newImg);
% figure(3);
% imshow(testImage);

% q5 threshold
level = graythresh(testImage);
BW = imbinarize(testImage, level);
figure(4);
% imshow(BW);

% we are interested in blue colour
levelBlue = graythresh(b);
blueThresh = imbinarize(b, levelBlue);
% imshow(blueThresh);

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
% imhist(b);
t1 = imbinarize(b, 80/255);
t2 = imbinarize(b, 36/255);
text = t1-t2;
% imshow(text)

% homework
iLowerThreshold = 33;
iUpperThreshold = 88;
% Option 1 (slow!) - Comment out one of the two options - 
% Use two nested loops to check the pixels in all rows and 
% columns of the blue channel image. If the value is between 33 and 88,
% we see the binary mask image pixel at the same location to 1 (meaning
% this is a foreground pixel we want to keep), otherwise 0.

% [rows, cols] = size(myImgBlue);
% blueChannelBinaryMask = zeros(size(myImgBlue), 'logical');
% for iRow = 1:rows
%     for iCol = 1:cols
%         if (myImgBlue(iRow, iCol) >= iLowerThreshold) &&
%                 (myImgBlue(iRow, iCol) <= iUpperThreshold)
%             blueChannelBinaryMask(iRow, iCol) = 1;
%         end
%     end
% end

% Option 2 (faster!) - Comment out one of the two options -
% Use a comparison and a bitwise AND.
blueChannelBinaryMask = (b >= iLowerThreshold) & (b <= iUpperThreshold);
imshow(blueChannelBinaryMask);
title('Blue channel mask (binary)');
% Apply the binary mask to the blue channel image using an element-wise
% multiplication (this is what '.*'). Because the mask array is of type
% 'logical' (=binary), we need to type cast it to uint8 (8-bit unsigned 
% integer) to match the data type of 
myImgBlueMasked = b .* cast(blueChannelBinaryMask, "uint8");
imshow(myImgBlueMasked);
title('Blue with mask applied');
% Apply the binary mask also to the greyscale image. As we can see in the
% output, part of the table surface is still considered foreground.
myImgGrayMasked = testImage .* cast(blueChannelBinaryMask, "uint8");
imshow(myImgGrayMasked);
title('Gray with mask applied');
% NOTE: As we can see from the output, the result is imperfect as the
% output still contains a lot of pixels of the table surface seen in the
% image above the bar of chocolate. We could try to find better thresholds
% but even then the result will be imperfect. Therefore...
% ...quite often in computer vision and image analysis, we need to apply
% multiple algorithms sequentially, rather than having one algorithm that
% does everything we want. Here, it would be helpful to first detect the
% edges of the block of chocolate, to extract just that part as a subimage
% and then to do the above analysis again just on the subimage. We will see
% in coming weeks how we can automate that detection; for now, we simply
% hardcode the top-left and bottom-right coordinates of the block of chocolate.
temp = myImg(:,:,3);
subImgBlue = temp(570:1900, 130:3000);
imshow(subImgBlue);
title('Subimage Chocolate (Blue Channel)');
% Apply the two thresholds again
% Use a comparison and a bitwise AND.
subImgBlueChannelBinaryMask = (subImgBlue >= iLowerThreshold) & (subImgBlue <= iUpperThreshold);
% Display the blue channel mask for the subimage
imshow(subImgBlueChannelBinaryMask);
title('Subimage Blue Channel Mask');
% Apply the binary mask to the blue channel subimage.
subImgBlueMasked = subImgBlue .* cast(subImgBlueChannelBinaryMask, "uint8");
imshow(subImgBlueMasked);
title('Subimage Blue Ch. with Mask Applied');
% Now let's perform histogram equalisation on the thresholded image
% histogram eq is used to enhance contrast
subImgBlueHistEq = histeq(subImgBlue);
imshow(subImgBlueHistEq);
title('Subimage Blue Ch. Hist. Eq.');
% Display the image histogram after histogram equalisation
imhist(subImgBlueHistEq);
title('Histogram of Subimage After Hist. Eq.');
% Apply the binary mask to the histogram equalised blue channel subimage
subImgBlueMaskedHistEq = subImgBlueHistEq .* ...
                         cast(subImgBlueChannelBinaryMask, "uint8");
imshow(uint8(255 * mat2gray(subImgBlueMaskedHistEq))); 
% Scale pixel values to range [0-255]
title('Subimage After Hist. Eq. and Mask Applied');
% NOTE: As the results show here, it might be better to find new threshold
% values after histogram equalisation. You can explore this on your own.
