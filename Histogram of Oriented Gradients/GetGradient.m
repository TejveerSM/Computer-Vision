function [grad_mag, grad_angle] = GetGradient(im_dx, im_dy)

grad_mag = zeros(size(im_dx));
grad_angle = zeros(size(im_dx));

% calcuating pixel-wise gradient magnitude and angle
for i = 1:size(im_dx,1)
    for j = 1:size(im_dx,2)
        grad_mag(i,j) = sqrt( (im_dx(i,j)*im_dx(i,j)) + (im_dy(i,j)*im_dy(i,j)) );
        grad_angle(i,j) = atan(im_dy(i,j) / im_dx(i,j));
    end
end

end