function [ columnsTocutAt nWords] = CutWordsAt( Line ,SpaceTh )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[H W] = size(Line);
horizontalProfile = sum(Line,1);
%plot(horizontalProfile);
L = length(horizontalProfile);
zeroColumnsCount = 0;
firstnonzeroflag = 0;
%plot(1:L,horizontalProfile);
nWords = 1;
columnsTocutAt = [];
columnsTocutAt(1) = 1;
nWords = 1;

for ll = 1:L
%     if(horizontalProfile(ll)~=0 && firstnonzeroflag == 0)
%         firstnonzeroflag = 1;
%     elseif(firstnonzeroflag == 1 && zeroColumnsCount<10 && horizontalProfile(ll) == 0)
%         zeroColumnsCount = zeroColumnsCount + 1;
%     elseif(zeroColumnsCount==10 && horizontalProfile(ll) == 0)
%         columnsTocutAt(nWords) = ll;
%         zeroColumnsCount = 0;
%         nWords = nWords + 1;
      if(horizontalProfile(ll)~=0&&firstnonzeroflag == 0)
          columnsTocutAt(nWords) = ll;
          firstnonzeroflag = 1;
          nWords = nWords + 1;
      elseif(firstnonzeroflag == 1&&horizontalProfile(ll) == 0)
          zeroColumnsCount = zeroColumnsCount + 1;
      elseif(horizontalProfile(ll) ~= 0&&zeroColumnsCount>SpaceTh)
          columnsTocutAt(nWords) = ll;
          zeroColumnsCount = 0;
          nWords = nWords + 1;
end
columnsTocutAt(nWords) = W;
end

