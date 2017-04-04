function [ bw ] = Under_Baseline_CavitiesAgent( Line_index,bw )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[F,Endpoints ] = FindEndPonits(bw,Line_index);
if(~F)
    return;
end
%figure,imshow(bw),hold on;
%plot(Endpoints(1,:), Endpoints(2,:), 'r.');

%1-under baseline endpoints ? ? ? ? ? ? ?  ?

[N1,N2]=size(Endpoints);
for e=1:N2
    i=Endpoints(2,e);
    j=Endpoints(1,e);
    while(1)
        %remove
        bw(i, j)=0;
        %move
        [f,newi,newj]=decideamove(bw,i,j);
        if(f==0)
            bw(i, j)=1;
            break;
        else
            i=newi;
            j=newj;
        end
        
    end
    
end

%2-under baseline ? ? ? ? ? ?

% find a deepest point under baseline

[F,DeepPoints ] = find_DeepPoints( bw,Line_index );
if(F)
    figure,imshow(bw),hold on;
    plot(DeepPoints(1,:), DeepPoints(2,:), 'r.');
end
% check if it have to up cavities from both sides
% remove it and both cavities if exist

end

