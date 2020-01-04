function [A] = AlignImageUsingFeature(x1, x2, ransac_thr, ransac_iter)

A = zeros(3,3);
inliers = [];

for i = 1:ransac_iter
    local_inliers = [];
    
    r = randi([1 size(x1,1)],1,3);
    
    original = [x1(r(1),1) x1(r(1),2) 1 0 0 0; 0 0 0 x1(r(1),1) x1(r(1),2) 1;
                x1(r(2),1) x1(r(2),2) 1 0 0 0; 0 0 0 x1(r(2),1) x1(r(2),2) 1;
                x1(r(3),1) x1(r(3),2) 1 0 0 0; 0 0 0 x1(r(3),1) x1(r(3),2) 1];
    corresponding = [x2(r(1),1); x2(r(1),2); x2(r(2),1); x2(r(2),2); x2(r(3),1); x2(r(3),2)];
    a = original\corresponding;
    local_A = [a(1),a(2),a(3); a(4),a(5),a(6); 0,0,1];
    
%     points1 = [x1(r(1),1) x1(r(2),1) x1(r(3),1); x1(r(1),2) x1(r(2),2) x1(r(3),2); 1 1 1];
%     points2 = [x2(r(1),1) x2(r(2),1) x2(r(3),1); x2(r(1),2) x2(r(2),2) x2(r(3),2); 1 1 1];
%     local_A = points1\points2;
    
    for j = 1:size(x1,1)
        transformed_point = local_A*[x1(j,1) x1(j,2) 1]';
        dist = sqrt( ((x2(j,1)-transformed_point(1))^2) + ((x2(j,2)-transformed_point(2))^2) );
        if (dist < ransac_thr)
            local_inliers = [local_inliers; x1(j,:)];
        end
    end
    
    error = 0;
    for j = 1:size(x1,1)
        transformed_point = local_A*[x1(j,1) x1(j,2) 1]';
        dist = sqrt( ((x2(j,1)-transformed_point(1))^2) + ((x2(j,2)-transformed_point(2))^2) );
        error = error + dist;
    end
    
    if (i==1)
        min_error = error;
        A = local_A;
        inliers = local_inliers;
    elseif (error < min_error)
        min_error = error;
        A = local_A;
        inliers = local_inliers;
    end
end