function transmitted = channel(data,SNR)

transmitted = awgn(data,SNR);
% dt = 1/32;%��λʱ��
% T = length(data)/1;%ʱ�䳤��
% t = 0:dt:T-dt;%ʱ������
% noise1 = cos(2*pi*3*dt);
% noise2 = cos(2*pi*5*dt);
% 
% transmitted = transmitted+noise1+noise2;
% figure
% plot(1:1:length(transmitted),fftshift(abs(fft(transmitted))))

% chan = rayleighchan(1/32, 1/100000, [0,0,0.00001],10);
% transmitted = filter(chan,data);
% figure
% plot(1:1:length(transmitted),abs(fft(transmitted)));
% title('f domain of data_transmit with noise');

end