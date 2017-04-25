function [ BestLineSize ] = FindBestLineSize( LineSizes,nLines)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
BestLineSize = 1;
for i = 1:nLines
    if(LineSizes(i)<200 && LineSizes(i)>100)
        BestLineSize = LineSizes(i);
    end
        
end
if(BestLineSize== 1)
   BestLineSize = 120;
end
end

