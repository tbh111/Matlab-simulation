function [result] = LSB_decode(src)
% 恢复LSB隐藏图片信息
[rows1,cols1,dim] = size(src);
if dim == 1
    result = zeros(rows1,cols1);
    for i=1:rows1
        for j=1:cols1
            if bitget(src(i,j),1) == 1
                result(i,j) = 1;
            else
                continue;
            end
        end
    end
else
    result = zeros(rows1,cols1,3);
    for i=1:rows1
        for j=1:cols1
            for k = 1:3
                if bitget(src(i,j,k),1) == 1
                    result(i,j,k) = 1;
                else
                    continue;
                end
            end
        end
    end
end
