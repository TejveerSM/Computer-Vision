function [L, dLdy] = Loss_cross_entropy_softmax(x, y)

d = 0;
y_pred = zeros(size(y));

for i = 1:size(y,1)
    d = d + exp(x(i,1));
end
for i = 1:size(y,1)
    y_pred(i,1) = exp(x(i,1))/d;
end

L = 0;
for i = 1:size(y,1)
    L = L + y(i,1)*log(y_pred(i,1));
end

dLdy = y_pred - y;