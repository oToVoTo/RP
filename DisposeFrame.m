function  status = DisposeFrame(directory)
    status = true;
    cd(directory);
    fileDat =dir(fullfile(directory,'*.jpeg'));
    numFile = size(fileDat,1);
    pixNum =zeros(numFile,1);
    picTemp = cell(numFile,1);
    tNumImage = 1;
     deleteAllRetralFileFlag = false;
    for i = 1:numFile
        fileName = fileDat(i,1).name;
        im=imread(fileName);
   if deleteAllRetralFileFlag == true
       movefile(strcat(directory,'\',fileName),'C:\Users\Administrator\Desktop\RP\1');
       continue;
   end
       
        if size(im,3) == 3
            im = rgb2gray(im);
        end
%           subplot(1,2,1);
%           imshow(im)
%           hold on
%             im = histeq(im);
         im = im2bw(im,0.2);
        im = bwareaopen(im,300,8);
%        subplot(1,2,2)
%        imshow(im)
%         pause(3)

        [m,n] = size(im);
        sumLineTail = sum(im(:,1:end));
        sunLineHead = sum(im(1:floor(end/2),:));
        
%         max(find(sumLine == 0))

        if max(find(sumLineTail == 0)) > (n/2)
            
          movefile(strcat(directory,'\',fileName),'C:\Users\Administrator\Desktop\RP\1');
          continue;
        end
        if min(find(sunLineHead == 0)) < (n/2) & (i < floor(numFile/2)+1)
            if exist(strcat(directory,'\',fileName),'file')
               
             movefile(strcat(directory,'\',fileName),'C:\Users\Administrator\Desktop\RP\1');
            end
        end
        if min(find(sunLineHead == 0)) < (n/2) & (i > floor(numFile/2))
            deleteAllRetralFileFlag = true;
            
            if exist(strcat(directory,'\',fileName),'file')
               
               movefile(strcat(directory,'\',fileName),'C:\Users\Administrator\Desktop\RP\1');
            end
        end      
    end
    
%     fileDat =dir(fullfile(strcat(directory),'*.jpeg'));
%     numFileForSum = size(fileDat,1);
%     sumImage = zeros(numFileForSum,1);
%     
%     
%     
% %% Erase black border.   
% %
%         for p = 1:numFileForSum
%              fileName = fileDat(p,1).name;
%             im=imread(fileName);
%             imOriginal = im;
%         if size(im,3) == 3
%             im = rgb2gray(im);
%         end
%         
%         im = im2bw(im,0.2);
%         im=bwareaopen(im,200,8);
% 
%         [row,col] = size(im);
%             iflag = zeros(1,row);
%             
%             for iR =1:row
%                 if sum(im(iR,:)) > 20 
%                     iflag(iR) = 1;
%                 else
%                     iflag(iR) = 0;
%                 end
%             end
%             
%             iObjectBeginFlag = 0;
%             iObjectEndFlag = 0;
%             iObjectBegin = 1;
%             iObjectEnd = row;
%            if (max(find(iflag==1))-min(find(iflag==1)))>200
%             imC = imOriginal(min(find(iflag==1)):max(find(iflag==1)),:,:);
%             movefile(strcat(directory,'\',fileName),'C:\Users\Administrator\Desktop\RP\1');
%             imwrite(imC,strcat(fileName))
%            end
%         end

end