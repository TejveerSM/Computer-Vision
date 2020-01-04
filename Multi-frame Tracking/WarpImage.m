function [I_warped] = WarpImage(I, A, output_size)

h = output_size(1);
w = output_size(2);
I_warped = zeros(h,w,class(I));

for i = 1:h
    for j = 1:w
        target_location = A*[j,i,1]';
        I_warped(i,j) = I(floor(target_location(2)),floor(target_location(1)));
    end
end

end