function [ bw ] = semi_loopedCavities( bw )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[height width]=size(bw);
[F,Endpoints] = FindEndPonits( bw,0 );
[N1,N2]=size(Endpoints);
for e=1:N2
    j=Endpoints(1,e);
    for i=Endpoints(2,e)+2:height
        if(bw(i,j))
            bw(Endpoints(2,e):i,j)=1;
            break;
        end
    end
end
bw=LoopAgent(bw);
end

