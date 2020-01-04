function [label_test_pred] = PredictSVM(feature_train, label_train, feature_test)

W = [];
B = [];
lambda = 0.000001;

for i = 1:15
    label = ones(size(label_train,1),1);
    label(label_train~=i) = -1;
    [w,b] = vl_svmtrain(feature_train',label,lambda);
    W = [W,w];
    B = [B;b];
end

s = W'*feature_test' + repmat(B,1,size(feature_train,1));
[~,label_test_pred] = max(s',[],2);
