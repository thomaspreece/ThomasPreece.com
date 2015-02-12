clear;
[I,map] = imread('baboon.png');
Input = 256*ind2rgb(I,map);
Input=uint8(Input);
Output = imread('baboon.jpg');

AverageSSIM(Input,Output,8)


