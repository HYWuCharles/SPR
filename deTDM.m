function varargout = deTDM(n, data)

l = length(data);

if n == 2
    mode = 'TWO';
    data1 = [];
    data2 = [];
elseif n == 3
    mode = 'THREE';
    data1 = [];
    data2 = [];
    data3 = [];
end

switch mode
    case 'TWO'
        for i = 1:1:l/n
            if isnan(data(2*i-1,1))
                data1 = [data1;data(2*i-1)];
            end
            if isnan(data(2*i,1))
                data2 = [data2;data(2*i)];
            end
        end
        varargout{1} = data1;
        varargout{2} = data2;
        
    case 'THREE'
        for i = 1:1:l/n
            if ~isnan(data(3*i-2,1))
                data1 = [data1;data(3*i-2)];
            end
            if ~isnan(data(3*i-1,1))
                data2 = [data2;data(3*i-1)];
            end
            if ~isnan(data(3*i,1))
                data3 = [data3;data(3*i)];
            end
        end
        varargout{1} = data1;
        varargout{2} = data2;
        varargout{3} = data3;
end

end