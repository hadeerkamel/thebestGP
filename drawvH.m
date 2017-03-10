function [ word ] = drawvH(word,i,j,diagi,diagj);
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
for r=j:diagj
   word(diagi,r)=1;
end

    
    for c=min([diagi i]):max([diagi,i])
        word(c,j)=1;
    end

end

