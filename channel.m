function transmitted = channel(data,SNR)

transmitted = awgn(data,SNR);

% chan = rayleighchan(1/32, 1/100000, [0,0,0.00001],10);
% transmitted = filter(chan,data);
% figure
% plot(1:1:length(transmitted),abs(fft(transmitted)));
% title('f domain of data_transmit with noise');

end