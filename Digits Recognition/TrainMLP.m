function [w1, b1, w2, b2] = TrainMLP(mini_batch_x, mini_batch_y)

lr = 0.04;
dr = 0.8;
w1 = rand(30,196);
b1 = rand(30,1);
w2 = rand(10,30);
b2 = rand(10,1);
k = 1;

for i = 1:10000
    if(rem(i,1000)==0)
        lr = lr*dr;
    end
    DLDw1 = 0;
    DLDb1 = 0;
    DLDw2 = 0;
    DLDb2 = 0;
    for j = 1:size(mini_batch_x{k},2)
        pred1 = FC(mini_batch_x{k}(:,j),w1,b1);
        pred2 = ReLu(pred1);
        pred3 = FC(pred2,w2,b2);
        [L,dLdy] = Loss_cross_entropy_softmax(pred3,mini_batch_y{k}(:,j));
        [dLdx, dLdw2, dLdb2] = FC_backward(dLdy, pred2, w2, b2, pred3);
        [dLdx_R] = ReLu_backward(dLdx, pred1, pred2);
        [dLdx, dLdw1, dLdb1] = FC_backward(dLdx_R, mini_batch_x{k}(:,j), w1, b1, pred1);
        DLDw1 = DLDw1 + dLdw1;
        DLDb1 = DLDb1 + dLdb1;
        DLDw2 = DLDw2 + dLdw2;
        DLDb2 = DLDb2 + dLdb2;
    end
    w1 = w1 - (lr/size(mini_batch_x{k},2))*DLDw1;
    b1 = b1 - (lr/size(mini_batch_x{k},2))*DLDb1;
    w2 = w2 - (lr/size(mini_batch_x{k},2))*DLDw2;
    b2 = b2 - (lr/size(mini_batch_x{k},2))*DLDb2;
    k = k + 1;
    if(k > size(mini_batch_x,1))
        k = 1;
    end
end