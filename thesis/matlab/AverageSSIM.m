function [ Out ] = AverageSSIM(Input,Output,BitsPerPixel)
%AverageSSIM Calculates the SSIM over 8x8 subblocks and averages the values
%   Calculates the SSIM over 8x8 blocks with overlap of block column with
%   the next being 50% and similarly for block rows. 
%   Input, Output must be X by Y by 3 arrays of RGB colours. BitsPerPixel
%   contains the number of bits used per pixel in Input and Output.

    %Preallocate Luminance arrays IY,OY
    IY=zeros(size(Input,1),size(Input,2));
    OY=zeros(size(Output,1),size(Output,2));

    %Use conversion formula to calculate the Luminance of each pixel in Input
    for i=1:size(Input,1)
        for j=1:size(Input,2)
            IY(i,j)=0.299000*Input(i,j,1) + 0.587000*Input(i,j,2) + 0.114000*Input(i,j,3);
        end
    end

    %Use conversion formula to calculate the Luminance of each pixel in Output
    for i=1:size(Output,1)
        for j=1:size(Output,2)
            OY(i,j)=0.299000*Output(i,j,1) + 0.587000*Output(i,j,2) + 0.114000*Output(i,j,3);
        end
    end

    %Preallocate array to store SSIM values
    S=zeros((floor(size(Input,1)/4)-1),(floor(size(Input,2)/4)-1));

    %Runs through all the blocks and uses SSIM function to calculate SSIM
    for i=1:(floor(size(Input,1)/4)-1)
        for j=1:(floor(size(Input,2)/4)-1)
            A = IY((i-1)*4+1:(i-1)*4+8 , (j-1)*4+1:(j-1)*4+8);
            A = double(transpose(A(:)));
            B = OY((i-1)*4+1:(i-1)*4+8 , (j-1)*4+1:(j-1)*4+8);
            B = double(transpose(B(:)));
            S(i,j)=SSIM(A,B,BitsPerPixel);
        end
    end

    %Find the average of all 8x8 blocks calculated
    Out = mean(S(:));

end 

function [ Out ] = SSIM( A,B,BitsPerPixel )
%SSIM Calculates SSIM on A and B
%   Uses the SSIM formula to calculate the SSIM of A and B 

    if size(A,1)~=1 || size(A,1)~=size(B,1) || size(A,2)~=size(B,2)
        errordlg('Non Matching Image')
        return
    end 

    %Average of A
    UA=mean(A(:));
    %Average of B
    UB=mean(B(:));

    %Array containing CoVariance and Variance
    CoVar = cov(A,B);

    %Constants used in formula, using k1=0.01, k2=0.03
    c1=(0.01*((2^BitsPerPixel)-1))^2;
    c2=(0.03*((2^BitsPerPixel)-1))^2;

    %Return the SSIM
    Out = ( (2*UA*UB+c1)*(2*CoVar(1,2)+c2) )/( (UA^2+UB^2+c1)*(CoVar(1,1)+CoVar(2,2)+c2) );

end

