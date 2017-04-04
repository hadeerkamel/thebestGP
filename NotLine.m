function [ F ] = NotLine(bw,i,j)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
N=1;
F=1;
for r=i-1:i+1
    for c=j-1:j+1
        if(~(r==i&&c==j)&&bw(r,c))
            M(:,N)=[r;c];
            N=N+1;
        end
    end
end
slope1=(M(2,1)-j)/(M(1,1)-i);
slope2=(j-M(2,2))/(i-M(1,2));
if(slope1==slope2)
    F=1;
end
end

