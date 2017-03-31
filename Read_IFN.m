im_names = ['ae07_';'ae19_';'ae70_';'ae77_';'ae97_';'af03_';'af27_';'ai14_';'ai46_';'aq34_'];
im_count = [52,60,60,55,58,50,54,60,60,60];
for nameindex=1:9
    im_path=im_names(nameindex,:);
    for count=2:im_count(nameindex)
        s=strcat(im_path,num2str(count,'%03i'),'.bmp');
        fprintf('%s\n',s  );
        Im=imread(s);
        figure,imshow(Im);
        bw=LoopAgent(Im);
    end
end

