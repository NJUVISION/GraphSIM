function [pointset1, center, weight, radius] = graphcreation_radius(pc_ori, pc_fast, idx, dit, i)
% clearvars -except pc_r  pc_fast epsilon idx dit
% pc_ori = pc_r;
% i = 1;
% idx = idx{i,1};
% dit = dit{i,1};


pc_ori_coor = pc_ori.Location;
pc_ori_color = single(pc_ori.Color);
pc_fast_coor = pc_fast.Location;
pc_fast_color = single(pc_fast.Color);

idx1 = find(dit(1,:));
idx2 = idx(1,idx1);
pointset = [pc_ori_coor(idx2,:), pc_ori_color(idx2,:)];

center = [pc_fast_coor(i,:), pc_fast_color(i,:)];


pointset = unique([center;pointset], 'rows');
pointset_coor = pointset(:,1:3);
pointset_color = pointset(:,4:6);

N = size(pointset, 1);
K = 50;

[~, dist] = knnsearch( pointset_coor, pointset_coor( round( linspace(1,N, 100))  ,:), 'k', K,  'distance', 'euclidean');

s = min(K, size(dist, 2));
radius = max(dist(:, s));

D=distanz(pc_fast_coor(i,:)',pointset_coor');
D(D>radius) = 0;
idex = find(D(1,:));
D1 = D(1,idex);

% [idex, ditt] = rangesearch(pointset_coor, center(1:3), radius);

pointset1 = pointset(idex, :);
pointset1 = unique([center;pointset1], 'rows');


[idxx,ditt] = knnsearch(pointset1(:,1:3), center(1,1:3), 'k', size(pointset1,1), 'distance', 'euclidean');
sigma = radius^2/2;
weight0 = exp(-ditt.^2/sigma);
for m = 1:size(pointset1,1)
    weight(1,idxx(m))= weight0(m);
end
center_index = find(ismember(pointset1(:,1:3),center(1,1:3),'rows')==1);
weight(1,center_index) = 0;



