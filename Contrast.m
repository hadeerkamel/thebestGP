function [New] = Contrast(Old, NewMin, NewMax)
[H W L] = size(Old);

%Pre-allocate empty matrix for the result
New = uint8(zeros(H,W,L));

for i=1:L
    %seperate each color channel (R, G, B) in TmpBuf and process it
    TmpBuf = double(Old(:,:,i));
    
    %Find old min & old max
    OldMin = min(min(TmpBuf));
    OldMax = max(max(TmpBuf));
    
    %Apply contrast equation
    New(:,:,i) = uint8((TmpBuf - OldMin) ./ (OldMax - OldMin) .* (NewMax - NewMin) + NewMin);
end
