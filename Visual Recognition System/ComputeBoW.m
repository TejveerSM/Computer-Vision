function [bow_feature] = ComputeBoW(feature, vocab)

bow_feature = zeros(1,size(vocab,1));
idx = knnsearch(double(vocab),double(feature));

for i = 1:size(vocab,1)
    bow_feature(i) = sum(idx(:)==i);
end

%normalization
bow_feature = bow_feature/norm(bow_feature);