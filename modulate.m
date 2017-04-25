function data_transmit = modulate(data, mode)
%QPSK���Ʋ���
fb = 1;%�����ź�Ƶ��
fs = 100;%��������Ƶ��
fc = 4;%�ز�Ƶ��

switch mode
    case 'FSK'
        M = 2;%���ƽ���
        freqseq = 2*fb;
        nsamp = 8;%ÿ���ŵ�������
        Fs = fs;
        data_transmit = fskmod(data,M,freqseq,nsamp,Fs);
        
    case 'QAM'
        M = 16;%16 QAM
        k = log2(M);%Number of bits per symbol
        n = length(data);
        numSamplePerSymbol = 1;%Oversampling factor
        if mod((n+1),4) == 0
            data=[data;0];
        elseif mod((n+2),4) == 0
            data = [data;0;0];
        elseif mod((n+3),4) == 0
            data = [data;0;0;0];
        end
        dataInMatrix = reshape(data,length(data)/k,k);
        dataSymbolsIn = bi2de(dataInMatrix);
        temp = qammod(dataSymbolsIn,M);
        I = real(temp);
        Q = imag(temp);
        gain = fs/fb;
        I_ = zeros(1,length(I)*gain);
        Q_ = zeros(1,length(Q)*gain);  
        for i=1:1:length(I)
            I_((i-1)*gain+1:i*gain) = I(i,1);
            Q_((i-1)*gain+1:i*gain) = Q(i,1);
        end
        b = firrcos(16,fb/2, 2*0.5*fb/2, fs);
        I_filtered = filter(b, 1, I_);%filtered I
        figure
        plot(1:1:length(I_filtered),I_filtered);
        title('I filtered');
        Q_filtered = filter(b, 1, Q_);%filtered Q
        %--------------�ϱ�Ƶ---------------%
        dt = 1/fs;%��λʱ��
        T = length(I)/fb;%ʱ�䳤��
        t = 0:dt:T-dt;%ʱ������
        %nn = 1:length(I_filtered);
        Ich = cos(2*pi*fc*t);
        figure
        plot(1:1:length(Ich),Ich);
        title('Ich');
        Qch = sin(2*pi*fc*t);
        data_transmit = I_filtered.*Ich-Q_filtered.*Qch;
        figure
        plot(1:1:length(data_transmit),data_transmit);
        title('data_transmit');
        
        
    case 'QPSK'
        %----------����ת��----------%
        n = length(data);
        I = data(1:2:n-1);
        Q = data(2:2:n);
        gain = fs/fb;
        I_ = zeros(1,length(I)*gain);
        Q_ = zeros(1,length(Q)*gain);  
        for i=1:1:length(I)
            I_((i-1)*gain+1:i*gain) = I(1,i);
            Q_((i-1)*gain+1:i*gain) = Q(1,i);
        end
        %plot(1:1:length(I_),I_);
        %----------�����������----------%
        b = firrcos(16,fb/2, 2*0.5*fb/2, fs);
        I_filtered = filter(b, 1, I_);%filtered I
        Q_filtered = filter(b, 1, Q_);%filtered Q
        
        %----------����----------%
        T = length(I)/fb;
        dt = 1/fs;
        t = 0:dt:T-dt;
        %nn = 1:length(I_filtered);
        Ich = cos(2*pi*fc*t);
        Qch = sin(2*pi*fc*t);
        %plot(nn,I'.*Ich)
        data_transmit = I_filtered.*Ich-Q_filtered.*Qch;
        figure
        plot(1:1:length(data_transmit),data_transmit);
        title('data_transmit');
end 