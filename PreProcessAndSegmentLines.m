function [ Lines nLines] = PreProcessAndSegmentLines( I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 %Preprocessing ( Binarization , removing noise )
 %to test skewCorrection
 %ImageName = 'AHTD3A0226_Para2.tif';
 %ImageName = 'AHTD3A0137_Para2W(60,30).tif';
 %ImageName = 'AHTD3A0101_Para2w.tif';
 %ImageName = 'AHTD3A0018_Para2w.tif';
 %ImageName = 'AHTD3A0018_Para2w.tif';
 % to test Line And word Segmentation
 %ImageName = 'AHTD3A0018_Para2.tif';
%  I = imread(ImageName);
%  figure,imshow(I);
%I = imread(ImageName);
%COlorSegmentedImage = I;
%info = imfinfo(ImageName);
%R = info.ColorType;

BinaryImage = im2bw(I,0.8);
%figure,imshow(BinaryImage);
compI = imcomplement(BinaryImage);
SE = strel('disk',20);
compIDilated = imdilate(compI,SE);
%figure,imshow(compIDilated);
[compIDilated] = RemoveSmallComp( compIDilated,2000);
%figure,imshow(compIDilated);
[H W] = size(compIDilated);
%% Dilate , get corner points and crop
for sizes = 10:W
SE = strel('disk',sizes);
compIDilated = imdilate(compIDilated,SE);
sizes = sizes + 5;
CC = bwconncomp(compIDilated);
N = CC.NumObjects;
if(N==1)
    break;
end
end
% figure,imshow(compIDilated);
% %figure,imshow(compI);
% stats1 = regionprops(CC,'BoundingBox');
% BoundingBox = stats1.BoundingBox;
% BoundingBox(1) = fix(BoundingBox(1)) + 1;
% BoundingBox(2) = fix(BoundingBox(2)) + 1;
% ul = [BoundingBox(1) BoundingBox(2)];
% ur = [BoundingBox(1)+BoundingBox(3) BoundingBox(2)];
% lr = [BoundingBox(1)+BoundingBox(3) BoundingBox(2)+BoundingBox(4)];
% ll = [BoundingBox(1) BoundingBox(2)+BoundingBox(4)];
% corners = [ul(1) ll(1) lr(1) ur(1);ul(2) ll(2) lr(2) ur(2)];
% PM = [1 BoundingBox(3) 1 BoundingBox(3);1 1 BoundingBox(4) BoundingBox(4)];
% cc = [ul(1) ll(1) lr(1) ur(1)];
% rr = [ul(2) ll(2) lr(2) ur(2)];
% figure,imshow(compIDilated);
% hold on
% plot(cc,rr, 'b*')
% xy = [ul(1) ul(2);ur(1) ur(2)];
% xy2 = [ll(1) ll(2);lr(1) lr(2)];
% plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
% plot(xy2(:,1),xy2(:,2),'LineWidth',2,'Color','green');
% hold off;

%AlignedImage = WarpBinaryImage(compIDilated ,corners ,PM);
%RotatedImage = imrotate(compIDilated,angle);
%figure,imshow(AlignedImage);
[newCroppedI , ~, ~] = SegmentConnComp(compIDilated,compI);
%figure,imshow(newCroppedI);
[newDilatedCroppedI , ~, ~] = SegmentConnComp(compIDilated,compIDilated);
N = CC.NumObjects;
%figure,imshow(newCroppedI);
%point1inLastLine = [maxX itsR];
flagEnter = 0;
[HW WH] = size(compIDilated);
%get corner of bottom left
for r = HW:-1:1 
    for c = 1:WH
        if(compIDilated(r,c)==1)
            point2inLastLine = [c r];
            flagEnter = 1;
            break;
        end
    end
     if(flagEnter==1)
        break;
     end
end
%Check skew direction of gotten point in first quarter???!!!
c = ceil(3*WH/4);
if(point2inLastLine(1)<c)
    %mayel l ta7t
    SkewDirection = -1;
else
    SkewDirection = 1;
end



%based on previous get other point




%get corner of bottom right if skew direction downward
if(SkewDirection == -1)
flagEnteredBefore = 0;
indexOfPoints = 1;
for c = WH:-1:ceil(3*WH/4) 
    for r = HW:-1:1
        if(compIDilated(r,c)==1)
            points1inLastLineC(indexOfPoints) = c;
            points1inLastLineR(indexOfPoints) = r;
            indexOfPoints = indexOfPoints + 1;
            break;
        end
    end
     
end
indexOfPoints = indexOfPoints - 1;
[mC ii]= max(points1inLastLineC);
mR = points1inLastLineR(ii);
bb = 0;
iii = 1;
c = fix((mC +  point2inLastLine(1))/2);
    for r = mR:HW
        rrr(iii) = r;
        ccc(iii) = c;
        iii = iii+1;
        if(compIDilated(r,c)==1)
            bb = bb + 1;
        end
    end

if(bb>100)
    points1inLastLineC(ii) = 0;
    points1inLastLineR(ii) = 0;
    [mR I] = max(points1inLastLineR);
    mC  = points1inLastLineC(I);
    for indd = 1:indexOfPoints
        diff =  abs(mR - points1inLastLineR(indd));
        if(points1inLastLineC(indd)>= mC && diff<20)
            mC = points1inLastLineC(indd);
            mR = points1inLastLineR(indd);
            break;
        end
    end
end
end
% for ii = 1:indexOfPoints
%     if(points1inLastLineC(ii)==mC )
%         RR = points1inLastLineR(ii)
%         inde = ii;
%     end
% end

% [X I1] = max(points1inLastLineC);
% [Y I2] = max(points1inLastLineR);
% 
% if(points1inLastLineR(I1)<Y)
%     points1inLastLineC(I1) = 0;
% end

%figure,imshow(compIDilated);
%hold on
%plot(point2inLastLine(1),point2inLastLine(2), 'b*')
%plot(mC,mR,'b*')
%plot(points1inLastLineC,points1inLastLineR,'b*');
% plot(point2inFirstLine(1),point2inFirstLine(2), 'b*')

xy3 = [mC mR;point2inLastLine(1) point2inLastLine(2)]; 
xy4 = [mC mR;mC - 200 mR];
diffInrowsBetweentheTwoLines = abs(point2inLastLine(2) - mR);
%plot(xy3(:,1),xy3(:,2),'LineWidth',2,'Color','green');
%plot(xy4(:,1),xy4(:,2),'LineWidth',2,'Color','red');
%hold off

%angle_in_deg=atan2(point2inLastLine(2)-point1inLastLine(2),point2inLastLine(1)-point1inLastLine(1))*180/pi;
%v1 = [point1inLastLine(1) point1inLastLine(2)] - [point2inLastLine(1) point2inLastLine(2)];
m1y = mR - point2inLastLine(2);
m1x = mC - point2inLastLine(1);
m1 = m1y / m1x;
angleOfinclination1 = atan(m1);
skewedAngle = angleOfinclination1 * 180 / pi;
%v2 = [point1inLastLine(1) point1inLastLine(2)] - [point1inLastLine(1)-200 point1inLastLine(2)];
% m2y = point1inLastLine(2) - point1inLastLine(2);
% m2x = (point1inLastLine(1)-200) - point1inLastLine(1);
% m2 = m1y / m2x;
% angleOfinclination2 = atan(m2);
% angle = abs(angleOfinclination1 - angleOfinclination2);
if(skewedAngle<0 && diffInrowsBetweentheTwoLines < 250 && abs(skewedAngle)>5)
newCroppedI = imrotate(newCroppedI,(skewedAngle + 2));
newDilatedCroppedI = imrotate(compIDilated,(skewedAngle + 2));
end
%figure,imshow(newDilatedCroppedI);
%figure,imshow(newCroppedI);
% a1 = mod(atan2( det([v1;v2;]) , dot(v1,v2) ), 2*pi );
% angleout = abs((a1>pi/2)*pi-a1); 
%figure,imshow(newDilatedCroppedI);


% stats = regionprops(CC,'Centroid');
% centroids1 = cat(1, stats.Centroid);
% 
% 
% CC = bwconncomp(newDilatedCroppedI);
% stats = regionprops(CC,'Centroid');
% centroids = cat(1, stats.Centroid);
% figure,imshow(newCroppedI),
% hold on
% plot(centroids(:,1), centroids(:,2), 'b*')
% hold off;
%% Count Number Of lines

[H W] = size(newCroppedI);
rr = [1 50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000 1050 1100 1150 1200];
cc = [5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5];
[rowsToCutAt nLines] = CutLinesAt(newCroppedI);
for i = 1:nLines
    if(i==1)
        previousEndRow = 1;
    end
    if(i>1)
    H = rowsToCutAt(i) - rowsToCutAt(i - 1);
    LineSizes(i) = H;
    minX = 1;
    minY = rowsToCutAt(i - 1);
    Lines{i - 1} = imcrop(newCroppedI,[minX minY W H]);
    %figure,imshow(Lines{i - 1});
    end
end
falseLines = 0;
dividedflag = 0;
for i = 2:nLines
    if(i==4)
        i = 4;
    end
    mm = mean(LineSizes)+50;
    if(LineSizes(i)> mm)
        %handle way larger
        for s = 1:10
            SE = strel('disk',s);
            compIDilated = imerode(Lines{i-1},SE);
            [rows newlines] = CutLinesAt(Lines{i-1});
            
            if(newlines>0)
                dividedflag = 1;
                %newlines = newlines - 1;
               for j = 2:newlines
                  H = rows(j) - rows(j - 1);
                  LineSizes(nLines + j - 1) = H;
                  minX = 1;
                  minY = rows(j - 1);
                  Lines{nLines + j - 1} = imcrop(Lines{i-1},[minX minY W H]);
                 % figure,imshow(Lines{nLines + j - 1}); 
               end
               break;
            end
        end
        if(dividedflag==0)
            %figure,imshow(Lines{i-1});
            for ss = 1:15
            SE = strel('disk',s);
            LinesDilated = imdilate(Lines{i-1},SE);
            CC = bwconncomp(LinesDilated);
            N = CC.NumObjects;
            if(N==1)
                break;
            end
            end
            [newCroppedI , ~, ~] = SegmentConnComp(LinesDilated,Lines{i-1});
            [H W] = size(newCroppedI);
            Lines{nLines} = imcrop(newCroppedI,[1 1 W ceil(H/2)]);
            %figure,imshow(Lines{nLines});
            Lines{nLines + 1} = imcrop(newCroppedI,[1 ceil(H/2) W ceil(H/2)]);
            nLines = nLines + 2;
            %figure,imshow(Lines{nLines + 1});
        end
    elseif(LineSizes(i)< (mean(LineSizes)-50))
        %handle way smaller
        falseLines = falseLines + 1;
        del(falseLines) = i;
    end
end
countWhite = 0;
% for n = 1:nLines
%     [H W] = size(Lines{n});
%     
%     for r = 1:H
%         for c = 1:W
%             if(Lines{n}(r,c)==1)
%                 countWhite = countWhite + 1;
%             end
%             
%         end
%     end
%     if(countWhite<100);
%     countWhite = 0;
% end
nLines = nLines - 1;
end
% % figure,imshow(newCroppedI);
% columnsToCountLinesAt(1) = W - 20;
% columnsToCountLinesAt(2) = W - 50;
% columnsToCountLinesAt(3) = ceil(W/2);
% columnsToCountLinesAt(4) = ceil(W/2) - 20;
% columnsToCountLinesAt(5) = ceil(W/2) - 10;

% figure,imshow(newCroppedI),
% hold on
% plot(columnsToCountLinesAt,20,'b*')
% hold off;

% for counter = 1:5
%     numberOflines(counter) = 0;
% end
% 
% for counter = 1:5
%     whiteflag = 0;
%     blackcounter = 0;
%     whitecounter = 0;
%     c = columnsToCountLinesAt(counter);
% for r = 1:H
%     if(newCroppedI(r,c)==1 && whitecounter == 0)
%         whitecounter = whitecounter +1;
%         blackcounter = 0;
%         
%     elseif(newCroppedI(r,c)==0 && whitecounter~= 1);
%         blackcounter = blackcounter + 1;
%         whitecounter = 0;
%     end 
%     
%     if(blackcounter>=20 && whitecounter == 0)
%         numberOflines(counter) = numberOflines(counter) + 1;      
%     end
%     
% end
% end


%% Paragraph Segmentation into lines
%using vertical projection profile
% SE = strel('disk',1);
% compIDilated = imerode(newCroppedI,SE);
% % figure,imshow(compIDilated);
% verticalProfile = sum(compIDilated,2);
%plot(verticalProfile);
% v = verticalProfile';



% L = length(verticalProfile);
% zeroRowsCount = 0;
% rowInd = 0;
% rowsToCutAt = [];
% figure,imshow(newCroppedI),
% hold on 
% plot(cc, rr, 'b*')
% figure,imshow(newCroppedI),
% text(5, 500, sprintf('%d', verticalProfile(500),'b'), 'Units', 'data')
% hold on
% plot(cc,rr,'b*')
% hold off;
% rowsToCutAt(1) = 1;
% nLines = 2;
% for i = 1:L
%     if(verticalProfile(i) < 60)
%         zeroRowsCount = zeroRowsCount + 1;
%         rowInd = i;
%         if(zeroRowsCount >= 30 && verticalProfile(i-1)< 60 && i~=L && verticalProfile(i+1)> 60)
%             rowsToCutAt(nLines) = rowInd - 10;
%             zeroRowsCount = 0;
%             nLines = nLines + 1;
%         end
%     end
% end

% invertedY = - verticalProfile;
% [peakValues, indexes] = findpeaks(invertedY,'SORTSTR','ascend');
% [H W] = size(newCroppedI);
% 
% rowsToCutAt(nLines) = H;

% for i = 1:nLines
% SE = strel('disk',s);
% compIDilated = imdilate(newCroppedI,SE);
% CC = bwconncomp(compIDilated);
% N = CC.NumObjects;
% if(N== (nLines - 1))
%     break;
% else
%     s = s + 5;
% end
% end
% figure,imshow(compIDilated);


% figure,imshow(newCroppedI),
% hold on
% plot(cc, rr, 'b*')
% hold off;
%  [R, xp] = radon(compIDilated, [0 90]);
%  figure; plot(xp,R(:,2)); title('at angle 90');
 
 
% vertical = verticalProfile';
% L = length(verticalProfile);
% distance = 0;
% for d = 1:L
%     if(verticalProfile(d)==0)
%         distance  = distance + 1;
%     end
% end
% [pks locs] = findpeaks(verticalProfile,'MINPEAKDISTANCE',distance);
% % figure,imshow(compIDilated),
% % hold on
% verticalSmoothed = medfilt1(verticalProfile);
% plot(verticalProfile)
%plot(verticalSmoothed)
% hold off;


% [smallest,idx] = min(numPixels);
% 




% for size = 15:5:W
% SE = strel('disk',size);
% compIDilated = imdilate(compI,SE);
% CC = bwconncomp(compIDilated);
% N = CC.NumObjects;
% if(N==1)
%     break;
% end
% end
% figure,imshow(compIDilated);


% SE = strel('disk',20);
% compIDilated = imdilate(compI,SE); 
% figure,imshow(compIDilated);
% CC = bwconncomp(compIDilated);
% N = CC.NumObjects;
%compI = imfill(compI,'holes');
%figure,imshow(compI);

% [labeledImage numberOfBlobs] = bwlabel(compI,8);
% blobmeasurements = regionprops(labeledImage,'Orientation');
% allOrientations = [blobmeasurements.Orientation];
% angleToRotate = - allOrientations(3);
% rotatedImage = imrotate(BinaryImage,angleToRotate);
% figure,imshow(rotatedImage);

%cc = bwconncomp(




