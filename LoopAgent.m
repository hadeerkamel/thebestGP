function [ bw ] = LoopAgent( Im )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[linei , ro ,NsubWords]= FindBaseLine(Im);
NsubWords=NsubWords-1;

for i=1:NsubWords
%     figure,imshow(ro{i}),hold on ;
%     [B,L] = bwboundaries(ro{i},'holes');
%     for k = 1:length(B)
%         boundary = B{k};
%         plot(boundary(:,2), boundary(:,1), 'b', 'LineWidth', 2)
%     end
bw{i}=ro{i};
    bw_fill= imfill(ro{i},'holes');
    %figure,imshow(bw_fill);
    bw_filled_area=bitxor(ro{i},bw_fill);
    %figure,imshow(bw_filled_area);
    se=strel('disk',1);
    bw_filled_area= imdilate(bw_filled_area,se);
    bw{i}=xor(bw_filled_area,bw_fill);
    figure,imshow(bw{i});
end
end

