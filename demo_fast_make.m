% This code provided by Siheng Chen (sihengc@andrew.cmu.edu), if you use
% this code in your paper, please cite :
% Chen S, Tian D, Feng C, et al. Fast resampling of three-dimensional point clouds via graphs[J]. IEEE Transactions on Signal Processing, 2017, 66(3): 666-681.
clear M lo co;
pc=pcread('redandblack.ply');
coordinate=pc.Location;
color=single(pc.Color);
num=10000; %resampling rate

attribute=[coordinate,color];
attribute=sortrows(attribute,[3 1 2]);
coordinate=attribute(:,1:3);
color=attribute(:,4:6);
tic; score = computeVariation(coordinate, 50); toc;

N = size(score,1);

for i_sample = 1:size(score,2) %1-4 filter length
   
    M(:,i_sample) = datasample(1:N, round(N/num), 'Replace', true, 'Weights',  score(:,i_sample) );
    hFig = figure;
    set(hFig, 'Position', [0 0 850 850])
    scatter3( coordinate( M(:, i_sample),1), coordinate( M(:, i_sample),2), coordinate( M(:, i_sample), 3), 200,  'r.'); 
    axis equal; axis off;
     set(gca,'position',[0.08 0.1 0.88 0.85],'units','normalized')
     view(-100, 20);
end
for i=1:1:4
lo{i,1}=[coordinate( M(:, i),1),coordinate( M(:, i),2),coordinate( M(:, i),3)];
co{i,1}=[color( M(:, i),1),color( M(:, i),2),color( M(:, i),3)];
co{i,1}=uint8(co{i,1});
pt=pointCloud(lo{i,1},'color',co{i,1});
str=strcat('redandblack',num2str(num),'_',num2str(i),'.ply');
pcwrite(pt,str,'PLYFormat','binary');
end