function [ ColouredI maxX itsr]= SegmentConnComp( BWI,I )
%Conver
%   Detailed explanation goes here
[H W] = size(BWI);
% rPixelList = zeros(H);
% cPixelList = zeros(W);

index = 1;
 for r = 1:H
     for c = 1:W
         if(BWI(r,c)== 1)
            rPixelList(index) = r;
            cPixelList(index) = c;
            index = index + 1;
         end
     end
 end
% rPixelList
index = index - 1;
minX = W;
minY = H;
 for i = 1:index
     if(rPixelList(i)< minY)
         minY = rPixelList(i);
     end
    if(cPixelList(i)<minX)
         minX = cPixelList(i);
    end
 end
 maxX = 1;
 maxY = 1;
 for i = 1:index
     if(rPixelList(i)>= maxY)
         maxY = rPixelList(i);
     end
    if(cPixelList(i)>= maxX)
         maxX = cPixelList(i);
         itsr = rPixelList(i);
    end
 end
%  maxY = max(rPixelList);
%  maxX = max(cPixelList);
% 
 HH = (maxY - minY);
 WW = maxX - minX;
 ColouredI = imcrop(I,[minX minY WW+10 HH]);
 %imshow(ColouredI);
end

