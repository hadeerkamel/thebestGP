im_names = ['ae07_';'ae19_';'ae70_';'ae77_';'ae97_';'af03_';'af27_';'ai14_';'ai46_';'aq34_'];
im_count = [52,60,60,55,58,50,54,60,60,60];
for nameindex=1:9
    im_path=im_names(nameindex,:);
    for count=1:im_count(nameindex)
        s=strcat(im_path,num2str(count,'%03i'),'.bmp');
        fprintf('%s\n',s  );
        Im=imread(s);
        [height width]=size(Im);
        figure,imshow(Im);
        
        [ chars,nchars] = SegmentCharacters( Im);
%         for charno=1:nchars-1
%         
%                   figure,imshow(chars{charno});
%                  end
        
        %%
       % [Line_index RotatedWord ]=FindBaseLine(Im);
        %% Smooth
        
        %dilatedImage = imdilate(RotatedWord,strel('disk',5));
        %figure,imshow(dilatedImage);
        %thinedImage = bwmorph(dilatedImage,'thin',inf);
        %%print baseline
        
        %                 figure,imshow(thinedImage),hold on;
        %                 [h width ]=size(thinedImage);
        %                 xy=[1 Line_index;width Line_index];
        %                 plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
        %% smooth
        %         dilatedImage = imdilate(RotatedWord,strel('disk',5));
        %         %figure,imshow(dilatedImage);
        %         thinedImage = bwmorph(dilatedImage,'thin',inf);
        %  figure,imshow(thinedImage);
        %% remove agents
        %  [ Words nWords ] = SegmentWords(thinedImage ,1);
        
        %for w=1:nWords
        %     figure,imshow(Words{w});
        %end
        
        %figure,imshow(thinedImage);
%         bw=RemoveSmallComp( thinedImage,30);
%         figure,imshow(bw);
%         
%         bw=LoopAgent(bw);
%         bw=RemoveSmallComp( bw,20);
%         
%         
%         
%         bw=Under_Baseline_CavitiesAgent( Line_index,bw );
%         bw=RemoveSmallComp( bw,20);
%         
        %         bw=LoopAgent(bw);
        %         bw=RemoveSmallComp( bw,20);
        %figure,imshow(bw);
        %
        %
        %
        
        
%         bw = imdilate(bw,strel('disk',5));
%         %figure,imshow(dilatedImage);
%         bw = bwmorph(bw,'thin',inf);
%         
%         
%         [ F,Endpoints ] = FindEndPonits( bw,0 );
        
        
        
        %         figure,imshow(bw),hold on;
        %         plot(Endpoints(1,:), Endpoints(2,:), 'r.');
        %
        %         [chars,nchars]=segment(thinedImage,Endpoints);
        %         for charno=1:nchars-1
        %
        %          figure,imshow(chars{charno});
        %         end
        
        
        %  figure,imshow(thinedImage),hold on;
        %[h width ]=size(thinedImage);
        % xy=[1 Line_index;width Line_index];
        %plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
        
        
        
        %         %bw = imdilate(bw,strel('disk',3));
        %         %bw = bwmorph(bw,'thin',inf);
        %
        %
        %
        %
        %        % bw = imsharpen(bw) ;
        %       % bw=imfilter(bw,fspecial('unsharp'));
        %         figure,imshow(bw),hold on;
        %
        %         [ F,Endpoints ] = FindEndPonits( bw,-5 );
        %        %  [ sF,sennapoints] = find_curved_senna(bw);
        % %          if(sF)
        % %              plot(sennapoints(1,:), sennapoints(2,:), 'b.');
        % %          end
        %
        %       % plot(Endpoints(1,:), Endpoints(2,:), 'r.');
        %
        %
    end
end


