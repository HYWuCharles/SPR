function img = trans(image_path)

%����ÿ�鴫�䳤��
width = 30;
height = 20;

%��ȡ��ͼƬ
[R,G,B] = imageread(image_path);

%���ͼƬ��С
[height_origin,width_origin] = size(R);

%��÷ֿ鴫�们������
%����
stride_x = ceil(width_origin/width);
%����
stride_y = ceil(height_origin/height);

%�򿪻�ͼ
figure(2)
img = ones(height_origin,width_origin,3,'uint8')*255;
imshow(img)
title('����ͼƬ')

%��ʼ�ֿ鴫��
%����x���ϻ���Ϊ��
for i = 1:1:stride_x
    for j = 1:1:stride_y
        sprintf('���ڽ��е�(%d,%d)�εĴ���',i,j)
        %���������R,G,B_trans
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
        %����ϵͳ
        [data1, height1, width1] = encode(R_trans);
        [data2, height2, width2] = encode(G_trans);
        [data3, height3, width3] = encode(B_trans);
       
        dict1 = generate_huffman(data1);
        dict2 = generate_huffman(data2);
        dict3 = generate_huffman(data3);
        
        %��ͼƬ���л���������
        source_coded1 = source_coding_decoding(data1,dict1,'ENCODE');
        source_coded2 = source_coding_decoding(data2,dict2,'ENCODE');
        source_coded3 = source_coding_decoding(data3,dict3,'ENCODE');
        
        %�����������ݽ����ŵ����루CONV��
        [channel_coded1,l1] = channel_encode(source_coded1,'CONV');
        [channel_coded2,l2] = channel_encode(source_coded2,'CONV');
        [channel_coded3,l3] = channel_encode(source_coded3,'CONV');
        
        %����·�źŽ���TDM
        %��bit��TDM����
        %data_TDM = TDM(3,channel_coded1,channel_coded2, channel_coded3);
        %��֡TDM����
        frame_seq1 = frame_shape(channel_coded1,5);
        frame_seq2 = frame_shape(channel_coded2,4);
        frame_seq3 = frame_shape(channel_coded3,3);
        [data_TDM, frame1_l, frame2_l, frame3_l, num1, num2, num3] = frame_TDM(frame_seq1, frame_seq2, frame_seq3);

        %�����������ݽ���16QAM����
        [data_transmit, zero_amount] = modulate(data_TDM,'QAM');

        %����ͨ���ŵ�
        received = channel(data_transmit,15);

        %���
        demoded = demod(received,'QAM');

        %ȥ��ĩβ��0
        fixed = recover(demoded,zero_amount);

        %��TDM
        %������TDM����
        %[fixed1, fixed2, fixed3] = deTDM(3,fixed);
        %��֡TDM����
        [fixed1, fixed2, fixed3] = deTDM_frame(fixed,frame1_l, frame2_l, frame3_l,l1, l2, l3, num1, num2, num3);

        %���ŵ���
        channel_decode1 = channel_decoded(fixed1,'CONV');
        channel_decode2 = channel_decoded(fixed2,'CONV');
        channel_decode3 = channel_decoded(fixed3,'CONV');

        %��Դ����
        source_decoded1 = source_coding_decoding(channel_decode1,dict1,'DECODE');
        source_decoded2 = source_coding_decoding(channel_decode2,dict2,'DECODE');
        source_decoded3 = source_coding_decoding(channel_decode3,dict3,'DECODE');

        %����
        R_decoded = decode(source_decoded1,width1,height1);
        G_decoded = decode(source_decoded2,width2,height2);
        B_decoded = decode(source_decoded3,width3,height3);
        
        %���image
        img(((j-1)*height+1):min([height_origin,j*height]),((i-1)*width+1):min([width_origin,i*width]),1) = R_decoded;
        img(((j-1)*height+1):min([height_origin,j*height]),((i-1)*width+1):min([width_origin,i*width]),2) = G_decoded;
        img(((j-1)*height+1):min([height_origin,j*height]),((i-1)*width+1):min([width_origin,i*width]),3) = B_decoded;
        figure(2)
        imshow(img)
        %pause(1)
    end
end