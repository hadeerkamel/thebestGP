function [chars,N]=segment(bw,Endpoints)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[N1 N2]=size(Endpoints);
[h w ]=size(bw);
N=1;
if(N2==1)
    return;
end
cutting_pints(1)=1;
for e=1:2:N2
    j1=Endpoints(1,e);
    j2=Endpoints(1,e+1);
    N=N+1;
    cutting_pints(N)=min([j1 j2])+(abs(j1-j2)/2);
    xy=[ cutting_pints(N) 1;cutting_pints(N) h];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
end



N=N+1;
cutting_pints(N)=w;
cutting_pints=sort(cutting_pints);
nchar=1;
for i=1:N-1
    minx=cutting_pints(i);
    miny=1;
    charwidth=cutting_pints(i+1)-cutting_pints(i);
    chars{i}=imcrop(bw,[minx miny charwidth h]);
end
end

