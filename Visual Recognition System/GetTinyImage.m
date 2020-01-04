function [feature] = GetTinyImage(I, output_size)

im = imresize(I,output_size);
feature = im(:);

%normalization
feature = (double(feature)-mean(feature))/sqrt(sum(feature.*feature));