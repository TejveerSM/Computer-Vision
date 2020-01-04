function [w, b] = TrainSLP_linear(mini_batch_x, mini_batch_y)

lr = 0.01;
dr = 0.5;
w = rand(10,196);
b = rand(10,1);
k = 1;

for i = 1:10000
    if(rem(i,1000)==0)
        lr = lr*dr;
    end
    DLDw = 0;
    DLDb = 0;
    for j = 1:size(mini_batch_x{k},2)
        y_pred = FC(mini_batch_x{k}(:,j),w,b);
        [L,dLdy] = Loss_euclidean(y_pred,mini_batch_y{k}(:,j));
        [dLdx, dLdw, dLdb] = FC_backward(dLdy, mini_batch_x{k}(:,j), w, b, mini_batch_y{k}(:,j));
        DLDw = DLDw + dLdw;
        DLDb = DLDb + dLdb;
    end
    w = w - (lr/size(mini_batch_x{k},2))*DLDw;
    b = b - (lr/size(mini_batch_x{k},2))*DLDb;
    k = k + 1;
    if(k > size(mini_batch_x,1))
        k = 1;
    end
end