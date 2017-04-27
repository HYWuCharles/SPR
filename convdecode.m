function desiganl=convdecode(signal)
%������ʵ�֣�2��1��2��������룬��Ҫ������ź�signal
%��������Ϊdesignal
%�������ɶ���ʽg11=g(1,1)=[1 1 1],
%g12=g(1,2)=[1 0 1];
%signal=[0 0 1 1 0 1 0 1 0 0 1 0 1 1 0 0 0 0 1 1];
 Ls=fix(length(signal)/2);  %���ԭ����Ҫ����ĳ��ȣ��ָ�ԭ�ź�
% signal=[signal zeros(1,6*2)];  % Ϊ���ý���·���鲢��һ����
%%��ʼ��ÿһ����ǰ2��״̬����Ϊǰ2������Ҫ�Ƚϣ��жϣ�
%%state��ʾ������·����code��ʾ�������Ӧ���ӣ�diff��ʾ����յ����ֵĲ�ͬ����
s(1).state=[0 0 0 0];s(1).code=[0 0];
s(2).state=[0 0 1 1];s(2).code=[0 1];
s(3).state=[1 1 1 0];s(3).code=[1 0];
s(4).state=[1 1 0 1];s(4).code=[1 1];
for i=1:4
    s(i).diff=sum(signal(1:4)~=s(i).state);
end
for i=3:fix(length(signal)/2)           %��3�Ժ��״̬����
    %%%�����Ƕ�s(1)�Ĵ������������
    temp1=[s(1).state 0 0];             %2�������ֱ��ŵ����״̬��2��·��
    temp2=[s(3).state 1 1];
    diff1=sum(signal(1:i*2)~=temp1);     %�ֱ������2��·�����յ������ֵĲ�ͬ����
    diff2=sum(signal(1:i*2)~=temp2);
    if diff1<diff2                      %�ж�����·����̣������������diff��ʱ����
        fs(1).state=temp1;              %Ϊ�˲�Ӱ�����s2,s3,s4�Ĵ���
        fs(1).code=[s(1).code 0];
        fs(1).diff=diff1;
    else
        fs(1).state=temp2;
        fs(1).code=[s(3).code 0];
        fs(1).diff=diff2;
    %    fs(1).diff=diff2;
    end
    
       %%%�����Ƕ�s(2)�Ĵ���ͬs��1��
    temp1=[s(1).state 1 1];             %2�������ֱ��ŵ����״̬��2��·��
    temp2=[s(3).state 0 0];
    diff1=sum(signal(1:i*2)~=temp1);     %�ֱ������2��·�����յ������ֵĲ�ͬ����
    diff2=sum(signal(1:i*2)~=temp2);
    if diff1<diff2                      %�ж�����·����̣������������diff��ʱ����
        fs(2).state=temp1;              %Ϊ�˲�Ӱ�����s2,s3,s4�Ĵ���
        fs(2).code=[s(1).code 1];
        fs(2).diff=diff1;
    else
        fs(2).state=temp2;
        fs(2).code=[s(3).code 1];
        fs(2).diff=diff2;
    end  
    
      %%%�����Ƕ�s(3)�Ĵ���ͬs��1��
    temp1=[s(2).state 1 0];             %2�������ֱ��ŵ����״̬��2��·��
    temp2=[s(4).state 0 1];
    diff1=sum(signal(1:i*2)~=temp1);     %�ֱ������2��·�����յ������ֵĲ�ͬ����
    diff2=sum(signal(1:i*2)~=temp2);
    if diff1<diff2                      %�ж�����·����̣������������diff��ʱ����
        fs(3).state=temp1;              %Ϊ�˲�Ӱ�����s2,s3,s4�Ĵ���
        fs(3).code=[s(2).code 0];
        fs(3).diff=diff1;
    else
        fs(3).state=temp2;
        fs(3).code=[s(4).code 0];
        fs(3).diff=diff2;
    end
     %%%�����Ƕ�s(4)�Ĵ���ͬs��1��
    temp1=[s(2).state 0 1];             %2�������ֱ��ŵ����״̬��2��·��
    temp2=[s(4).state 1 0];
    diff1=sum(signal(1:i*2)~=temp1);     %�ֱ������2��·�����յ������ֵĲ�ͬ����
    diff2=sum(signal(1:i*2)~=temp2);
    if diff1<diff2                      %�ж�����·����̣������������diff��ʱ����
        fs(4).state=temp1;              %Ϊ�˲�Ӱ�����s2,s3,s4�Ĵ���
        fs(4).code=[s(2).code 1];
        fs(4).diff=diff1;
    else
        fs(4).state=temp2;
        fs(4).code=[s(4).code 1];
        fs(4).diff=diff2;
    end  
    s=fs;
end
diff=[s(1).diff s(2).diff s(3).diff s(4).diff];     %�洢4��·����״̬�����ֲ�ͬ����
Min=min(diff);                                      %�ҵ���Сֵ
i=find(Min==diff);                                  %�ҵ���Сֵ���±�
na=s(min(i)).code;                                   %������֣�����2�����ϵ�ѡ��i��С��
desiganl=na(1:Ls);                                    %��Ϊ���油��0������ȥ��
end


