function [dLdx] = Flattening_backward(dLdy, x, y)

dLdx = reshape(dLdy,[size(x,1),size(x,2),size(x,3)]);