function [L, dLdy] = Loss_euclidean(y_tilde, y)

L = 0;
for i = 1:size(y)
    L = L + ((y_tilde(i)-y(i))*(y_tilde(i)-y(i)));
end

dLdy = 2*(y_tilde-y);