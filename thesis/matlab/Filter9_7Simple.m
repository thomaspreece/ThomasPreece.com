%Simple script to show off wavelet transform
X=[1,2,3,4,5,6,7,8,9,10];

%Compute the Wavelet transform on X
[w,w2]=Filter97(X);

%Reverse wavelet transform to get back original values
X2=InverseFilter97(w,w2);