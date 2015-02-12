function [ EMS,PSNR ] = MSE( Input,Output,BitsPerPixel )
%MSE Returns the MSE and PSNR of two images
%   Returns the mean square error EMS and the Peak Signal to Noise PSNR of
%   two images Input and Output with BitsPerPixel number of bits per pixel 

%Throw error if image sizes are incorrect
if size(Input,1)~=size(Output,1) || size(Input,2)~=size(Output,2) || size(Input,3)~=size(Output,3)
    errordlg('Non Matching Image')
    return
end 

%Get image sizes and store them for later use
N=size(Input,1);
M=size(Input,2);
Z=size(Input,3);

sumElts=0; %removed double(0)

%Loop through each pixel in the Red,Green and blue channels and add the
%error to the sum
for z=1:Z
    for n=1:N
       for m=1:M
           sumElts = sumElts + double((Input(n,m,z)-Output(n,m,z))^2);
       end 
    end
end

%Calculate the Mean square error and the peak signal to noise
EMS=double(sumElts)/(M*N*Z);
PSNR = 10*log10(((BitsPerPixel^2)-1)/EMS);

end

