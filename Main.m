clc;
clear;
close all;
%---------Main文件---------%
%将图片进行加密
[data, height, width] = encode('/Users/ComingWind/Desktop/aqi.png');
%data = encode_test([1,0,1,0;0,1,1,1]);

%得到霍夫曼字典
dict = generate_huffman(data);

%将图片进行霍夫曼编码
source_coded = source_coding_decoding(data,dict,'ENCODE');

%将编码后的数据进行信道编码（CRC）
channel_coded = channel_encode(source_coded,'CONV');

%将待发送数据进行16QAM调制
[data_transmit, zero_amount] = modulate(channel_coded,'QPSK');

%数据通过信道
received = channel(data_transmit);

%解调
demoded = demod(received,'QPSK');

%去掉末尾的0
fixed = recover(demoded,zero_amount);

%解信道码
channel_decode = channel_decoded(fixed,'CONV');

%信源解码
source_decoded = source_coding_decoding(channel_decode,dict,'DECODE');

%解密
image = decode(source_decoded,width,height);