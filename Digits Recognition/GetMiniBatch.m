function [mini_batch_x, mini_batch_y] = GetMiniBatch(im_train, label_train, batch_size)

n = size(label_train,2);
if(rem(n,batch_size)==0)
    s = n/batch_size;
else
    s = floor(n/batch_size) + 1;
end

one_hot_label_train = zeros(10,n);
for i = 1:n
    one_hot_label_train(label_train(1,i)+1,i) = 1;
end

mini_batch_x = cell(s,1);
mini_batch_y = cell(s,1);

for i = 1:s-1
    mini_batch_x{i} = im_train(:,(((i-1)*batch_size)+1):(i*batch_size));
end
mini_batch_x{s} = im_train(:,((s-1)*batch_size+1):n);

for i = 1:s-1
    mini_batch_y{i} = one_hot_label_train(:,(((i-1)*batch_size)+1):(i*batch_size));
end
mini_batch_y{s} = one_hot_label_train(:,((s-1)*batch_size+1):n);