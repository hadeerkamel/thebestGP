function [ F,Endpoints] = find_curved_senna(I)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

N=1;
F=0;
%Endpoints=0;
horizontalProjection = sum(I,2);
[Maxpeak BL]=max(horizontalProjection);
    step();
[H W] =size(I);
figure,imshow(I),hold on;
xy=[1 BL;W BL];
plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
        
for r=10:H
    for c=1:W
        if(I(r,c))
            s=sum(sum(I(r-1:r+1,c-1:c+1)));
            if(s==3)
                if((I(r+1,c-1)&&I(r+1,c+1))||(I(r+1,c-1)&&I(r,c+1)&&I(r+1,c+2)))
                    Endpoints(:,N) = [c;r];
                    F=1;
                    N=N+1;
                end
            end
        end
    end
end
if(F==0)
    Endpoints=0;
end

end

