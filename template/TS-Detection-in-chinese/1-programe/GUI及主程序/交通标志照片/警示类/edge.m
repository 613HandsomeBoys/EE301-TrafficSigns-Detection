clear
clc
I=imread('ע������.jpg');
imshow(I);
title('ԭʼͼ��');
I=rgb2gray(I);% ��ɫͼ��ҶȻ�
figure,imshow(I);
title('�Ҷ�ͼ��');
BW1=edge(I,'sobel'); %��SOBEL���ӽ��б�Ե���
BW2=edge(I,'roberts');%��Roberts���ӽ��б�Ե���
BW3=edge(I,'prewitt'); %��prewitt���ӽ��б�Ե���
BW4=edge(I,'log'); %��log���ӽ��б�Ե���
BW5=edge(I,'canny'); %��canny���ӽ��б�Ե���
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