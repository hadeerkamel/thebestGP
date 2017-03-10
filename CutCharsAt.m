function [ columnsTocutAt nChars ] = CutCharsAt( Word )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
columnsTocutAt=0;
nChars=0;
%1- separated ones profile =0 
[ SubWords nSubWords ] = SegmentWords( Word ,2);
%2- connected
    %2.1- remove dots
    for i=1:(nSubWords-1)
        [H W]=size(SubWords{i});
        figure,imshow(SubWords{i}),hold on;
        CC = bwconncomp(SubWords{i});
        N = CC.NumObjects;
        numPixels = cellfun(@numel,CC.PixelIdxList);
        [biggest,idx] = max(numPixels);
        for j=1:N
            if(j~=idx)
                SubWords{i}(CC.PixelIdxList{j})=0;
            end
        end
        
        horizontalProfile = sum(SubWords{i},1);
        L = length(horizontalProfile);
        for L1=1:L
            if(horizontalProfile(L1)==1)
                xy=[L1 1;L1 H];
               % plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
            end
        end
    end
    %2.2- apply not-one-then-one algorithm

    

end

