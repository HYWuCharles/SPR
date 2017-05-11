function [data, frame1_l, frame2_l, frame3_l, num1, num2, num3] = frame_TDM(sig1, sig2, sig3)
%成帧时分复用

[size_a1, size_b1] = size(sig1);
[size_a2, size_b2] = size(sig2);
[size_a3, size_b3] = size(sig3);
frame1_l = size_b1;
frame2_l = size_b2;
frame3_l = size_b3;
num1 = size_a1;
num2 = size_a2;
num3 = size_a3;
data = [];

for i = 1:1:max([size_a1,size_a2,size_a3])
    if i > size_a1
        slot1(1,1:size_b1) = NaN;
    else
        slot1 = sig1(i,:);
    end
    if i > size_a2
        slot2(1,1:size_b2) = NaN;
    else
        slot2 = sig2(i,:);
    end
    if i > size_a3
        slot3(1,1:size_b3) = NaN;
    else
        slot3 = sig3(i,:);
    end
    data = [data,slot1,slot2,slot3];
end
    data = reshape(data, length(data), 1);

end