function cout=convcode(cin)
%������ʵ�֣�2��1��2��������룬����Ϊcin
%��������Ϊcout
%�������ɶ���ʽg11=g(1,1)=[1 1 1],
%g12=g(1,2)=[1 0 1];
%cin=[0 1 1 0 1 0 0 0 0 1];
g11=[1 1 1];        %�������ɶ���ʽ
g12=[1 0 1];
cout=[];            %�����������
regist=zeros(1,length(g11));     %��ʼ���Ĵ���Ϊ0,���������ɶ���ʽ���󳤶�һ��
for i=1:length(cin)     %����ѭ������
    for j=length(regist):-1:2   %�Ĵ���ѭ����λ
        regist(j)=regist(j-1);
    end
    regist(1)=cin(i);           %����Ҫ���������һλһλ�������Ĵ���
    c1=sum(regist.*g11);      %�������c1
    c2=sum(regist.*g12);      %�������c2
    cout=[cout c1 c2];        %�����ֱ��������������
end
    cout=mod(cout,2)  ;              %��ģ2����
end