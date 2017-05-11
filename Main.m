clc;
clear;
close all;
%---------Main文件---------%
%将图片进行加密
%请将该路径换做自己的图片，建议100*100以下分辨率，否则运行速度很慢
[R, G, B] = imageread('/Users/cailingyi/Desktop/test.jpg');
[data1, height1, width1] = encode(R);
[data2, height2, width2] = encode(G);
[data3, height3, width3] = encode(B);
image_show(data1,'encoded R')
%data = encode_test([1,0,1,0;0,1,1,1]);

%得到霍夫曼字典
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
image_show(R_decoded, 'decoded R')

%组合image
reshape_image(R_decoded,G_decoded,B_decoded)

%计算误码率
wrong(data_TDM,data_transmit,zero_amount)