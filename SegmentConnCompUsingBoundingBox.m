function [ ColouredI ] = SegmentConnCompUsingBoundingBox( BWI,I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
CC = bwconncomp(BWI);
N = CC.NumObjects;
stats1 = regionprops(CC,'BoundingBox');
BoundingBox = stats1.BoundingBox;
BoundingBox(1) = fix(BoundingBox(1)) + 1;
BoundingBox(2) = fix(BoundingBox(2)) + 1;
ColouredI = imcrop(I,[BoundingBox(1) BoundingBox(2) BoundingBox(3)+10 BoundingBox(4)]);

end

