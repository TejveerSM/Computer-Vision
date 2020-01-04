function [dLdx, dLdw, dLdb] = FC_backward(dLdy, x, w, b, y)

dLdx = (dLdy'*w)';
dLdw = dLdy*x';
dLdb = dLdy*1;