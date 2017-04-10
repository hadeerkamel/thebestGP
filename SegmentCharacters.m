function [ fchars,fnchars] = SegmentCharacters( Word )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Word = padarray(Word,[4 4]);
%figure,imshow(Word);
[height width]=size(Word);
fnchars=0;
%% baseline
[Line_index RotatedWord ]=FindBaseLine(Word);
%% smooth
dilatedImage = imdilate(RotatedWord,strel('disk',5));
%thinedImage = bwmorph(dilatedImage,'thin',inf);
%% segment subwords
%[ SubWords nSubWords] = SegmentSubWords(dilatedImage,5);
[ SubWords nSubWords] = SegmentWords(dilatedImage,1);
for w=1:nSubWords
    bw=SubWords{w};
    bw = bwmorph(bw,'thin',inf);
    SubWords{w}=bw;
   % figure,imshow(bw);
    %% remove multiagents
    bw=RemoveSmallComp( bw,30);
    if(sum(sum(bw))>100)
        bw=LoopAgent(bw);
        bw=RemoveSmallComp( bw,20);
        %figure,imshow(bw);
        
        bw=Under_Baseline_CavitiesAgent( Line_index,bw );
        bw=RemoveSmallComp( bw,20);
        %figure,imshow(bw);
        
        bw = imdilate(bw,strel('disk',5));
        bw = bwmorph(bw,'thin',inf);
        
        
        bw = semi_loopedCavities( bw );
        bw=RemoveSmallComp( bw,20);
        %figure,imshow(bw);
        %% find endpoints and segment
        [ F,Endpoints ] = FindEndPonits( bw,0 );
        [chars,nchars]=segment( SubWords{w},Endpoints);
    
    for charno=1:nchars-1
        fnchars=fnchars+1;
        fchars{fnchars}=chars{charno};
        
        %figure,imshow(chars{charno});
    end
    elseif(sum(sum(bw))==0)
        continue;
    else
        fnchars=fnchars+1;
        fchars{fnchars}=SubWords{w};
    end
end

%segment


end

