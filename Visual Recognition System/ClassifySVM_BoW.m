function [confusion, accuracy] = ClassifySVM_BoW

fid = fopen('train.txt');
train_data = textscan(fid,"%s %s");
fclose(fid);

fid = fopen('test.txt');
test_data = textscan(fid,"%s %s");
fclose(fid);

training_image_cell = cell(size(train_data{1},1),1);
for i = 1:size(train_data{1},1)
    training_image_cell{i} = imread(train_data{2}{i});
end

dic_size = 50;

vocab = BuildVisualDictionary(training_image_cell, dic_size);

bow_feature_train = zeros(size(train_data{1},1),dic_size);
bow_feature_test = zeros(size(test_data{1},1),dic_size);
label_train = zeros(size(train_data{1},1),1);
label_test = zeros(size(test_data{1},1),1);

keySet = {'Kitchen','Store','Bedroom','LivingRoom','Office','Industrial','Suburb','InsideCity','TallBuilding','Street','Highway','OpenCountry','Coast','Mountain','Forest'};
valueSet = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];
M = containers.Map(keySet,valueSet);

for i = 1:size(train_data{1},1)
    [~,feature] = vl_dsift(single(imread(train_data{2}{i})));
    feature = feature';
    bow_feature_train(i,:) = ComputeBoW(feature, vocab);
    label_train(i,:) = M(train_data{1}{i});
end

for i = 1:size(test_data{1},1)
    [~,feature] = vl_dsift(single(imread(test_data{2}{i})));
    feature = feature';
    bow_feature_test(i,:) = ComputeBoW(feature, vocab);
    label_test(i,:) = M(test_data{1}{i});
end

label_test_pred = PredictSVM(bow_feature_train, label_train, bow_feature_test);

confusion = confusionmat(label_test,label_test_pred);
confusionchart(confusion);
accuracy = 0;
for i = 1:size(confusion,1)
    accuracy = accuracy + confusion(i,i)/100;
end
accuracy = accuracy/size(confusion,1);

fprintf("\nAccuracy of BoW with SVM: %f\n",accuracy);