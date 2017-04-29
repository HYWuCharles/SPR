function fixed = recover(data,amount)

temp = reshape(data,length(data),1);
temp1 = de2bi(temp);
[a,b] = size(temp1);
temp2 = reshape(temp1,a*b,1);
fixed = temp2(1:end-amount,1);

end