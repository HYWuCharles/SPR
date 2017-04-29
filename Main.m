clc;
clear;
close all;
%---------Main�ļ�---------%
%��ͼƬ���м���
%data = encode('/Users/ComingWind/Desktop/aqi.png');
data = encode_test([1,0,1,0;0,1,1,1]);

%�õ��������ֵ�
dict = generate_huffman(data);

%��ͼƬ���л���������
source_coded = source_coding_decoding(data,dict,'ENCODE');

%�����������ݽ����ŵ����루CRC��
channel_coded = channel_encode(source_coded,'CRC');

%�����������ݽ���16QAM����
[data_transmit, zero_amount] = modulate(channel_coded,'QAM');

%����ͨ���ŵ�
received = channel(data_transmit);

%���
demoded = demod(received,'QAM');

%ȥ��ĩβ��0
fixed = recover(demoded,zero_amount);

%���ŵ���
channel_decode = channel_decoded(fixed,'CRC');

%��Դ����
source_decoded = source_coding_decoding(channel_decode,dict,'DECODE');