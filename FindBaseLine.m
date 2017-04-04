function [ Line_index RotatedWord ] = FindBaseLine( Word_I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


N=1;
%[subwords nsubwords]=SegmentWords(Word_I,inf);
Line_index=0;
    Word=Word_I;
    
    se=strel('disk',1);
     Word= imdilate(Word,se);
%     Word=bwmorph( Word,'skel',inf);
%     Word=bwmorph( Word,'bridge',inf);
    
    RotatedWord=Word;
    
    
    horizontalProjection = sum(Word,2);
    [Maxpeak Line_index]=max(horizontalProjection);
    
    
    for angle=-5:0.5:-0.5
        I=imrotate(Word,angle);
        
        horizontalProjection = sum(I,2);
        [val index]=max(horizontalProjection);
        if(val>Maxpeak)
            Maxpeak=val;
            Line_index=index;
            RotatedWord=I;
        end
    end
     for angle=0.5:0.5:5
        I=imrotate(Word,angle);
        
        horizontalProjection = sum(I,2);
        [val index]=max(horizontalProjection);
        if(val>Maxpeak)
            Maxpeak=val;
            Line_index=index;
            RotatedWord=I;
        end
     end
    
    %[h width ]=size(RotatedWord);
    
    se=strel('disk',1);
    RotatedWord= imerode(RotatedWord,se);
    RotatedWord=bwmorph( RotatedWord,'skel',inf);
    RotatedWord=bwmorph( RotatedWord,'bridge',inf);
    RotatedWord=bwmorph( RotatedWord,'spur');
    
%     figure,imshow(RotatedWord),hold on;
%     xy=[1 Line_index;width Line_index];
%     plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
   
end

