function data = TDM(n, sig1, sig2, sig3)

if nargin == 3
    sig1_l = length(sig1);
    sig2_l = length(sig2);
    max_length = max(sig1_l, sig2_l);
    type = 'TWO';
end

if nargin == 4
    sig1_l = length(sig1);
    sig2_l = length(sig2);
    sig3_l = length(sig3);
    max_length = max([sig1_l, sig2_l, sig3_l]);
    type = 'THREE';
end


data = zeros(max_length,1)*n;

%组织TDM的信息序列，若超出则以0补齐
switch type
    case 'TWO'
        for i = 1:1:max_length
            if(i > length(sig1))
                slot1 = nan;
            else
                slot1 = sig1(i,1);
            end
            if(i > length(sig2))
                slot2 = nan;
            else
                slot2 = sig2(i,1);
            end
            data(2*i-1,1) = slot1;
            data(2*i,1) = slot2;
        end
    case 'THREE'
        for i = 1:1:max_length
            if(i > length(sig1))
                slot1 = nan;
            else
                slot1 = sig1(i,1);
            end
            if(i > length(sig2))
                slot2 = nan;
            else
                slot2 = sig2(i,1);
            end
            if(i > length(sig3))
                slot3 = nan;
            else
                slot3 = sig3(i,1);
            end
            data(3*i-2,1) = slot1;
            data(3*i-1,1) = slot2;
            data(3*i,1) = slot3;
        end
end

end