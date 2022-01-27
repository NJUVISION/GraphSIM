function [LMN_mg, LMN_mug] = colorgradient_mg_mug(pointset, center, weight) 
% G = G_d;
% pointset = pointset_d;
% center = center_d;

% w = full(G.W);
pointset_color = pointset(:, 4:6);
pointset_color = pointset_color/255;

[L,M,N] = RGB2LMN_graph(pointset_color);
pointset_color_lmn = [L,M,N];
[c_L,c_M,c_N] = RGB2LMN_graph(center(4:6));
center_color_lmn = [c_L, c_M, c_N];

center_index = find(ismember(pointset(:,1:3),center(1,1:3),'rows')==1);
center_index = center_index(1);

w_center = sqrt(weight)';
% l_local = w_center .* (c_L - pointset_color_lmn(:,1));
% m_local = w_center .* (c_M - pointset_color_lmn(:,2));
% n_local = w_center .* (c_N - pointset_color_lmn(:,3));
l_local = w_center .* (pointset_color_lmn(center_index, 1) - pointset_color_lmn(:,1));
m_local = w_center .* (pointset_color_lmn(center_index, 2) - pointset_color_lmn(:,2));
n_local = w_center .* (pointset_color_lmn(center_index, 3) - pointset_color_lmn(:,3));

local_mg = sum([l_local,m_local,n_local]);
LMN_mg = single(local_mg);
number = size(pointset,1)-1;
local_mug = local_mg/number;
LMN_mug = single(local_mug);
LMN_mug(isnan(LMN_mug)) = 0;



