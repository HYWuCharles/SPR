function decode_data = decode(data)

%-------------²âÊÔ-------------%
%image = imread(data);
%[a,b] = size(image);

%-------------ÕıÊ½-------------%
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

decode_data = e;