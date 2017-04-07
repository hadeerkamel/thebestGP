function [ F ] = is_curved( I,StartPoint)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
F=0;
Up=0;
Down=0;
Left=0;
Right=0;
diagonals=0;
pixelscount=0;
bw=I;
i=StartPoint(2);
j=StartPoint(1);
while(1)
    bw(i, j)=0;
    %move
    [f,newi,newj]=decideamove(bw,i,j,1);
    if(~f)
        bw(i, j)=1;
        break;
    else
        pixelscount=pixelscount+1;
        if(i~=newi&&j~=newj)
            diagonals=diagonals+1;
           % plot(newj, newi, 'b.');
        end
        if(newi<i)
            Up=Up+1;
        elseif(newi>i)
            Down=Down+1;
        end
        if(newj<j)
            Left=Left+1;
        elseif(newj>j)
            Right=Right+1;
        end
        
        i=newi;
        j=newj;
        
    end
    
    
end
diag_percentege=(diagonals/pixelscount)*100;
RLdiff=abs(Right-Left);
UDdiff=abs(Up-Down);
if(pixelscount>20&&diag_percentege>35)
    
    if(RLdiff<20)
        mn =min([Right,Left]);
        mx =max([Up,Down]);
        mx=mx-mn;
        d=abs(min([Up,Down])-mx);
        if(mx<0||d<20)
            F=1;
        end
    elseif(UDdiff<20)
        mn =min([Up,Down]);
        mx =max([Right,Left]);
        mx=mx-mn;
        d=abs(min([Right,Left])-mx);
        if(mx<0||d<25)
            F=1;
        end
    end

end
%figure,imshow(bw),hold on;

end

