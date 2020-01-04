function [vocab] = BuildVisualDictionary(training_image_cell, dic_size)

sift_pool = [];

for i = 1:size(training_image_cell)
    [~,d] = vl_dsift(single(training_image_cell{i})/255,'size',8,'step',16);
    d = d';
    sift_pool = [sift_pool;d];
end

[~,vocab] = kmeans(double(sift_pool),dic_size,'MaxIter',500);