function [ outI ] = RemoveSmallComp( I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
BW=I;
CC = bwconncomp(I);
numPixels = cellfun(@numel,CC.PixelIdxList);
for i=1:CC.NumObjects;
    if(numPixels(i)<30)
    BW(CC.PixelIdxList{i}) = 0;
    end
end
%figure,imshow(BW);
outI=BW;
end

