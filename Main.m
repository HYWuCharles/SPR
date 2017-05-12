%���ļ���Ϊ��Ҫ�ļ���������Ϊ�������ϵͳ�ļܹ�
%���и��ļ����ǽ�����ͼƬ��Ϊ���巢�ͣ��������е����ݽ��д�������
tic
clc;
clear;
close all;
%---------Main�ļ�---------%
%��ͼƬ���м���
%�뽫��·�������Լ���ͼƬ������100*100���·ֱ��ʣ����������ٶȺ���
sprintf('���ڽ���ͼƬ��ȡ...')
[R, G, B] = imageread('/Users/ComingWind/Desktop/�ذ���ũ.jpg');
sprintf('���ڽ���ͼƬ����...')
[data1, height1, width1] = encode(R);
[data2, height2, width2] = encode(G);
[data3, height3, width3] = encode(B);
image_show(data1,'encoded R')
%data = encode_test([1,0,1,0;0,1,1,1]);

%�õ��������ֵ�
sprintf('���ڽ�����Դ����...')
dict1 = generate_huffman(data1);
dict2 = generate_huffman(data2);
dict3 = generate_huffman(data3);

%��ͼƬ���л���������
source_coded1 = source_coding_decoding(data1,dict1,'ENCODE');
source_coded2 = source_coding_decoding(data2,dict2,'ENCODE');
source_coded3 = source_coding_decoding(data3,dict3,'ENCODE');

%�����������ݽ����ŵ����루CONV��
sprintf('���ڽ����ŵ�����...')
[channel_coded1,l1] = channel_encode(source_coded1,'CONV');
[channel_coded2,l2] = channel_encode(source_coded2,'CONV');
[channel_coded3,l3] = channel_encode(source_coded3,'CONV');

%����·�źŽ���TDM
sprintf('���ڽ��г�֡����...')
%��bit��TDM����
%data_TDM = TDM(3,channel_coded1,channel_coded2, channel_coded3);
%��֡TDM����
frame_seq1 = frame_shape(channel_coded1,5);
frame_seq2 = frame_shape(channel_coded2,4);
frame_seq3 = frame_shape(channel_coded3,3);
sprintf('���ڽ��г�֡TDM����...')
[data_TDM, frame1_l, frame2_l, frame3_l, num1, num2, num3] = frame_TDM(frame_seq1, frame_seq2, frame_seq3);

%�����������ݽ���16QAM����
sprintf('���ڽ���16QAM����...')
[data_transmit, zero_amount] = modulate(data_TDM,'QAM');

%����ͨ���ŵ�
sprintf('�����ź�ͨ���ŵ�...')
received = channel(data_transmit,15);

%���
sprintf('���ڽ���16QAM���...')
demoded = demod(received,'QAM');

%ȥ��ĩβ��0
fixed = recover(demoded,zero_amount);

%��TDM
sprintf('���ڽ��г�֡TDM�⸴��...')
%������TDM����
%[fixed1, fixed2, fixed3] = deTDM(3,fixed);
%��֡TDM����
[fixed1, fixed2, fixed3] = deTDM_frame(fixed,frame1_l, frame2_l, frame3_l,l1, l2, l3, num1, num2, num3);

%���ŵ���
sprintf('���ڽ����ŵ�����...')
channel_decode1 = channel_decoded(fixed1,'CONV');
channel_decode2 = channel_decoded(fixed2,'CONV');
channel_decode3 = channel_decoded(fixed3,'CONV');

%��Դ����
sprintf('���ڽ�����Դ����...')
source_decoded1 = source_coding_decoding(channel_decode1,dict1,'DECODE');
source_decoded2 = source_coding_decoding(channel_decode2,dict2,'DECODE');
source_decoded3 = source_coding_decoding(channel_decode3,dict3,'DECODE');

%����
sprintf('���ڽ��н���...')
R_decoded = decode(source_decoded1,width1,height1);
G_decoded = decode(source_decoded2,width2,height2);
B_decoded = decode(source_decoded3,width3,height3);
image_show(R_decoded, 'decoded R')

%���image
sprintf('���ڽ���ͼƬ����...')
reshape_image(R_decoded,G_decoded,B_decoded)

%����������
sprintf('���ڽ��������ʼ���...')
wrong(data_TDM,data_transmit,zero_amount)
toc