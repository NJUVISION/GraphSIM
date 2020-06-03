function [obj]=cal_mos(s_LMN,l,m,n)
[x,y]=size(s_LMN);
obj_mos=zeros(x,y);
for i=1:1:y
for j=1:1:x
feature=(s_LMN{j,i});
c_1_sim=feature(1,1).*feature(1,4).*feature(1,7);
c_2_sim=feature(1,2).*feature(1,5).*feature(1,8);
c_3_sim=feature(1,3).*feature(1,6).*feature(1,9);
c_sim=(abs((c_1_sim*l))+abs((c_2_sim*m))+abs((c_3_sim*n)))/(l+m+n);
obj_mos(j,i)=c_sim;
end
end
obj=sum(obj_mos)/x;