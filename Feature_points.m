function [ F,FeaturePoints ] = Feature_points( I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[H W]=size(I);
N=1;
F=0;
%Endpoints=0;
for r=1:H
    for c=1:W
        if(I(r,c))
            s=sum(sum(I(r-1:r+1,c-1:c+1)));
            if(s>3)
                %plot it read & trac
                plot(c,r,'r.');
               % if(NotLine(I,r,c))
                    
                    FeaturePoints(:,N) = [c;r];
                    F=1;
                    N=N+1;
               % end
            end
        end
    end
end
if(F==0)
    Endpoints=0;
end
end

