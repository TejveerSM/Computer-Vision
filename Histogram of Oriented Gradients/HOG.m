function [hog] = HOG(original_image)

% checking if the image is in RGB format and converting it to gray-scale
% and uint8 format
image = imread(original_image);
if (ndims(image)>2)
    image = rgb2gray(image);
end
im = im2uint8(image);

% convert gray-scale image to double format
double_image = im2double(im);

% differential images
[filter_x, filter_y] = GetDifferentialFilter();
im_dx = FilterImage(double_image, filter_x);
im_dy = FilterImage(double_image, filter_y);

% gradients
[grad_mag, grad_angle] = GetGradient(im_dx, im_dy);

figure
imagesc(grad_mag);
figure
imagesc(grad_angle);

% Histogram of Oriented Gradients - Orientation Binning
ori_histo = BuildHistogram(grad_mag, grad_angle, 8);

% HOG Visualization
[row,col] = size(im);
[X,Y] = meshgrid(1:1:floor(col/8), 1:1:floor(row/8));
figure
imshow(im);
hold on
for a = 1:6
    Len = ori_histo(:,:,a);
    quiver(((X-1)*8)+4, ((Y-1)*8)+4, Len*cos((a-1)*pi/6), Len*sin((a-1)*pi/6), 'color', [1 0 0]);
end
hold off

% Block Normalization
ori_histo_normalized = GetBlockDescriptor(ori_histo, 2);

[Row, Col, Depth] = size(ori_histo_normalized);
hog = [];
for i = 1:Row
    for j = 1:Col
        for k = 1:Depth
            hog = [hog, ori_histo_normalized(Row,Col,Depth)];
        end
    end
end

end