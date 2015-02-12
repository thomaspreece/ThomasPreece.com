%Load Orginal Image
Input = imread('C:\Users\Tom\Dropbox\Matlab\LowQuality\kodim01.png');
%Load JPEG compressed Image
JPEGOutput = imread('C:\Users\Tom\Dropbox\Matlab\LowQuality\kodim01_Low.jpg');
%Load JPEG 2000 compressed Image
JP2Output = imread('C:\Users\Tom\Dropbox\Matlab\LowQuality\kodim01_Low.png');

%Compare the compression standards
SSIMJPEG=AverageSSIM(Input,JPEGOutput,8);
SSIMJP2=AverageSSIM(Input,JP2Output,8);


