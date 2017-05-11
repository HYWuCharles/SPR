function wrong(data_TDM,transmit,zero_amount)

for i = 1:1:length(data_TDM)
    if isnan(data_TDM(i,1))
        data_TDM(i,1) = 0;
    end
end

for SNR = 10:1:17
    for i = 1:1:20
        receive = channel(transmit,SNR);
        demoded = demod(receive,'QAM');
        fixed = recover(demoded,zero_amount);
        temp(1,i) = length(find(data_TDM ~= fixed))/length(data_TDM);
    end
    EBR(1,SNR-9) = mean(temp);
end

figure
plot(10:1:17,EBR)
%set(gca,'YTick', [10^-7,10^-6,10^-5,10^-4,10^-3])
title('ÎóÂëÂÊ')
xlabel('SNR dB')
ylabel('EBR')

end