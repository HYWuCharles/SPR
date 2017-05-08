function decode_data = decode(data,width,height)

%-------------²âÊÔ-------------%
%image = imread(data);
%[a,b] = size(image);

%-------------ÕıÊ½-------------%
data = uint8(data);
data = reshape(data,height,width);
[a,b] = size(data);
N = a*b;

key = 0.3;

for i=1:N-1
    key(i+1) = 4*key(i)-4*key(i)^2;
end

key = mod(1000*key,256);

key = uint8(key);
n=1;
for i=1:a
    for j=1:b
        e(i,j) = bitxor(key(n),data(i,j));
        n = n+1;
    end
end
% figure
% imshow(e);
% title('Decoded Image');
decode_data = e;