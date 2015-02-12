%PLEASE NOTE
%The following code is incorrect and hence the results in the report obtained by using this code are 
%also incorrect. This is due to the DCT method having to calculate the Cos values on each loop. The 
%values should of been precalculated and stored in an array resulting in speed ups of the DCT method.
%The code is left here only as reference.

clear;

for p=1:10
    %Randomly generate 1000 sets of 8 values
    X=rand(1000,8);
    %Set N as the size of 1 set, so will hold value 8.
    N=size(X,2);
    M=size(X,1);

    %Loop through our 1000 sets and extend them to 4N (4*8) size so we can use
    %them with the FFT
    for k=1:M
        for i=1:N
            X2(k,2*i-1)=0;
            X2(k,2*i)=X(k,i);
        end 
        X2(k,N+1)=0;
        for i=2:N*2
            X2(k,4*N-i+2)=X2(k,i);
        end 
    end 

    %--------------------------- Time FFT Method ---------------------------

    %Start Timer
    ticFFT=tic;
    for k=1:M
        %Perform the fast Fourier transform to each set of data
        Y2=real(fft(X2(k,:))*(1/sqrt(4*N)));
        %Remove the symmetric repeating entries
        Y2Cut(k,:)=Y2(:,1:N);
    end 
    %Save time taken to calculate
    FFT(p)=toc(ticFFT);

    %--------------------------- Time DCT Method ---------------------------

    %Start Timer
    ticDCT=tic;
    for k=1:M
        %Calculate the DCT for each of the N points
        for i=0:N-1
            sum=0;
            for j=0:N-1
                sum=sum+X(k,j+1)*cos((pi*(j+0.5)*(i))/N);
            end
            Y3(k,i+1)=(1/sqrt(N))*sum;
        end 
    end 
    %Save time taken to calculate
    DCT(p)=toc(ticDCT);
end 
Difference=DCT-FFT;
PercentageDifference=Difference./DCT;
PercentageDifference=PercentageDifference.*100;

T=table(transpose(DCT), transpose(FFT), transpose(Difference), transpose(PercentageDifference), 'VariableNames', {'DCT', 'FFT', 'FFT_Speed_Improvement', 'FFT_Percentage_Speed_Improvement'});

writetable(T,'FFTvsDCT.csv')

