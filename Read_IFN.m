im_names = ['ae07_';'ae19_';'ae70_';'ae77_';'ae97_';'af03_';'af27_';'ai14_';'ai46_';'aq34_'];
im_count = [52,60,60,55,58,50,54,60,60,60];
for nameindex=1:9
    im_path=im_names(nameindex,:);
    for count=1:im_count(nameindex)
        s=strcat(im_path,num2str(count,'%03i'),'.bmp');
        fprintf('%s\n',s  );
        Im=imread(s);
        figure,imshow(Im);
        %%
        [Line_index RotatedWord ]=FindBaseLine(Im);
        
        %         figure,imshow(RotatedWord),hold on;
        %         [h width ]=size(RotatedWord);
        %         xy=[1 Line_index;width Line_index];
        %         plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
        %% smooth
        dilatedImage = imdilate(RotatedWord,strel('disk',5));
        %figure,imshow(dilatedImage);
        thinedImage = bwmorph(dilatedImage,'thin',inf);
        figure,imshow(thinedImage);
        %%
        bw=RemoveSmallComp( thinedImage);
        bw=Under_Baseline_CavitiesAgent( Line_index,bw );  %? ? ? ? ? ? ?   ? ? ? ? ? ??
        
        bw=RemoveSmallComp( bw);
        
        bw=LoopAgent(bw); % ? ? ? ? ? ? ? ? ? ? 
        bw=RemoveSmallComp( bw);
       
        
        
        
       
        
        figure,imshow(bw);
     
    end
end


