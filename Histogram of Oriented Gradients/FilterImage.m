function [im_filtered] = FilterImage(im, filter)

% filtered image initialization
im_filtered = zeros(size(im));

% padding the input image with zeros
im = [zeros(size(im,1),1),im,zeros(size(im,1),1)];
im = [zeros(1,size(im,2));im;zeros(1,size(im,2))];

% filtered image
for i = 1:(size(im,1)-2)
    for j = 1:(size(im,2)-2)
        v = 0;
        for k = 1:3
            for l = 1:3
                i1 = i + k - 1;
                j1 = j + l - 1;
                v = v + im(i1,j1)*filter(k,l);
            end
        end
        im_filtered(i,j) = v;
    end
end

end
                