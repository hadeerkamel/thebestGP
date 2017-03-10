function [ rowsToCutAt nLines] = CutLinesAt( I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% SE = strel('disk',1);
% compIDilated = imerode(I,SE);
%figure,imshow(I);
verticalProfile = sum(I,2);
%plot(verticalProfile);
L = length(verticalProfile);
zeroRowsCount = 0;
rowInd = 0;
rowsToCutAt = [];
rowsToCutAt(1) = 1;
flag = 0;
nLines = 2;
for i = 1:L
    if(verticalProfile(i) < 60)
        zeroRowsCount = zeroRowsCount + 1;
        rowInd = i;
        if(zeroRowsCount >= 30 && verticalProfile(i-1)< 60 && i~=L && verticalProfile(i+1)> 60)
            rowsToCutAt(nLines) = rowInd - 10;
            zeroRowsCount = 0;
            nLines = nLines + 1;
            flag = 1;
        end
    end
end
[H W] = size(I);
if(flag==0)
    nLines = 0;
else
    rowsToCutAt(nLines) = H;
end
end

