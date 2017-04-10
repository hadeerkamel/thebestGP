function [ SubWords nSubWords] = SegmentSubWords( Line,th )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[columnsTocutAt nWords] = CutWordsAt(Line,th);
[H W] = size(Line);
NSubWords = 0;
TotalNSubWords = 0;
for wordIndex = 1:nWords
    if(wordIndex>1)
        WidthofWord = columnsTocutAt(wordIndex) - columnsTocutAt(wordIndex - 1);
        minX = columnsTocutAt(wordIndex - 1);
        minY = 1;
        Words{wordIndex-1 + TotalNSubWords} = imcrop(Line,[minX minY WidthofWord H]);
       % figure,imshow(Words{wordIndex-1 + TotalNSubWords});
        [ SubWord ] = RemoveSmallComp( Words{wordIndex-1+ TotalNSubWords},200 );
        CC = bwconncomp(SubWord);
        N = CC.NumObjects;
        IgnoredCC = 0;
        if(N>1)  
            [ Line_index RotatedWord ] = FindBaseLine(SubWord);
            for SubWordIndex = 1:N
                
                OriginalSubWord = SubWord;
                for i = 1:N
                    if(i~=SubWordIndex)
                      SubWord(CC.PixelIdxList{i}) = 0;
                    end
                end
                [maxR minR] = getmaxR(SubWord);
                SubWord = OriginalSubWord;
                d1 = abs(Line_index - maxR);
                d2 = abs(Line_index - minR);
                if(min(d1,d2)<60)
                SubWord(CC.PixelIdxList{SubWordIndex}) = 0;
                Words{(wordIndex-1) + TotalNSubWords + (SubWordIndex-IgnoredCC) - 1} = SubWord;
                %figure,imshow(Words{(wordIndex-1) +TotalNSubWords + SubWordIndex - 1});
                else
                    IgnoredCC = IgnoredCC + 1;
                    OriginalSubWord(CC.PixelIdxList{SubWordIndex}) = 0;
                end
                SubWord = OriginalSubWord;
            end
            TotalNSubWords = TotalNSubWords + N - 1 - IgnoredCC;
        end    
        
        %figure,imshow(Words{wordIndex-1});
    end
        
end


nWords=nWords-1 + TotalNSubWords;
nSubWords = nWords;
SubWords = Words;
for nn = 1:nWords
    figure,imshow(SubWords{nn});
end

end

