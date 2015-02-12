function [ Z,Z2 ] = Filter97( X )
%Filter97 Applies the CDF9/7 wavelet transformation 
%   Applies the wavelet transformation using the the 9/7 
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


%Deconstruction using the lowpass analysis filter
for l=0:size(X,2)-1
    sum=double(0);
    for k=-4:4
       sum=sum+h(k+5)*double(SymX(X,l-k));
    end
    w(l+1)=double(sum);
end 

%Deconstruction using the highpass analysis filter
for l=0:size(X,2)-1
    sum=double(0);
    for k=-3:3
       sum=sum+g(k+4)*double(SymX(X,l-k));
    end
    w2(l+1)=double(sum);
end 

%Down sample signal
Z=w(1:2:end);
Z2=w2(2:2:end);


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


