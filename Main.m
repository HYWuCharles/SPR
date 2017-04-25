%---------Main文件---------%
%将图片进行加密
data = encode('/Users/ComingWind/Desktop/test.jpg');

%将图片进行霍夫曼编码
data = img2bins(data);

%将图片进行16QAM调制
data_transmit = modulate(data,'QAM');