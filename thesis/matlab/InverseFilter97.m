function [ Y ] = InverseFilter97( w,w2 )
%InverseFilter97 Applies the inverse CDF9/7 wavelet transformation
%   Applies the inverse wavelet transformation using the the 9/7 
%   Cohen-Daubechies-Feauveau biorthogonal wavelet. The algorithm is very
%   inefficient but shows the main principles discussed in the paper.

%Low pass analysis filter
h(1) = 0.026748757411;
h(2) = -0.016864118443;
h(3) = -0.078223266529;
h(4) = 0.266864118443;
h(5) = 0.602949018236;
h(6) = h(4);
h(7) = h(3);
h(8) = h(2);
h(9) = h(1);


%high pass analysis filter
g(1) = 0.0912717631142495;
g(2) = -0.057543526228500;
g(3) = -0.591271763114247;
g(4) = 1.115087052456994;
g(5) = g(3);
g(6) = g(2);
g(7) = g(1);

%lowpass synthesis filter
h2(1)=-g(1);
h2(2)=g(2);
h2(3)=-g(3);
h2(4)=g(4);
h2(5)=-g(3);
h2(6)=g(2);
h2(7)=-g(1);

%highpass synthesis filter
g2(1)=h(1);
g2(2)=-h(2);
g2(3)=h(3);
g2(4)=-h(4);
g2(5)=h(5);
g2(6)=-h(4);
g2(7)=h(3);
g2(8)=-h(2);
g2(9)=h(1);

%Upscaling the coefficients
for k=1:size(w,2)
    Uw(2*k-1)=w(k);
    Uw(2*k)=0;
end 

for k=1:size(w2,2)
    Uw2(2*k)=w2(k);
    Uw2(2*k-1)=0;
end 


%Reconstruction using the synthesis filters
for k=0:size(w,2)+size(w2,2)-1
    sum1=0;
    sum2=0;
    %lowpass synthesis filter
    for l=-3:3
       sum1=sum1+h2(l+4)*SymX(Uw,k-l);
    end     
    %highpass synthesis filter
    for l=-4:4
       sum2=sum2+g2(l+5)*SymX(Uw2,k-l);
    end
    %Return reconstruction
    Y(k+1)=sum1+sum2;
end 

end

function [ y ] = SymX( X,n )
%SymX Symmetric extension of data set X
%   Returns value n of the symmetric extension of the data set X where the
%   borders are extended around the whole point. Also X starts from 0
%   instead of the usual matlab 1.
X=wextend('1','symw',X,size(X,2)-2,'r');
M=size(X,2);

N=mod(n,M);

y=X(N+1);

end

