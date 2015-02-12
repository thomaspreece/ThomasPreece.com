clear Y X Z X2 Y2 X3
%load greyscale image into X
RGB=imread('C:\Users\Tom\Dropbox\4th Yr Poster\Full2.png');
X = rgb2gray(RGB);

%Preallocate for speed
Y = zeros(size(X,1),size(X,2));
Y2 = zeros(size(X,1),size(X,2));
X3 = zeros(size(X,1),size(X,2));
Z = zeros(size(X,1),size(X,2));


%Apply transformation on rows
for i=1:size(X,1)
    i
    [w,w2]=Filter97(X(i,:));
    Y(i,:)=cat(2,w,w2);
end

%Apply transformation on columns
Y=transpose(Y);
for i=1:size(Y,1)
    i
    [w,w2]=Filter97(Y(i,:));
    Z(i,:)=cat(2,w,w2);
end

%Save transformation data
X2=transpose(Z);


for i=1:size(Z,1)
   i
   Y2(i,:)=InverseFilter97(Z(i,1:size(Z,2)/2),Z(i,size(Z,2)/2+1:end));
end

Y2=transpose(Y2);

for i=1:size(Y2,1)
   i
   X3(i,:)=InverseFilter97(Y2(i,1:size(Y2,2)/2),Y2(i,size(Y2,2)/2+1:end));
end


return 