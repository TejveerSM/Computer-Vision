I1 = imread('template.jpeg');
if (ndims(I1)>2)
    I1 = rgb2gray(I1);
end

I2 = imread('frame1.jpeg');
if (ndims(I2)>2)
    I2 = rgb2gray(I2);
end

I3 = imread('frame2.jpeg');
if (ndims(I3)>2)
    I3 = rgb2gray(I3);
end

I4 = imread('frame3.jpeg');
if (ndims(I4)>2)
    I4 = rgb2gray(I4);
end

I5 = imread('frame4.jpeg');
if (ndims(I5)>2)
    I5 = rgb2gray(I5);
end

image_cell = cell(4,1);
image_cell{1} = I2;
image_cell{2} = I3;
image_cell{3} = I4;
image_cell{4} = I5;

[A_cell] = TrackMultiFrames(I1, image_cell);