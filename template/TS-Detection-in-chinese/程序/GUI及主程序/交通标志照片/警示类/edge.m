clear
clc
I=imread('注意行人.jpg');
imshow(I);
title('原始图像');
I=rgb2gray(I);% 彩色图像灰度化
figure,imshow(I);
title('灰度图像');
BW1=edge(I,'sobel'); %用SOBEL算子进行边缘检测
BW2=edge(I,'roberts');%用Roberts算子进行边缘检测
BW3=edge(I,'prewitt'); %用prewitt算子进行边缘检测
BW4=edge(I,'log'); %用log算子进行边缘检测
BW5=edge(I,'canny'); %用canny算子进行边缘检测
h=fspecial('gaussian',5);
 BW6=edge(I,'canny');
 subplot(2,3,1), imshow(BW1);
 title('sobel edge check');
 subplot(2,3,2), imshow(BW2);
 title('roberts edge check');
 subplot(2,3,3), imshow(BW3);
 title('prewitt edge check');
 subplot(2,3,4), imshow(BW4);
 title('log edge check');
 subplot(2,3,5), imshow(BW5);
 title('canny edge check');
 subplot(2,3,6), imshow(BW6);
 title('gasussian&canny edge check');