function [y] = Conv(x, w_conv, b_conv)

x_pad = [zeros(size(x,1),1),x,zeros(size(x,1),1)];
x_pad = [zeros(1,size(x_pad,2));x_pad;zeros(1,size(x_pad,2))];

xt = im2col(x_pad,[3,3]);

w = reshape(w_conv,[9,3]);

yt = xt'*w;
y = reshape(yt,[14,14,3]);

for i = 1:3
    y(:,:,i) = y(:,:,i) + b_conv(i,1);
end