%clc;
%clear;
close all;
%---------Main�ļ�---------%
%��ͼƬ���м���
%data = encode('/Users/ComingWind/Desktop/aqi.png');
data = encode_test([1,0,1,0;0,1,1,1]);

%��ͼƬ���л���������
data = img2bins(data);

%�����������ݽ����ŵ����루����룩
data = channel_encode(data,'CRC');

%�����������ݽ���16QAM����
data_transmit = modulate(data,'QAM');

%����ͨ���ŵ�
transmitted = channel(data_transmit);

%���
received = demod(transmitted,'QAM');

%���ŵ���
