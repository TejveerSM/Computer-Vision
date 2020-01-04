function [y] = Flattening(x)

y = reshape(x,[size(x,1)*size(x,2)*size(x,3),1]);