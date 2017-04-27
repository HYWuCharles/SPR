function cout=convcode(cin)
%本函数实现（2，1，2）卷积编码，输入为cin
%编码后输出为cout
%其中生成多项式g11=g(1,1)=[1 1 1],
%g12=g(1,2)=[1 0 1];
%cin=[0 1 1 0 1 0 0 0 0 1];
g11=[1 1 1];        %定义生成多项式
g12=[1 0 1];
cout=[];            %定义输出矩阵
regist=zeros(1,length(g11));     %初始化寄存器为0,长度与生成多项式矩阵长度一样
for i=1:length(cin)     %控制循环编码
    for j=length(regist):-1:2   %寄存器循环移位
        regist(j)=regist(j-1);
    end
    regist(1)=cin(i);           %将需要编码的码子一位一位的移至寄存器
    c1=sum(regist.*g11);      %输出码字c1
    c2=sum(regist.*g12);      %输出码字c2
    cout=[cout c1 c2];        %将码字保存至输出码字中
end
    cout=mod(cout,2)  ;              %求模2运算
end