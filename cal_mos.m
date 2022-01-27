function [obj,obj_mos]=cal_mos(s_LMN,l,m,n)
[x,y]=size(s_LMN);
obj_mos=zeros(x,y);
k = 0;
for i=1:1:y
for j=1:1:x
feature=(s_LMN{j,i});

if length(feature)~=9
    obj_mos(j,i) = 0;
    k = k+1;
    continue;
end

c_1_sim=feature(1,1).*feature(1,4).*feature(1,7);  %通道L
c_2_sim=feature(1,2).*feature(1,5).*feature(1,8);  %通道M
c_3_sim=feature(1,3).*feature(1,6).*feature(1,9);  %通道N
c_sim=(abs((c_1_sim*l))+abs((c_2_sim*m))+abs((c_3_sim*n)))/(l+m+n);

if c_sim == NaN
    disp('%d c_sim is NaN',j);
end
    
obj_mos(j,i)=c_sim;
end
end
obj=sum(obj_mos)/(x-k);