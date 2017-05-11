function binary = source_coding_decoding(data,dict,mode)
%--------------≤‚ ‘--------------%
%image = imread(path);

%temp = dec2bin(image);
%s = size(temp);
%binary = reshape(temp,1,s(1,1)*s(1,2));
switch mode
    case 'ENCODE'
        data = data(:);
        binary = huffmanenco(data,dict); 
    case 'DECODE' 
        data = data(:);
        binary = huffmandeco(data,dict); 
end
end
 %deco = huffmandeco(binary,dict); 
 %Ide = col2im(deco,[M,N],[M,N],'distinct'); 

% subplot(1,2,1);imshow(image);title('original image');
 %subplot(1,2,2);imshow(uint8(Ide));title('deco image');