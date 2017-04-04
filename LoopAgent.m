function [ bw ] = LoopAgent( Im )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%[linei , ro ,NsubWords]= FindBaseLine(Im);
%NsubWords=NsubWords-1;

%for i=1:NsubWords
%     figure,imshow(ro{i}),hold on ;
%     [B,L] = bwboundaries(ro{i},'holes');
%     for k = 1:length(B)
%         boundary = B{k};
%         plot(boundary(:,2), boundary(:,1), 'b', 'LineWidth', 2)
%     end
bw=Im;
    bw_fill= imfill(Im,'holes');
    %figure,imshow(bw_fill);
    bw_filled_area=bitxor(Im,bw_fill);
    %figure,imshow(bw_filled_area);
    se=strel('disk',1);
    bw_filled_area= imdilate(bw_filled_area,se);
    %figure,imshow(bw_filled_area);
    bw=bitxor(bw_filled_area,bw_fill);
  %  figure,imshow(bw);
%end
end

