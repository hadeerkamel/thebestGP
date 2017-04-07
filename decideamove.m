function [f,newi,newj]=decideamove(bw,i,j,Go_Down)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

s=sum(sum(bw(i-1:i+1,j-1:j+1)));
N=1;
f=1;
newi=0;newj=0;
for r=i-1:i+1
    for c=j-1:j+1
        if(bw(r,c))
            M(:,N)=[r;c];
            N=N+1;
        end
    end
end
if(N~=1)
 %plot(M(2,:), M(1,:), 'r.');
end
if(s==0)
    f=0;
elseif(s~=1)
    
    dis=((M(1,1)-M(1,2))^2 + (M(2,1)-M(2,2))^2)^0.5;
    if(dis==1)
        if(M(1,1)==i)
            newi=M(1,1);
            newj=M(2,1);
        elseif(M(1,2)==i)
            newi=M(1,2);
            newj=M(2,2);
        elseif(M(2,1)==j)
            newi=M(1,1);
            newj=M(2,1);
        elseif(M(2,2)==j)
            newi=M(1,2);
            newj=M(2,2);
        end
    elseif(dis>1&&dis<2)
        %go for both directions
        newi=M(1,1);
        newj=M(2,1);
        bw(M(1,2),M(2,2))=0;
    else
        f=0;
    end
elseif(N==1)
    f=0;
else
    newi=M(1,1);
    newj=M(2,1);
end

if(~Go_Down&&newi==i+1&&newj==j+1&&bw(i+2,j+2))
    f=0;
end

