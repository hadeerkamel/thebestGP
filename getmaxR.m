function [ maxR minR] = getmaxR( ConnComp )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[H W] = size(ConnComp);
% rPixelList = zeros(H);
% cPixelList = zeros(W);

index = 1;
 for r = 1:H
     for c = 1:W
         if(ConnComp(r,c)== 1)
            rPixelList(index) = r;
            cPixelList(index) = c;
            index = index + 1;
         end
     end
 end
 maxR = max(rPixelList);
 minR = min(rPixelList);
end

