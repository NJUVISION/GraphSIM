function feature_LMN = computeSimilarity(pointset,pointset_d, center, center_d, weight, weight_d,T)
%% Zero and First Moment
[LMN_mg_r,LMN_mug_r]=colorgradient_mg_mug(pointset, center, weight);
[LMN_mg_d,LMN_mug_d]=colorgradient_mg_mug(pointset_d, center_d, weight_d);
%% Second Moment
LMN_cg_sim=colorgradient_cg(center, pointset, pointset_d, weight, weight_d);
%% feaure similarity
LMN_mg_sim=similarity(LMN_mg_r, LMN_mg_d, T);
LMN_mug_sim=similarity(LMN_mug_r, LMN_mug_d, T);
feature_LMN=[LMN_mg_sim, LMN_mug_sim, LMN_cg_sim];
   