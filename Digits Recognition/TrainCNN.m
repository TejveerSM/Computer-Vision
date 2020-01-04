function [w_conv, b_conv, w_fc, b_fc] = TrainCNN(mini_batch_x, mini_batch_y)

lr = 0.08;
dr = 0.8;
w_conv = rand(3,3,1,3);
b_conv = rand(3,1);
w_fc = rand(10,147);
b_fc = rand(10,1);
k = 1;

for i = 1:10000
    if(rem(i,1000)==0)
        lr = lr*dr;
    end
    WC = 0;
    BC = 0;
    WF = 0;
    BF = 0;
    for j = 1:size(mini_batch_x{k},2)
        x = reshape(mini_batch_x{k}(:,j), [14, 14, 1]);
        p1 = Conv(x,w_conv,b_conv);
        p2 = ReLu(p1);
        p3 = Pool2x2(p2);
        p4 = Flattening(p3);
        p5 = FC(p4,w_fc,b_fc);
        [L,dLdy] = Loss_cross_entropy_softmax(p5,mini_batch_y{k}(:,j));
        [dLdx_fc,dLdw_fc,dLdb_fc] = FC_backward(dLdy,p4,w_fc,b_fc,p5);
        [dLdx_flat] = Flattening_backward(dLdx_fc,p3,p4);
        [dLdx_pool] = Pool2x2_backward(dLdx_flat,p2,p3);
        [dLdx_relu] = ReLu_backward(dLdx_pool,p1,p2);
        [dLdw_conv,dLdb_conv] = Conv_backward(dLdx_relu,x,w_conv,b_conv,p1);
        WC = WC + dLdw_conv;
        BC = BC + dLdb_conv;
        WF = WF + dLdw_fc;
        BF = BF + dLdb_fc;
    end
    w_conv = w_conv - (lr/size(mini_batch_x{k},2))*WC;
    b_conv = b_conv - (lr/size(mini_batch_x{k},2))*BC;
    w_fc = w_fc - (lr/size(mini_batch_x{k},2))*WF;
    b_fc = b_fc - (lr/size(mini_batch_x{k},2))*BF;
    k = k + 1;
    if(k > size(mini_batch_x,1))
        k = 1;
    end
end