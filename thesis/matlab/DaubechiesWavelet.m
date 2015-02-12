clear;

%Set the Polynomial Coordinates
global P;
%Daubechies 6-tap
%P=[0.47046721,1.14111692,0.650365,-0.19093442,-0.12083221,0.0498175];

%Daubechies 4-tap
P=[0.6830127,1.1830127,0.3169873,-0.1830127]; %Polynomial Values

%Daubechies 2-tap/Haar Wavelet
%P=[1,1];

%Input our data
X=[211,211,213,213,214,215,216,215,213,216];

%preallocate arrays for speed
h=zeros(1,size(P,2));
l=zeros(1,size(P,2));

q=size(X,2);
n=size(P,2);

%Calculate deconstruction filters from polynomial coefficients
for k=1:n
    h(k)=0.5*P(k)*(-1)^k;
end 
for k=1:n
    l(k)=0.5*P(n-k+1);
end

%Apply the convolution method of deconstruction
w=conv(l,X);
w2=conv(h,X);

%Down sample our coefficients
Lcoeff2=w(:,2:2:end);
Hcoeff2=w2(:,2:2:end);

Hcoeff2(2)=0;
Hcoeff2(3)=0;
Hcoeff2(4)=0;
Hcoeff2(5)=0;

%Up sample our coefficients
for k=1:size(Lcoeff2,2)
    ULcoeff(2*k-1)=Lcoeff2(k);
    ULcoeff(2*k)=0;
end 

for k=1:size(Hcoeff2,2)
    UHcoeff(2*k-1)=Hcoeff2(k);
    UHcoeff(2*k)=0;
end 

%Construct reconstruction filters
for k=1:n
    hT(k)=P(n-k+1)*((-1)^(n-k+1));
end 
for k=1:n
    lT(k)=P(k);
end

%Apply reconstruction method using convolution
X2=conv(lT,ULcoeff)+conv(hT,UHcoeff);

%Strip out the unnecessary data to get original data
X2=X2(n-2+1:n-2+q);

return

