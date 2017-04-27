function dataEnc = channel_encode(data,mode)

switch mode
    case 'CONV'
        %Set the trellis structure and traceback length for a rate 1/2
        %constraint length 7, convolutional code.
        trellis = poly2trellis(7,[171,133]);
        %tbl = 32;
        %rate = 1/2;
        
        dataEnc = convenc(data,trellis);
end
