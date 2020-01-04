function [confusion, accuracy] = ClassifyKNN_Tiny

fid = fopen('train.txt');
train_data = textscan(fid,"%s %s");
fclose(fid);

fid = fopen('test.txt');
test_data = textscan(fid,"%s %s");
fclose(fid);

w = 16;
h = 16;
output_size = [h,w];

feature_train = zeros(size(train_data{1},1),h*w);
feature_test = zeros(size(test_data{1},1),h*w);
label_train = zeros(size(train_data{1},1),1);
label_test = zeros(size(test_data{1},1),1);

keySet = {'Kitchen','Store','Bedroom','LivingRoom','Office','Industrial','Suburb','InsideCity','TallBuilding','Street','Highway','OpenCountry','Coast','Mountain','Forest'};
valueSet = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];
M = containers.Map(keySet,valueSet);

for i = 1:size(train_data{1},1)
    I = imread(train_data{2}{i});
    feature = GetTinyImage(I,output_size);
    feature_train(i,:) = feature';
    label_train(i,:) = M(train_data{1}{i});
end

for i = 1:size(test_data{1},1)
    I = imread(test_data{2}{i});
    feature = GetTinyImage(I,output_size);
    feature_test(i,:) = feature';
    label_test(i,:) = M(test_data{1}{i});
end

k = 1;
label_test_pred = PredictKNN(feature_train, label_train, feature_test, k);

confusion = confusionmat(label_test,label_test_pred);
confusionchart(confusion);
accuracy = 0;
for i = 1:size(confusion,1)
    accuracy = accuracy + confusion(i,i)/100;
end
accuracy = accuracy/size(confusion,1);

fprintf("\nAccuracy of Tiny with KNN: %f\n",accuracy);