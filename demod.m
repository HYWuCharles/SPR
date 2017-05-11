function recieved = demod(data,mode)
fc = 4;%解调载波频率4MHz
fs = 32;
fb = 1;
switch mode
    case 'QAM'
        dt = 1/fs;
        T = length(data)/(fb*fs);
        t = 0:dt:T-dt;
        Ich = data.*cos(2*pi*fc*t);
        Qch = data.*cos(2*pi*fc*t+pi/2);
        %----------低通滤波----------%
        %wp = 2*4/fs;%通带4Hz
        %ws = 2*6/fs;%阻带6Hz
        %Rp = 1;%通带起伏
        %As = 30;%衰减
        %[N,wc] = buttord(wp,ws,Rp,As);
        [B,A] = butter(2,2*fb/fs);%截止频率2*fb/fs
        Ich = 2*filter(B,A,Ich);
        Qch = 2*filter(B,A,Qch);
        
        Ich_sampled = round(Ich(fs/(2*fb):fs/fb:length(Ich)));
        %Ich_sampled
%         figure
%         stem(1:1:length(Ich_sampled),Ich_sampled);
%         title('Ich_sampled');
        Qch_sampled = round(Qch(fs/(2*fb):fs/fb:length(Qch)));
        %Qch_sampled
%         figure
%         stem(1:1:length(Qch_sampled),Qch_sampled);
%         title('Qch_sampled');
        
        recovered = Ich_sampled+Qch_sampled*1i;
        
        recieved = qamdemod(recovered,16,'bin');
%         figure
%         stem(1:1:length(recieved),recieved)
%         title('解调')
        
    case 'QPSK'
        dt = 1/fs;
        T = length(data)/(fb*fs);
        t = 0:dt:T-dt;
        %下变频
        Ich = data.*cos(2*pi*fc*t);
        Qch = data.*cos(2*pi*fc*t+pi/2);
        %巴特沃斯滤波器
        [B,A] = butter(2,2*fb/fs);%截止频率2*fb/fs
        Ich = 2*filter(B,A,Ich);
        Qch = 2*filter(B,A,Qch);
        %抽样判决
        Ich_sampled = round(Ich(fs/(2*fb):fs/fb:length(Ich)));
        %Ich_sampled
%         figure
%         stem(1:1:length(Ich_sampled),Ich_sampled);
%         title('Ich_sampled');
        Qch_sampled = round(Qch(fs/(2*fb):fs/fb:length(Qch)));
        
        temp = zeros(1,2*length(Ich_sampled));
        for i=1:1:length(Ich_sampled)
            temp(1,2*i-1) = Ich_sampled(1,i);
            temp(1,2*i) = Qch_sampled(1,i);
        end
        recieved = temp;
        
end

end