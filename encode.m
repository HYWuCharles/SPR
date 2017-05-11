function [coded_image, height, width] = encode(data)

[a, b] = size(data);
height = a;
width = b;
N = a*b;
key(1) = 0.3;

for i=1:N-1
    key(i+1)=4*key(i)-4*key(i)^2;
end

key=mod(1000*key,256);
key=uint8(key);

n=1;
for i=1:a
    for j=1:b
        e(i,j)=bitxor(key(n),data(i,j));
        n=n+1;
    end
end

%figure
%imshow(e)
%title('encoded image')
%imwrite(e,'test.bmp','bmp');
coded_image = e;
%[a b c]=size(x);
%N=a*b;
%m(1)=input('«Î ‰»Î√ÿ‘ø£∫');
%disp('Ω‚√‹÷–');
%for i=1:N-1
%    m(i+1)=4*m(i)-4*m(i)^2;
%end

