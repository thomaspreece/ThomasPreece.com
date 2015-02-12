function [ Output,TotalBits,UncompressedBits ] = JPEG( Input,BitsPerPixel )
%JPEG Applies the JPEG method to Input image.
%   Applies the JPEG method to compress an image and works out the required 
%   storage size as well as returning the image that would be obtained by 
%   uncompressing the image. It does not however calculate the actual bit
%   sequence (the compressed image) that the JPEG method would return,
%   just the size of that bit sequence.

%Luminance and Chrominance values obtained from Annex K of JPEG specification, tables K.1,K.2,K.5 K.6
%Quantization Values
LuminanceQ=[16,11,10,16,24,40,51,61; 12,12,14,19,26,58,60,55; 14,13,16,24,40,57,69,56; 14,17,22,29,51,87,80,62; 18,22,37,56,68,109,103,77; 24,35,55,64,81,104,113,92; 49,64,78,87,103,121,120,101; 72,92,95,98,112,100,103,99];
ChrominanceQ=[17,18,24,47,99,99,99,99; 18,21,26,66,99,99,99,99; 24,26,56,99,99,99,99,99; 47,66,99,99,99,99,99,99; 99,99,99,99,99,99,99,99; 99,99,99,99,99,99,99,99; 99,99,99,99,99,99,99,99; 99,99,99,99,99,99,99,99];

%Bits required for each category of DC difference
LuminanceDC=[2,3,3,3,3,3,4,5,6,7,8,9];
ChrominanceDC=[2,2,2,3,4,5,6,7,8,9,10,11];

%Bits required for each Run Length Huffman encoding of Luminance AC
%coefficients
LuminanceAC(1,:)=[4,2,2,3,4,5,7,8,10,16,16];
LuminanceAC(2,:)=[0,4,5,7,9,11,16,16,16,16,16];
LuminanceAC(3,:)=[0,5,8,10,12,16,16,16,16,16,16];
LuminanceAC(4,:)=[0,6,9,12,16,16,16,16,16,16,16];
LuminanceAC(5,:)=[0,6,10,16,16,16,16,16,16,16,16];
LuminanceAC(6,:)=[0,7,11,16,16,16,16,16,16,16,16];
LuminanceAC(7,:)=[0,7,12,16,16,16,16,16,16,16,16];
LuminanceAC(8,:)=[0,8,12,16,16,16,16,16,16,16,16];
LuminanceAC(9,:)=[0,9,15,16,16,16,16,16,16,16,16];
LuminanceAC(10,:)=[0,9,16,16,16,16,16,16,16,16,16];
LuminanceAC(11,:)=[0,9,16,16,16,16,16,16,16,16,16];
LuminanceAC(12,:)=[0,10,16,16,16,16,16,16,16,16,16];
LuminanceAC(13,:)=[0,10,16,16,16,16,16,16,16,16,16];
LuminanceAC(14,:)=[0,11,16,16,16,16,16,16,16,16,16];
LuminanceAC(15,:)=[0,16,16,16,16,16,16,16,16,16,16];
LuminanceAC(16,:)=[11,16,16,16,16,16,16,16,16,16,16];

%Bits required for each Run Length Huffman encoding of Chrominance AC
%coefficients
ChrominanceAC(1,:)=[2,2,3,4,5,5,6,7,9,10,12];
ChrominanceAC(2,:)=[0,4,6,8,9,11,12,16,16,16,16];
ChrominanceAC(3,:)=[0,5,8,10,12,15,16,16,16,16,16];
ChrominanceAC(4,:)=[0,5,8,10,12,16,16,16,16,16,16];
ChrominanceAC(5,:)=[0,6,9,16,16,16,16,16,16,16,16];
ChrominanceAC(6,:)=[0,6,10,16,16,16,16,16,16,16,16];
ChrominanceAC(7,:)=[0,7,11,16,16,16,16,16,16,16,16];
ChrominanceAC(8,:)=[0,7,11,16,16,16,16,16,16,16,16];
ChrominanceAC(9,:)=[0,8,16,16,16,16,16,16,16,16,16];
ChrominanceAC(10,:)=[0,9,16,16,16,16,16,16,16,16,16];
ChrominanceAC(11,:)=[0,9,16,16,16,16,16,16,16,16,16];
ChrominanceAC(12,:)=[0,9,16,16,16,16,16,16,16,16,16];
ChrominanceAC(13,:)=[0,9,16,16,16,16,16,16,16,16,16];
ChrominanceAC(14,:)=[0,11,16,16,16,16,16,16,16,16,16];
ChrominanceAC(15,:)=[0,14,16,16,16,16,16,16,16,16,16];
ChrominanceAC(16,:)=[10,15,16,16,16,16,16,16,16,16,16];

Input=double(Input);

%Dimensions of Image must be exactly divisible by 8
if mod(size(Input,1),8) ~= 0 || mod(size(Input,2),8) ~= 0 
    errordlg('Dimensions of image not divisible by 8')
    return
end 

%Preallocate arrays for speed
Y=double(zeros(size(Input,1),size(Input,2)));
Cb=double(zeros(size(Input,1),size(Input,2)));
Cr=double(zeros(size(Input,1),size(Input,2)));

%Set the bit counters to zero
YBits=0;
CrBits=0;
CbBits=0;

%Convert Image from RBG to YCrCb
for i=1:size(Input,1)
    for j=1:size(Input,2)
        Y(i,j)=0.299000*Input(i,j,1) + 0.587000*Input(i,j,2) + 0.114000*Input(i,j,3);
        Cb(i,j)=(-0.168736*Input(i,j,1)) - (0.331264*Input(i,j,2)) + (0.500000*Input(i,j,3));
        Cr(i,j)=(0.500000*Input(i,j,1)) - (0.418688*Input(i,j,2)) - (0.081312*Input(i,j,3));
    end
end 

%Level shift Y by 128 and Cr Cb by 64 (assuming that input image is 8-bit)
Y=Y-(2^BitsPerPixel)/2;
Cr=Cr-(2^BitsPerPixel)/4;
Cb=Cb-(2^BitsPerPixel)/4;

OldY=0;
OldCr=0;
OldCb=0;

%Loop through each 8x8 block and apply DCT, quantization, calculate bits
%required to store using JPEG method described earlier in report, reverse
%quantization and reverse DCT
for i = 1:(size(Input,2)/8)
    for j = 1:(size(Input,1)/8)
        %Get 8x8 subblock
        YSub = Y(8*(j-1)+1:8*j,8*(i-1)+1:8*i);
        CrSub = Cr(8*(j-1)+1:8*j,8*(i-1)+1:8*i);
        CbSub = Cb(8*(j-1)+1:8*j,8*(i-1)+1:8*i);
        
        %Use matlabs builtin command dct2 to perform the DCT faster
        DCTY = dct2(YSub);
        DCTCr = dct2(CrSub);
        DCTCb = dct2(CbSub);
        
        %preallocate arrays for speed
        DCTQY = zeros(8,8); 
        DCTQCr = zeros(8,8);
        DCTQCb = zeros(8,8);
        DCTUQY = zeros(8,8); 
        DCTUQCr = zeros(8,8);
        DCTUQCb = zeros(8,8);        
        
        %Apply quantization 
        for m=1:8
            for n=1:8
                DCTQY(m,n)=round(DCTY(m,n)/LuminanceQ(m,n));
                DCTQCr(m,n)=round(DCTCr(m,n)/ChrominanceQ(m,n));
                DCTQCb(m,n)=round(DCTCb(m,n)/ChrominanceQ(m,n));
            end
        end
        
        %Calculate difference between this luminance coefficient and last
        Diff=DCTQY(1,1)-OldY;
        %Calculate the DC coefficient category
        if Diff==0
            Category=0;
        else
            Category=floor(log2(abs(Diff)))+1;
        end
        %Add the required bits for that category to the total for Y
        YBits=YBits+LuminanceDC(Category+1)+Category;
        %Set last coefficient to be the one used in this loop
        OldY=DCTQY(1,1);
        
        %Calculate difference between this Chrominance coefficient and last
        Diff=DCTQCr(1,1)-OldCr;
        %Calculate the DC coefficient category        
        if Diff==0
            Category=0;
        else
            Category=floor(log2(abs(Diff)))+1;
        end
        %Add the required bits for that category to the total for Cr
        CrBits=CrBits+ChrominanceDC(Category+1)+Category;   
        %Set last coefficient to be the one used in this loop
        OldCr=DCTQCr(1,1);
        
        %Calculate difference between this Chrominance coefficient and last
        Diff=DCTQCb(1,1)-OldCb;
        %Calculate the DC coefficient category   
        if Diff==0
            Category=0;
        else
            Category=floor(log2(abs(Diff)))+1;
        end
        %Add the required bits for that category to the total for Cr
        CbBits=CbBits+ChrominanceDC(Category+1)+Category;    
        %Set last coefficient to be the one used in this loop
        OldCb=DCTQCb(1,1);
        
               
%http://www.mathworks.com/matlabcentral/fileexchange/15317-zigzag-scan
        %is used to calculate the zigzag scan of AC coefficients
        Yzigzag=zigzag(DCTQY);
        Crzigzag=zigzag(DCTQCr);
        Cbzigzag=zigzag(DCTQCb);
        
        zeroCount=0;
        for m=2:64
            if Yzigzag(m)==0 
                %Element is zero so add 1 onto the zero count
                zeroCount=zeroCount+1;
            else
                if zeroCount>15
                    %Send the marker for 15 zeros (ZRL) zeroCount/15 times
                    YBits=YBits+floor(zeroCount/15)*LuminanceAC(16,1);
                    zeroCount=zeroCount-floor(zeroCount/15)*15;
                end
                %Calculate the AC coefficient category
                Category = floor(log2(abs(Yzigzag(m))))+1;
                %Add the required bits for that category and zero count to 
                %the total for Y
                YBits=YBits+LuminanceAC(zeroCount+1,Category+1)+Category;
                zeroCount=0;
            end
        end 
        if zeroCount>0
            %Use End of Block (EoB) code and add bits required for code to
            %total for Y
            YBits=YBits+LuminanceAC(1,1);
        end
        
        for m=2:64
            if Crzigzag(m)==0 
                %Element is zero so add 1 onto the zero count
                zeroCount=zeroCount+1;
            else
                if zeroCount>15
                    %Send the marker for 15 zeros (ZRL) zeroCount/15 times
                    CrBits=CrBits+floor(zeroCount/15)*ChrominanceAC(16,1);
                    zeroCount=zeroCount-floor(zeroCount/15)*15;
                end
                %Calculate the AC coefficient category
                Category = floor(log2(abs(Crzigzag(m))))+1;
                %Add the required bits for that category and zero count to 
                %the total for Cr
                CrBits=CrBits+ChrominanceAC(zeroCount+1,Category+1)+Category;
                zeroCount=0;
            end
        end 
        if zeroCount>0
            %Use End of Block (EoB) code and add bits required for code to
            %total for Cr
            CrBits=CrBits+ChrominanceAC(1,1);
        end        
        
        
        for m=2:64
            if Cbzigzag(m)==0 
                %Element is zero so add 1 onto the zero count
                zeroCount=zeroCount+1;
            else
                if zeroCount>15
                    %Send the marker for 15 zeros (ZRL) zeroCount/15 times
                    CbBits=CbBits+floor(zeroCount/15)*ChrominanceAC(16,1);
                    zeroCount=zeroCount-floor(zeroCount/15)*15;
                end
                %Calculate the AC coefficient category
                Category = floor(log2(abs(Cbzigzag(m))))+1;
                %Add the required bits for that category and zero count to 
                %the total for Cb
                CbBits=CbBits+ChrominanceAC(zeroCount+1,Category+1)+Category;
                zeroCount=0;
            end
        end 
        if zeroCount>0
            %Use End of Block (EoB) code and add bits required for code to
            %total for Cb
            CbBits=CbBits+ChrominanceAC(1,1);
        end         
        
        
        %Reverse Quantization
        for m=1:8
            for n=1:8
                DCTUQY(m,n)=DCTQY(m,n)*LuminanceQ(m,n);
                DCTUQCr(m,n)=DCTQCr(m,n)*ChrominanceQ(m,n);
                DCTUQCb(m,n)=DCTQCb(m,n)*ChrominanceQ(m,n);
            end
        end        
        
        %Reverse DCT
        IDCTY=idct2(DCTUQY);
        IDCTCr=idct2(DCTUQCr);
        IDCTCb=idct2(DCTUQCb);
        
        %Put Output of 8x8 block into correct place in full image
        OutputY(8*(j-1)+1:8*j,8*(i-1)+1:8*i) = IDCTY;
        OutputCr(8*(j-1)+1:8*j,8*(i-1)+1:8*i) = IDCTCr;
        OutputCb(8*(j-1)+1:8*j,8*(i-1)+1:8*i) = IDCTCb;        
    end
end

%Reverse Level shift
OutputY=OutputY+(2^BitsPerPixel)/2;
OutputCr=OutputCr+(2^BitsPerPixel)/4;
OutputCb=OutputCb+(2^BitsPerPixel)/4;

%Preallocate array for speed
Output=double(zeros(size(Input,1),size(Input,2),size(Input,3)));

%Reverse colour transformation, takes YCrCb to RGB
for i=1:size(Input,1)
    for j=1:size(Input,2)
        Output(i,j,1)=1*OutputY(i,j) + 1.402000*OutputCr(i,j);
        Output(i,j,2)=1*OutputY(i,j) - 0.344136*OutputCb(i,j) - 0.714136*OutputCr(i,j);
        Output(i,j,3)=1*OutputY(i,j) + 1.772000*OutputCb(i,j);
    end
end 

%Correct data type
Output=uint8(Output);

%Calculate total bits required to store compressed image and uncompressed
%image
TotalBits=YBits+CrBits+CbBits;
UncompressedBits=8*size(Input,1)*size(Input,2)*size(Input,3);

end

