function ori_histo = BuildHistogram(grad_mag, grad_angle, cell_size)

[row, col] = size(grad_mag);
M = floor(row/cell_size);
N = floor(col/cell_size);
ori_histo = zeros(M,N,6);

% adding 'pi/2' radians to all the angles
for i = 1:size(grad_angle,1)
    for j = 1:size(grad_angle,2)
        grad_angle(i,j) = grad_angle(i,j) + (pi/2);
    end
end

% calculating the histogram bins
for i = 1:M
    for j = 1:N
        h_vector = zeros(6);
        t1 = (i-1)*cell_size;
        t2 = (j-1)*cell_size;
        for k = 1:cell_size
            for l = 1:cell_size
                if (grad_angle(t1+k,t2+l)>=(11/12*pi) && grad_angle(t1+k,t2+l)<pi) || (grad_angle(t1+k,t2+l)>=0 && grad_angle(t1+k,t2+l)<(1/12*pi))
                    h_vector(1) = h_vector(1) + grad_mag(t1+k,t2+l);
                elseif (grad_angle(t1+k,t2+l)>=(1/12*pi) && grad_angle(t1+k,t2+l)<(3/12*pi))
                    h_vector(2) = h_vector(2) + grad_mag(t1+k,t2+l);
                elseif (grad_angle(t1+k,t2+l)>=(3/12*pi) && grad_angle(t1+k,t2+l)<(5/12*pi))
                    h_vector(3) = h_vector(3) + grad_mag(t1+k,t2+l);
                elseif (grad_angle(t1+k,t2+l)>=(5/12*pi) && grad_angle(t1+k,t2+l)<(7/12*pi))
                    h_vector(4) = h_vector(4) + grad_mag(t1+k,t2+l);
                elseif (grad_angle(t1+k,t2+l)>=(7/12*pi) && grad_angle(t1+k,t2+l)<(9/12*pi))
                    h_vector(5) = h_vector(5) + grad_mag(t1+k,t2+l);
                elseif (grad_angle(t1+k,t2+l)>=(9/12*pi) && grad_angle(t1+k,t2+l)<(11/12*pi))
                    h_vector(6) = h_vector(6) + grad_mag(t1+k,t2+l);
                end
            end
        end
        for a = 1:6
            ori_histo(i,j,a) = h_vector(a);    
        end
    end
end

end