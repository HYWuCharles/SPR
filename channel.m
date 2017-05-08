function transmitted = channel(data)

transmitted = awgn(data,15);
% figure
% plot(1:1:length(transmitted),abs(fft(transmitted)));
% title('f domain of data_transmit with noise');

end