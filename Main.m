%---------Main�ļ�---------%
%��ͼƬ���м���
data = encode('/Users/ComingWind/Desktop/test.jpg');

%��ͼƬ���л���������
data = img2bins(data);

%��ͼƬ����16QAM����
data_transmit = modulate(data,'QAM');