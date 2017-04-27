function decoded = channel_decoded(data, mode)

switch mode
    case 'CONV'
        data = de2bi(data);
        %[a,b] = size(data);
        %data = reshape(data,a*b,1);

        %t = poly2trellis(7,[171,133]);

        %decoded = vitdec(data,t,2,'trunc','hard');
        decoded = convdecode(data);
        
    case 'CRC'
        g = [1 0 0 1 1];
        temp = de2bi(data);
        [a,b] = size(temp);
        temp = reshape(temp,1,a*b);
        [q,r] = deconv(temp,g);
        r = mod(r(end-4+1:end),2);
        
        decoded = data(1:length(data)-4);
        
end
end