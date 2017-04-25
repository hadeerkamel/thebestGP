function [ result  ] = seen_agent( im )
%     bw = imdilate(im,strel('disk',5));
%     figure,imshow(bw);
%      bw = bwmorph(bw,'thin',inf);
%        figure,imshow(bw);

   %[chars ,subchars] = SegmentWords(bw,1);
   %for i=1 :subchars
       bw = imdilate(im,strel('disk',5));
       bw = bwmorph(bw,'thin',inf);
       bw = imdilate(bw,strel('disk',5));
       bw = bwmorph(bw,'thin',inf);
        figure,imshow(bw);
        [lineindex, s]=FindBaseLine(bw);
         figure,imshow(s);
       [f, endpoints2]=FindEndPonits(s,0);
       figure,imshow(s),hold on;
        plot(endpoints2(1,:), endpoints2(2,:), 'r.')
       count=0;
       nbra_count=1;
       [N1,N2]=size(endpoints2);
       for j=1 : N2
           r=endpoints2(2,j);
          % c=endpoints2(1,j);
          %[c  r]=endpoints2(:,i);
           if(abs(r-lineindex)<30&&abs(r-lineindex)>5&&r<lineindex)
               count=count+1;
               nbra_y_x(:,nbra_count)=endpoints2(:,j);
               nbra_count=nbra_count+1;
           elseif(r>lineindex&&count<2)
               nbra_count=nbra_count-count;
               count=0;
           elseif(r>lineindex&&count>3)
           end
       end
       nbra_count=nbra_count-1;
       if (nbra_count>2)
               for k=1:length(nbra_count)
                   if(k+2>nbra_count)
                       break;
                   
                   else
                   nbra_y_x=sort(nbra_y_x,2);
                   c1 =nbra_y_x(1,k);
                   c2 =nbra_y_x(1,k+2);
                   if(abs(c1-c2)<50)
                       im(:,c1:c2)=0;
                      im= RemoveSmallComp(im,5);
                       figure,imshow(im);
                       result=im
                       break;
                   end
                   end
               end
       end
   %end
end
   
%[f, endpoints2]=FindEndPonits(im,0);
% figure,imshow(im),hold on;
%         plot(endpoints2(1,:), endpoints2(2,:), 'r.');
        %FindBaseLine(im);
% [N1,N2]=size(Endpoints);
%         for e=1:N2
%             j=endpoints2(1,e);
%             i=endpoints2(2,e);
%           p
%         end
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%how to calculate nbra nums
%I = bwconncomp(im);
% [y, x] = find(im);
% l= length(x);
% for i=1 : l
%     figure,imshow(im),hold on;
%     plot(x(i), y(i), 'r.')
% end;

% count_nbra=0;
% count=0;
% test=1;
% for i=2 : l
%     if (abs(y(i+(count_nbra*10))-y(i+(count_nbra*10)-1))==1)
%         count=count+1;
%     elseif(abs(y(i+(count_nbra*10))-y(i+(count_nbra*10)-1))>4||abs(y(i+(count_nbra*10))-y(i+(count_nbra*10)-1))==0)
%         if(count>2&&count<10)
%             if(test>1)
%           val = s_end_x(test-1,:);
%           if (abs(x(val(2))- x(i+(count_nbra*10)))>20)
%             figure,imshow(im),hold on;
%             plot(x(i+(count_nbra*10)), y(i+(count_nbra*10)), 'r.');
%             s_end_x(test ,:)= [i+(count_nbra*10)-count i+(count_nbra*10)];
%             count_nbra=count_nbra+1;
%             test=test+1;
%           end
%             
%         else
%             figure,imshow(im),hold on;
%             plot(x(i+(count_nbra*10)-count), y(i+(count_nbra*10)-count), 'r.')
%             s_end_x(test ,:)= [i+(count_nbra*10)-count i+(count_nbra*10)];
%             count_nbra=count_nbra+1;
%             test=test+1;
%             end
%         end
%         count=0;
%     else
%     end
%     end
% [x1 , x2]=find(s_end_x);
% l2=length(x1);
% figure,imshow(im),hold on;
% for i=1 : l2
%     plot(x(x2(i)), y(x2(i)), 'r.')
%         if (y(x1(i))>y(x2(i)))
%             im(x(x1+10), y(x1+10))=0;
%             im(x(x1+11),y(x1+11))=0;
%             im(x(x1+12),y(x1+12))=0;
% 
%         else
%             im(x(x2+10), y(x2+10))=0;
%             im(x(x2+11),y(x2+11))=0;
%             im(x(x2+12),y(x2+12))=0;
%         end
%         %figure,imshow(im)
% end
% % st = regionprops( I,  'PixelList');
% % xy=cat(1,st.PixelList);
% % xy(:,2) = abs(xy(:,2) - size(I2,1)) + 1;
% % plot(xy(:,1),xy(:,2),'g*');
% figure,imshow(im)
%end

