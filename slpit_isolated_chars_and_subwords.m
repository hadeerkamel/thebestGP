function [ subWords ] = slpit_isolated_chars_and_subwords( I,BaseLineIndex )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[H W]=size(I);
subWords=0;
I_aboveBaseLine=imcrop(I,[1 1 W BaseLineIndex]);
figure,imshow(I_aboveBaseLine);
horizontalProfile = sum(I_aboveBaseLine,1);

end

