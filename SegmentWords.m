function [ Words nWords ] = SegmentWords( Line,th)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%figure,imshow(Line);

[columnsTocutAt nWords] = CutWordsAt(Line,th);
[H W] = size(Line);
for wordIndex = 1:nWords
    if(wordIndex>1)
        WidthofWord = columnsTocutAt(wordIndex) - columnsTocutAt(wordIndex - 1);
        minX = columnsTocutAt(wordIndex - 1);
        minY = 1;
        Words{wordIndex-1} = imcrop(Line,[minX minY WidthofWord H]);
       % figure,imshow(Words{wordIndex-1});
    end
        
end



end

