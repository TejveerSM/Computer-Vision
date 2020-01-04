function [dLdx] = Pool2x2_backward(dLdy, x, y)

dLdx = zeros(size(x));

for k = 1:size(x,3)
    for j = 1:2:size(x,2)
        for i = 1:2:size(x,1)
            if (x(i,j,k) == y((i+1)/2,(j+1)/2,k))
                dLdx(i,j,k) = dLdy((i+1)/2,(j+1)/2,k);
            elseif (x(i+1,j,k) == y((i+1)/2,(j+1)/2,k))
                dLdx(i+1,j,k) = dLdy((i+1)/2,(j+1)/2,k);
            elseif (x(i,j+1,k) == y((i+1)/2,(j+1)/2,k))
                dLdx(i,j+1,k) = dLdy((i+1)/2,(j+1)/2,k);
            else
                dLdx(i+1,j+1,k) = dLdy((i+1)/2,(j+1)/2,k);
            end
        end
    end
end