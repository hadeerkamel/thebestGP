function [ word,diagi,diagj] = follow_diag( word,i,j )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[H W]=size(word);
diagi=i;diagj=j;
while(i-1>0&&j+1<=W&&(word(i-1,j+1)==1||(word(i,j+1)==1&&j+2<=W&&word(i-1,j+2)==1)))
    if(word(i-1,j+1)==1)
        i=i-1;
        word(i-1,j+1)=0;
    else
        word(i,j+1)=0;
    end
    j=j+1;
end
if(diagi==i&&diagj==j)
    while(i+1<=H&&j+1<=W&&(word(i+1,j+1)==1||(word(i,j+1)==1&&j+2<=W&&word(i+1,j+2)==1)))
        if(word(i+1,j+1)==1)
            i=i+1;
            word(i+1,j+1)=0;
        else
            word(i,j+1)=0;
        end
        j=j+1;
    end
end

diagi=i;diagj=j;

end

