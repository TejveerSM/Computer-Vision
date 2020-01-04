function [dLdw, dLdb] = Conv_backward(dLdy, x, w_conv, b_conv, y)

x_pad = [zeros(size(x,1),1),x,zeros(size(x,1),1)];
x_pad = [zeros(1,size(x_pad,2));x_pad;zeros(1,size(x_pad,2))];

xt = im2col(x_pad,[3,3]);
dLdy_t = reshape(dLdy,[196,3]);

dLdw_t = xt*dLdy_t;
dLdw = reshape(dLdw_t,[3,3,1,3]);

dLdb = zeros(3,1);
for i = 1:3
    dLdb(i) = sum(sum(dLdy(:,:,i)));
end