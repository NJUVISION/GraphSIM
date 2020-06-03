function LMN_cg=colorgradient_cg(G_g,G_gd,center,pointset,pointsetd)

     wr=G_g.W;
     wd=G_gd.W;
     index_center1=find(ismember(pointset(:,1:3),center(1,1:3),'rows')==1); 
     index_center2=find(ismember(pointsetd(:,1:3),center(1,1:3),'rows')==1); 
     pointset1=pointset((full(wr(index_center1,:))~=0),:);
     ww=full(wr(index_center1,:));
     w1=ww(1,(full(wr(index_center1,:))~=0));
     
     pointset2=pointsetd((full(wd(index_center2,:))~=0),:);
     ww=full(wd(index_center2,:));
     w2=ww(1,(full(wd(index_center2,:))~=0));
     N1=size(pointset1,1); 
     N2=size(pointset2,1); 
 
     min_points=min(N1,N2);
     if min_points>1
        if N1>N2
            min_index=N2;
            max_matrix_coor=pointset1(:,1:3);
            max_matrix_color=pointset1(:,4:6);
            min_matrix_coor=pointset2(:,1:3);
            min_matrix_color=pointset2(:,4:6);
            w_b=w1;
            w_s=w2;
        else
            min_index=N1;
            max_matrix_coor=pointset2(:,1:3);
            max_matrix_color=pointset2(:,4:6);
            min_matrix_coor=pointset1(:,1:3);
            min_matrix_color=pointset1(:,4:6);
            w_b=w2;
            w_s=w1;
        end
        rearray_coor=zeros(min_index,3);
        rearray_color=zeros(min_index,3);
        rearray_w=zeros(1,min_index);
        for index_min=1:1:min_index
            [idxx, distt] = knnsearch( max_matrix_coor, min_matrix_coor(index_min,:), 'k', 1,  'distance', 'euclidean');
            rearray_coor(index_min,:)=max_matrix_coor(idxx,:);
            rearray_color(index_min,:)=max_matrix_color(idxx,:);
            rearray_w(1,index_min)=w_b(1,idxx);
        end
            [L,M,N]=RGB2LMN_graph(center(1,4:6));

            centerlmn=[L,M,N];
            [L,M,N]=RGB2LMN_graph(rearray_color);

            rearray_colorlmn=[L,M,N];
            [L,M,N]=RGB2LMN_graph(min_matrix_color);

            min_matrix_colorlmn=[L,M,N]; 
            gradient_ori1=zeros(size(rearray_colorlmn));
            gradient_ori2=zeros(size(rearray_colorlmn));
            for i=1:1:3
                gradient_ori1(:,i)=rearray_w'.*(centerlmn(:,i)-rearray_colorlmn(:,i));
                gradient_ori2(:,i)=w_s'.*(centerlmn(:,i)-min_matrix_colorlmn(:,i));
            end
        c1=[gradient_ori1(:,1),gradient_ori2(:,1)];
        c2=[gradient_ori1(:,2),gradient_ori2(:,2)];
        c3=[gradient_ori1(:,3),gradient_ori2(:,3)];
        
            
        co1=cov(c1);co2=cov(c2);co3=cov(c3);
        
        g1=(co1(1,2)+0.001)/(sqrt(co1(1,1))*sqrt(co1(2,2))+0.001);
        g2=(co2(1,2)+0.001)/(sqrt(co2(1,1))*sqrt(co2(2,2))+0.001);
        g3=(co3(1,2)+0.001)/(sqrt(co3(1,1))*sqrt(co3(2,2))+0.001);
        
     else 
         g1=0;g2=0;g3=0;

     end
     LMN_cg=[g1,g2,g3];

