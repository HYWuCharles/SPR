clc;
clear;
close all;
%---------Main�ļ�---------%
%��ͼƬ���м���
[data, height, width] = encode('/Users/ComingWind/Desktop/aqi.png');
%data = encode_test([1,0,1,0;0,1,1,1]);

%�õ��������ֵ�
dict = generate_huffman(data);

%��ͼƬ���л���������
source_coded = source_coding_decoding(data,dict,'ENCODE');

%�����������ݽ����ŵ����루CRC��
channel_coded = channel_encode(source_coded,'CONV');

%�����������ݽ���16QAM����
[data_transmit, zero_amount] = modulate(channel_coded,'QPSK');

%����ͨ���ŵ�
received = channel(data_transmit);

%���
demoded = demod(received,'QPSK');

%ȥ��ĩβ��0
fixed = recover(demoded,zero_amount);

%���ŵ���
channel_decode = channel_decoded(fixed,'CONV');

%��Դ����
source_decoded = source_coding_decoding(channel_decode,dict,'DECODE');

%����
image = decode(source_decoded,width,height);