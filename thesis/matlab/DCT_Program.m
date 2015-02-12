clear;
%Image set is obtained from http://r0k.us/graphics/kodak/. A mirror of the
%images can be obtained from http://thomaspreece.com/thesis/.

%This file compares JPEG compression and JPEG2000 compression. Due to the
%complexity of implementing a decent JPEG2000 compression algorithm in
%matlab I have omitted it and used a separate program to convert our
%original PNG files into JPEG2000 files and then converted those back to 
%PNG format. Due to PNG being lossless the input of our modified PNG files
%is exactly the same as if we had imported the JPEG2000 images directly
%allowing us to compare them as if we were reading the JPEG2000 image
%files.

%Preallocate arrays for speed
UncompressedBits=zeros(1,24);
Saving_JPEG=zeros(1,24);
SSIM_JPEG=zeros(1,24);
EMS_JPEG=zeros(1,24);
PSNR_JPEG=zeros(1,24);
TotalBits_JPEG=zeros(1,24);

Saving_JP2=zeros(1,24);
SSIM_JP2=zeros(1,24);
EMS_JP2=zeros(1,24);
PSNR_JP2=zeros(1,24);
TotalBits_JP2=zeros(1,24);

%Loop through our 24 image set
for i=1:24
    if i<10
        FileNumber=strcat('0',int2str(i))
    else
        FileNumber=int2str(i)
    end
    
    %Load image
    Input = imread( strcat( 'C:\Users\Tom\Dropbox\Matlab\PictureSet\kodim', FileNumber, '.png' ) );
    Input=double(Input);
    BitsPerPixel=8;
    
    %Use the JPEG algorithm
    [Output,TotalBits_JPEG(i),UncompressedBits(i)]=JPEG(Input,BitsPerPixel);

    %Calculate saving gained from compression.
    Saving_JPEG(i)=(UncompressedBits(i) - TotalBits_JPEG(i)) / UncompressedBits(i);
    SSIM_JPEG(i)=AverageSSIM(Input,Output,BitsPerPixel);
    [EMS_JPEG(i),PSNR_JPEG(i)]=MSE(Input,Output,BitsPerPixel);
    
    JP2Output = imread( strcat ( 'C:\Users\Tom\Dropbox\Matlab\PictureSet\kodim', FileNumber, '_Modified.png' ) ); 
    
    s = dir( strcat( 'C:\Users\Tom\Dropbox\Matlab\PictureSet\kodim', FileNumber, '.jp2' ) );
    TotalBits_JP2(i)=s.bytes*8;
    
    Saving_JP2(i)=(UncompressedBits(i)-TotalBits_JP2(i))/UncompressedBits(i);
    SSIM_JP2(i)=AverageSSIM(Input,JP2Output,BitsPerPixel);
    [EMS_JP2(i),PSNR_JP2(i)]=MSE(Input,JP2Output,BitsPerPixel);    
    
end

T=table(transpose(UncompressedBits), transpose(TotalBits_JPEG), transpose(TotalBits_JP2), transpose(Saving_JPEG), transpose(Saving_JP2), 'VariableNames', {'Uncompressed_Size', 'JPEG_Size', 'JP200_Size', 'JPEG_Savings', 'JP2000_Savings'});
writetable(T,'Sizes.csv')

T2=table(transpose(UncompressedBits), transpose(Saving_JPEG), transpose(Saving_JP2), transpose(SSIM_JPEG), transpose(SSIM_JP2), transpose(EMS_JPEG), transpose(EMS_JP2), transpose(PSNR_JPEG), transpose(PSNR_JP2), 'VariableNames', {'Uncompressed_Size', 'JPEG_Savings', 'JP2000_Savings', 'JPEG_SSIM', 'JP2000_SSIM', 'JPEG_EMS', 'JP2000_EMS', 'JPEG_PSNR', 'JP2000_PSNR'});
writetable(T2,'Quality.csv')

return 