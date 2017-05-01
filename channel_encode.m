function dataEnc = channel_encode(data,mode)

switch mode
    case 'CONV'
        %Set the trellis structure and traceback length for a rate 1/2
        %constraint length 7, convolutional code.
        trellis = poly2trellis(7,[171,133]);
        %tbl = 32;
        %rate = 1/2;
        
        dataEnc = convenc(data,trellis);
        
        %dataEnc = convcode(data);
        %dataEnc = transpose(dataEnc);
        
    case 'CRC'
        g = [1 0 0 1 1];
        R = length(g)-1;
        data = transpose(data);
        [q,r] = deconv([data zeros(1,R)],g);
        r = mod(r(end-R+1:end),2);
        dataEnc = [data,r];
        dataEnc = transpose(dataEnc);
end
