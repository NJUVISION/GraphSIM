function [LMN_mg, LMN_mug]=colorgradient_mg_mug(G_g,pointset,center) 
        pointset_color=pointset(:,4:6);
        l_local=0;m_local=0;n_local=0;
        pointset_color=pointset_color/255;
        [L,M,N]=RGB2LMN_graph(pointset_color);
        pointset_color_lmn=[L,M,N];
        w=sqrt(G_g.W);
        index_center=find(ismember(pointset(:,1:3),center(1,1:3),'rows')==1); 
        number=0;
        for color_idex=1:1:size(w,2)
            if full(w(index_center,color_idex))~=0        
                number=number+1;              
                l_local=l_local+full(w(index_center,color_idex))*(pointset_color_lmn(index_center,1)-pointset_color_lmn(color_idex,1));
                m_local=m_local+full(w(index_center,color_idex))*(pointset_color_lmn(index_center,2)-pointset_color_lmn(color_idex,2));
                n_local=n_local+full(w(index_center,color_idex))*(pointset_color_lmn(index_center,3)-pointset_color_lmn(color_idex,3));         
            end
        end
           local_mg=[l_local,m_local,n_local];
           LMN_mg=single(local_mg);
           local_mug=local_mg/number;
           LMN_mug=single(local_mug);
           LMN_mug(isnan(LMN_mug))=0;
       end

