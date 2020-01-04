function [y] = Pool2x2(x)

y = zeros(size(x,1)/2,size(x,2)/2,size(x,3));
for k = 1:size(x,3)
    for j = 1:2:size(x,2)
        for i = 1:2:size(x,1)
            temp = [x(i,j,k),x(i+1,j,k),x(i,j+1,k),x(i+1,j+1,k)];
            y((i+1)/2,(j+1)/2,k) = max(temp);
        end
    end
end
    