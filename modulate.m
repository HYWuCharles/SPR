function [data_transmit, zero] = modulate(data, mode)
%QPSK调制不好
fb = 1;%基带信号频率 1MHz
fs = 32;%基带采样频率 100MHz
fc = 4;%载波频率 4MHz

switch mode
    case 'FSK'
        M = 2;%调制阶数
        freqseq = 2*fb;
        nsamp = 8;%每符号的样本数
        Fs = fs;
        data_transmit = fskmod(data,M,freqseq,nsamp,Fs);

    case 'QAM'
        M = 16;%16 QAM
        k = log2(M);%Number of bits per symbol
        n = length(data);
        numSamplePerSymbol = 1;%Oversampling factor
        if mod((n+1),4) == 0
            data=[data;0];
            zero = 1;
        elseif mod((n+2),4) == 0
            data = [data;0;0];
            zero = 2;
        elseif mod((n+3),4) == 0
            data = [data;0;0;0];
            zero = 3;
        else
            zero = 0;
        end
        dataInMatrix = reshape(data,length(data)/k,k);
        dataSymbolsIn = bi2de(uint8(dataInMatrix));
        %test = dataSymbolsIn;
        %dataSymbolsIn
%         figure
%         stem(1:1:length(dataSymbolsIn),dataSymbolsIn)
%         title('调制数据')
        temp = qammod(dataSymbolsIn,M,'bin');
        I = real(temp);
        %I'
%         figure
%         stem(1:1:length(I),I);
%         title('I');
        Q = imag(temp);
        %Q'
%         figure
%         stem(1:1:length(Q),Q);
%         title('Q');
        gain = fs/fb;
        I_ = zeros(1,length(I)*gain);
        Q_ = zeros(1,length(Q)*gain);  
        for i=1:1:length(I)
            I_((i-1)*gain+1:i*gain) = I(i,1);
            Q_((i-1)*gain+1:i*gain) = Q(i,1);
        end
        %h = hamming(length(I_));
        %I_ = I_.*h;
        %Q_ = Q_.*h;
        %b = firrcos(16,fb/2, 2*0.5*fb/2, fs);
        %I_filtered = filter(b, 1, I_);%filtered I
        %figure
        %plot(1:1:length(I_filtered),I_filtered);
        %title('I filtered');
       % Q_filtered = filter(b, 1, Q_);%filtered Q
        %--------------上变频---------------%
        dt = 1/fs;%单位时间
        T = length(I)/fb;%时间长度
        t = 0:dt:T-dt;%时间序列
        %nn = 1:length(I_filtered);
        Ich = cos(2*pi*fc*t);
%         figure
%         plot(1:1:length(I_filtered),I_filtered);
%         title('Ich');
        Qch = sin(2*pi*fc*t);
        %figure
        %plot(1:1:length(Q_filtered),Q_filtered);
        %title('Qch');
        %data_transmit = I_filtered.*Ich-Q_filtered.*Qch;
        data_transmit = I_.*Ich-Q_.*Qch;
%         figure
%         plot(1:1:length(data_transmit),data_transmit);
%         title('data_transmit');
%         figure
%         plot(1:1:length(data_transmit),abs(fft(data_transmit)));
%         title('f domain of data_transmit');
        
        
    case 'QPSK'
        %----------串并转换----------%
        n = length(data);
        if mod((n+1),4) == 0
            data=[data;0];
            zero = 1;
        elseif mod((n+2),4) == 0
            data = [data;0;0];
            zero = 2;
        elseif mod((n+3),4) == 0
            data = [data;0;0;0];
            zero = 3;
        else
            zero = 0;
        end
        I = data(1:2:n-1);
        Q = data(2:2:n);
        gain = fs/fb;
        I_ = zeros(1,length(I)*gain);
        Q_ = zeros(1,length(Q)*gain);  
        for i=1:1:length(I)
            I_((i-1)*gain+1:i*gain) = I(i,1);
            Q_((i-1)*gain+1:i*gain) = Q(i,1);
        end
        %plot(1:1:length(I_),I_);
        %----------基带脉冲成形----------%
        %b = firrcos(16,fb/2, 2*0.5*fb/2, fs);
        %I_filtered = filter(b, 1, I_);%filtered I
        %Q_filtered = filter(b, 1, Q_);%filtered Q
        
        %----------调制----------%
        T = length(I)/fb;
        dt = 1/fs;
        t = 0:dt:T-dt;
        %nn = 1:length(I_filtered);
        Ich = cos(2*pi*fc*t);
        Qch = sin(2*pi*fc*t);
        %plot(nn,I'.*Ich)
        data_transmit = I_.*Ich-Q_.*Qch;
%         figure
%         plot(1:1:length(data_transmit),data_transmit);
%         title('data_transmit');
end 