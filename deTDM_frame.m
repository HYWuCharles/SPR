function varargout = deTDM_frame(data, frame1_l, frame2_l, frame3_l, l1, l2, l3, num1, num2, num3)

data = reshape(data, 1,length(data));
group_num = length(data)/(frame1_l+frame2_l+frame3_l);

temp1 = zeros(group_num,frame1_l);
temp2 = zeros(group_num,frame2_l);
temp3 = zeros(group_num,frame3_l);

for i = 1:1:group_num
    temp1(i,:) = data(1,(i-1)*(frame1_l+frame2_l+frame3_l)+1:(i-1)*(frame1_l+frame2_l+frame3_l)+frame1_l);
    temp2(i,:) = data(1,(i-1)*(frame1_l+frame2_l+frame3_l)+1+frame1_l:(i-1)*(frame1_l+frame2_l+frame3_l)+frame1_l+frame2_l);
    temp3(i,:) = data(1,(i-1)*(frame1_l+frame2_l+frame3_l)+1+frame1_l+frame2_l:i*(frame1_l+frame2_l+frame3_l));
end

temp1 = temp1(1:num1,:);
[a,b] = size(temp1);
temp1 = reshape(temp1, a*b,1);

temp2 = temp2(1:num2,:);
[a,b] = size(temp2);
temp2 = reshape(temp2, a*b,1);

temp3 = temp3(1:num3,:);
[a,b] = size(temp3);
temp3 = reshape(temp3, a*b,1);



temp1 = temp1(1:1:l1,1);
temp2 = temp2(1:1:l2,1);
temp3 = temp3(1:1:l3,1);
    
% for i = 1:1:length(temp2)
%     if ~isnan(temp2(i,1))
%         temp2_o(i,1) = temp2(i,1);
%     end
% end
% 
% for i = 1:1:length(temp3)
%     if ~isnan(temp3(i,1))
%         temp3_o(i,1) = temp3(i,1);
%     end
% end

varargout{1} = temp1;
varargout{2} = temp2;
varargout{3} = temp3;

end