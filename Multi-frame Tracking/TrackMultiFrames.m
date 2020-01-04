function [A_cell] = TrackMultiFrames(template, image_cell)

A_cell = cell(4,1);

[x1, x2] = FindMatch(template, image_cell{1});
[A] = AlignImageUsingFeature(x1, x2, 10, 500);

point_topleft = [1;1;1];
point_topright = [size(template,2);1;1];
point_botleft = [1;size(template,1);1];
point_botright = [size(template,2);size(template,1);1];

for i = 1:4
    target = image_cell{i};
    if (i==1)
        [A_refined] = AlignImage(template, target, A);
    else
        [A_refined] = AlignImage(template, target, A_cell{i-1});
    end
    template = WarpImage(target, A_refined, size(template));
    A_cell{i}=A_refined;
    
    topleft = A_refined*point_topleft;
    topright = A_refined*point_topright;
    botleft = A_refined*point_botleft;
    botright = A_refined*point_botright;
    
    figure;
    imshow(target);
    hold on;
    plot([topleft(1) topright(1) botright(1) botleft(1) topleft(1)], [topleft(2) topright(2) botright(2) botleft(2) topleft(2)], 'color', 'r', 'linewidth', 2);
end

end