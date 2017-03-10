function [ Line_indces RotatedWord ] = FindBaseLine( Word_I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


N=1;
x=0;
[subwords nsubwords]=SegmentWords(Word_I,20);
Line_indces=0;
for subW=1:(nsubwords-1)
    Word=subwords{subW};
    
    RotatedWord{N}=Word;
  
    horizontalProjection = sum(Word,2);
    [Maxpeak Line_index]=max(horizontalProjection);
    
    
    for angle=-30:1:-1
        I=imrotate(Word,angle);
        
        horizontalProjection = sum(I,2);
        [val index]=max(horizontalProjection);
        if(val>Maxpeak)
            Maxpeak=val;
            Line_index=index;
            RotatedWord{N}=I;
        end
    end
    [h width ]=size(RotatedWord{N});
    
    %se=strel('disk',1);
    %RotatedWord{N}= imerode(RotatedWord{N},se);
    %RotatedWord{N}=bwmorph( RotatedWord{N},'skel',inf);
    %RotatedWord{N}=bwmorph( RotatedWord{N},'bridge',inf);
    
    figure,imshow(RotatedWord{N}),hold on;
    xy=[1 Line_index;width Line_index];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
     Line_indces(N)=Line_index;
      N=N+1;
end
end

