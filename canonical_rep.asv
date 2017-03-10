function [ word ] = canonical_rep( word )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
figure,imshow(word);
[H W]=size(word);
for j=1:W
    for i=1:H
        
        if(word(i,j)==1)
            [word,diagi,diagj]=follow_diag(word,i,j);
            %delete_diag(word,i,j,diagi,diagj);
            word=drawvH(word,i,j,diagi,diagj);
        end
    end
end
figure,imshow(word);
end

