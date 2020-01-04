function [label_test_pred] = PredictKNN(feature_train, label_train, feature_test, k)

idx = knnsearch(feature_train,feature_test,'K',k);

label_test_pred = zeros(size(label_train));

for i = 1:size(feature_test)
    label_test_pred(i) = label_train(idx(i));
end