function [dLdx] = ReLu_backward(dLdy, x, y)

dLdx = dLdy;
for i = 1:size(x,1)
    if (x(i,1) < 0)
        dLdx(i,1) = 0;
    end
end