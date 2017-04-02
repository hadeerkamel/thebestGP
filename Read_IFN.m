im_names = ['ae07_';'ae19_';'ae70_';'ae77_';'ae97_';'af03_';'af27_';'ai14_';'ai46_';'aq34_'];
im_count = [52,60,60,55,58,50,54,60,60,60];
for nameindex=1:9
    im_path=im_names(nameindex,:);
    for count=1:im_count(nameindex)
        s=strcat(im_path,num2str(count,'%03i'),'.bmp');
        fprintf('%s\n',s  );
        Im=imread(s);
        figure,imshow(Im);
        [Line_index RotatedWord ]=FindBaseLine(Im);
        % s=slpit_isolated_chars_and_subwords(RotatedWord,Line_indces);
        
        % bw=LoopAgent(RotatedWord);
        % bw=RemoveSmallComp( bw);
        %figure,imshow(bw);
        
        dilatedImage = imdilate(RotatedWord,strel('disk',5));
        figure,imshow(dilatedImage);
        
        thinedImage = bwmorph(dilatedImage,'thin',inf);
        figure,imshow(thinedImage);
        
        bw=LoopAgent(thinedImage);
        figure,imshow(bw);
        bw=RemoveSmallComp( bw);
        figure,imshow(bw);
        %bw=thinedImage;
        
        %  [ subWords nsubWords ] = SegmentWords( bw,5);
        %for w=1:nsubWords
        while(1)
            [F,Endpoints ] = FindEndPonits(bw,Line_index);
            if(~F)
                break;
            end
            figure,imshow(bw),hold on;
            plot(Endpoints(1,:), Endpoints(2,:), 'r.');
            [N1,N2]=size(Endpoints);
            %while there is no branch
            for e=1:N2
                i=Endpoints(2,e);
                j=Endpoints(1,e);
                while(1)
                    %remove
                    bw(i, j)=0;
                    %imshow(bw),hold on;
                    %move
                    [f,newi,newj]=decideamove(bw,i,j);
                    if(f==0)
                        break;
                    else
                        i=newi;
                        j=newj;
                    end
                    %plot(j, i, 'r.');
                end
                figure,imshow(bw);
            end
        end
    end
    % end
end

