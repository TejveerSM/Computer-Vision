function [filter_x, filter_y] = GetDifferentialFilter()

filter_x = [1,0,-1;1,0,-1;1,0,-1];
filter_y = [1,1,1;0,0,0;-1,-1,-1];

end