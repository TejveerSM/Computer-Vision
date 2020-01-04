function ori_histo_normalized = GetBlockDescriptor(ori_histo, block_size)

[M,N,D] = size(ori_histo);
ori_histo_normalized = zeros((M-(block_size-1)), (N-(block_size-1)), (D*block_size*block_size));

% block descriptor
for i = 1:(M-(block_size-1))
    for j = 1:(N-(block_size-1))
        
        % concatenating the HOG within the block
        h_vector = [];
        for k = 1:block_size
            for l = 1:block_size
                h_vector = [h_vector, ori_histo(i+k-1,j+l-1,:)];
            end
        end
        
        % calculating the denominator for L2 normalization
        h_total = 0;
        for m = 1:(D*block_size*block_size)
            h_total = h_total + h_vector(m)*h_vector(m);
        end
        h_total = h_total + (0.001*0.001);
        
        % normalization
        h_normalized = zeros(D*block_size*block_size);
        for n = 1:(D*block_size*block_size)
            h_normalized(n) = h_vector(n)/sqrt(h_total);
        end

        for o = 1:(D*block_size*block_size)
            ori_histo_normalized(i,j,o) = h_normalized(o);
        end
        
    end
end

end