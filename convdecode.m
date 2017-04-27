function desiganl=convdecode(signal)
%本函数实现（2，1，2）卷积译码，需要译码的信号signal
%译码后输出为designal
%其中生成多项式g11=g(1,1)=[1 1 1],
%g12=g(1,2)=[1 0 1];
%signal=[0 0 1 1 0 1 0 1 0 0 1 0 1 1 0 0 0 0 1 1];
 Ls=fix(length(signal)/2);  %求出原来需要解码的长度，恢复原信号
% signal=[signal zeros(1,6*2)];  % 为了让解码路径归并到一条上
%%初始化每一个的前2个状态（因为前2个不需要比较，判断）
%%state表示经过的路径，code表示译出得相应码子，diff表示与接收到码字的不同个数
s(1).state=[0 0 0 0];s(1).code=[0 0];
s(2).state=[0 0 1 1];s(2).code=[0 1];
s(3).state=[1 1 1 0];s(3).code=[1 0];
s(4).state=[1 1 0 1];s(4).code=[1 1];
for i=1:4
    s(i).diff=sum(signal(1:4)~=s(i).state);
end
for i=3:fix(length(signal)/2)           %对3以后的状态处理
    %%%以下是对s(1)的处理，后面的类似
    temp1=[s(1).state 0 0];             %2个变量分别存放到这个状态的2条路径
    temp2=[s(3).state 1 1];
    diff1=sum(signal(1:i*2)~=temp1);     %分别就算这2条路径接收到的码字的不同个数
    diff2=sum(signal(1:i*2)~=temp2);
    if diff1<diff2                      %判断哪条路径最短，并处理，存放至diff临时变量
        fs(1).state=temp1;              %为了不影响后面s2,s3,s4的处理
        fs(1).code=[s(1).code 0];
        fs(1).diff=diff1;
    else
        fs(1).state=temp2;
        fs(1).code=[s(3).code 0];
        fs(1).diff=diff2;
    %    fs(1).diff=diff2;
    end
    
       %%%以下是对s(2)的处理，同s（1）
    temp1=[s(1).state 1 1];             %2个变量分别存放到这个状态的2条路径
    temp2=[s(3).state 0 0];
    diff1=sum(signal(1:i*2)~=temp1);     %分别就算这2条路径接收到的码字的不同个数
    diff2=sum(signal(1:i*2)~=temp2);
    if diff1<diff2                      %判断哪条路径最短，并处理，存放至diff临时变量
        fs(2).state=temp1;              %为了不影响后面s2,s3,s4的处理
        fs(2).code=[s(1).code 1];
        fs(2).diff=diff1;
    else
        fs(2).state=temp2;
        fs(2).code=[s(3).code 1];
        fs(2).diff=diff2;
    end  
    
      %%%以下是对s(3)的处理，同s（1）
    temp1=[s(2).state 1 0];             %2个变量分别存放到这个状态的2条路径
    temp2=[s(4).state 0 1];
    diff1=sum(signal(1:i*2)~=temp1);     %分别就算这2条路径接收到的码字的不同个数
    diff2=sum(signal(1:i*2)~=temp2);
    if diff1<diff2                      %判断哪条路径最短，并处理，存放至diff临时变量
        fs(3).state=temp1;              %为了不影响后面s2,s3,s4的处理
        fs(3).code=[s(2).code 0];
        fs(3).diff=diff1;
    else
        fs(3).state=temp2;
        fs(3).code=[s(4).code 0];
        fs(3).diff=diff2;
    end
     %%%以下是对s(4)的处理，同s（1）
    temp1=[s(2).state 0 1];             %2个变量分别存放到这个状态的2条路径
    temp2=[s(4).state 1 0];
    diff1=sum(signal(1:i*2)~=temp1);     %分别就算这2条路径接收到的码字的不同个数
    diff2=sum(signal(1:i*2)~=temp2);
    if diff1<diff2                      %判断哪条路径最短，并处理，存放至diff临时变量
        fs(4).state=temp1;              %为了不影响后面s2,s3,s4的处理
        fs(4).code=[s(2).code 1];
        fs(4).diff=diff1;
    else
        fs(4).state=temp2;
        fs(4).code=[s(4).code 1];
        fs(4).diff=diff2;
    end  
    s=fs;
end
diff=[s(1).diff s(2).diff s(3).diff s(4).diff];     %存储4条路径的状态与码字不同个数
Min=min(diff);                                      %找到最小值
i=find(Min==diff);                                  %找到最小值的下标
na=s(min(i)).code;                                   %译出码字，若有2条以上的选择i较小的
desiganl=na(1:Ls);                                    %因为后面补了0，现在去掉
end


