function frame_seq = frame_shape(data, n)

%½«Êý¾Ý²¹Æë
for i = 1:1:n-1
    if mod(length(data),n) ~= 0
        data = [data;NaN];
    elseif mod(length(data),n) == 0
        break;
    end
end

frame_seq = reshape(data,length(data)/n,n);

end