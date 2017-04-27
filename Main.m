%clc;
%clear;
close all;
%---------Main文件---------%
%将图片进行加密
%data = encode('/Users/ComingWind/Desktop/aqi.png');
data = encode_test([1,0,1,0;0,1,1,1]);

%将图片进行霍夫曼编码
data = img2bins(data);

%将编码后的数据进行信道编码（卷积码）
data = channel_encode(data,'CRC');

%将待发送数据进行16QAM调制
data_transmit = modulate(data,'QAM');

%数据通过信道
transmitted = channel(data_transmit);

%解调
received = demod(transmitted,'QAM');

%解信道码
