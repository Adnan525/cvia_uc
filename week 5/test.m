import f.*
myImg = imread("barcode.jpg");
%[h,s,v] = f(myImg);
temp = f(myImg);
imshow(temp(2));
