function img = trans(image_path)

%定义每块传输长宽
width = 30;
height = 20;

%读取该图片
[R,G,B] = imageread(image_path);

%获得图片大小
[height_origin,width_origin] = size(R);

%获得分块传输滑动次数
%横向
stride_x = ceil(width_origin/width);
%纵向
stride_y = ceil(height_origin/height);

%打开画图
figure(2)
img = ones(height_origin,width_origin,3,'uint8')*255;
imshow(img)
title('接收图片')

%开始分块传输
%以在x轴上滑动为主
for i = 1:1:stride_x
    for j = 1:1:stride_y
        sprintf('正在进行第(%d,%d)次的传输',i,j)
        %构建传输块R,G,B_trans
         if i*width > width_origin
             R_temp = R(:,(i-1)*width+1:width_origin);
             G_temp = G(:,(i-1)*width+1:width_origin);
             B_temp = B(:,(i-1)*width+1:width_origin);
         else
             R_temp = R(:,(i-1)*width+1:i*width);
             G_temp = G(:,(i-1)*width+1:i*width);
             B_temp = B(:,(i-1)*width+1:i*width);
         end
         if j*height > height_origin
             R_trans = R_temp((j-1)*height+1:height_origin,:);
             G_trans = G_temp((j-1)*height+1:height_origin,:);
             B_trans = B_temp((j-1)*height+1:height_origin,:);
         else
             R_trans = R_temp((j-1)*height+1:j*height,:);
             G_trans = G_temp((j-1)*height+1:j*height,:);
             B_trans = B_temp((j-1)*height+1:j*height,:);
         end
        %送入系统
        [data1, height1, width1] = encode(R_trans);
        [data2, height2, width2] = encode(G_trans);
        [data3, height3, width3] = encode(B_trans);
       
        dict1 = generate_huffman(data1);
        dict2 = generate_huffman(data2);
        dict3 = generate_huffman(data3);
        
        %将图片进行霍夫曼编码
        source_coded1 = source_coding_decoding(data1,dict1,'ENCODE');
        source_coded2 = source_coding_decoding(data2,dict2,'ENCODE');
        source_coded3 = source_coding_decoding(data3,dict3,'ENCODE');
        
        %将编码后的数据进行信道编码（CONV）
        [channel_coded1,l1] = channel_encode(source_coded1,'CONV');
        [channel_coded2,l2] = channel_encode(source_coded2,'CONV');
        [channel_coded3,l3] = channel_encode(source_coded3,'CONV');
        
        %将多路信号进行TDM
        %单bit的TDM如下
        %data_TDM = TDM(3,channel_coded1,channel_coded2, channel_coded3);
        %成帧TDM如下
        frame_seq1 = frame_shape(channel_coded1,5);
        frame_seq2 = frame_shape(channel_coded2,4);
        frame_seq3 = frame_shape(channel_coded3,3);
        [data_TDM, frame1_l, frame2_l, frame3_l, num1, num2, num3] = frame_TDM(frame_seq1, frame_seq2, frame_seq3);

        %将待发送数据进行16QAM调制
        [data_transmit, zero_amount] = modulate(data_TDM,'QAM');

        %数据通过信道
        received = channel(data_transmit,15);

        %解调
        demoded = demod(received,'QAM');

        %去掉末尾的0
        fixed = recover(demoded,zero_amount);

        %解TDM
        %单比特TDM如下
        %[fixed1, fixed2, fixed3] = deTDM(3,fixed);
        %成帧TDM如下
        [fixed1, fixed2, fixed3] = deTDM_frame(fixed,frame1_l, frame2_l, frame3_l,l1, l2, l3, num1, num2, num3);

        %解信道码
        channel_decode1 = channel_decoded(fixed1,'CONV');
        channel_decode2 = channel_decoded(fixed2,'CONV');
        channel_decode3 = channel_decoded(fixed3,'CONV');

        %信源解码
        source_decoded1 = source_coding_decoding(channel_decode1,dict1,'DECODE');
        source_decoded2 = source_coding_decoding(channel_decode2,dict2,'DECODE');
        source_decoded3 = source_coding_decoding(channel_decode3,dict3,'DECODE');

        %解密
        R_decoded = decode(source_decoded1,width1,height1);
        G_decoded = decode(source_decoded2,width2,height2);
        B_decoded = decode(source_decoded3,width3,height3);
        
        %组合image
        img(((j-1)*height+1):min([height_origin,j*height]),((i-1)*width+1):min([width_origin,i*width]),1) = R_decoded;
        img(((j-1)*height+1):min([height_origin,j*height]),((i-1)*width+1):min([width_origin,i*width]),2) = G_decoded;
        img(((j-1)*height+1):min([height_origin,j*height]),((i-1)*width+1):min([width_origin,i*width]),3) = B_decoded;
        figure(2)
        imshow(img)
        %pause(1)
    end
end