clc
clear all
close all
DIRETORY = 'C:\Users\Administrator\Desktop\testRP\';
cd(DIRETORY)

% Directory
dirDat = dir([DIRETORY]);
numDir =  length(dirDat);
t = 0;

for imkdir = 1:numDir
    cd(strcat(DIRETORY,dirDat(imkdir).name));
    % Image file.
    fileDat =dir(fullfile(strcat(DIRETORY,dirDat(imkdir).name),'*.jpeg'));
    numFile = size(fileDat,1);
    for i = 1:numFile
        fileName = fileDat(i,1).name;
        im=imread(fileName);
        
        % Recongition Red color.
        im=rgb2ycbcr(im);
        imCr=im(:,:,3);
        %If there has red color in the image of the object.
        if  ~isempty( find(imCr>150))
            strcat(DIRETORY,dirDat(imkdir).name)
            break;
        end
    end
end






















% for imkdir = 1:numDir
%     %% Coarse earse the images.
%     cd(strcat(DIRETORY,dirDat(imkdir).name));
%     % Image file.
%     fileDat =dir(fullfile(strcat(DIRETORY,dirDat(imkdir).name),'*.jpeg'));
%     numFile = size(fileDat,1);
%     
%     sumN = 0;
%     deleteAllRetralFileFlag = false;
%     
%     for i = 1:numFile
%         
%         fileName = fileDat(i,1).name;
%         im=imread(fileName);
%         
%         if deleteAllRetralFileFlag == true
%             %movefile(strcat(DIRETORY,dirDat(imkdir).name,'\',fileName),'C:\Users\Administrator\Desktop\RP\1');
%             continue;
%         end
%        
%         if size(im,3) == 3
%             im = rgb2gray(im);
%         end
%         
%         im = im2bw(im);
% %         imshow(im)
% %         pause(0.2)
%         [m,n] = size(im);
%         sumLineTail = sum(im(floor(end/2):end,:));
%         sunLineHead = sum(im(1:floor(end/2),:));
%         
% %         max(find(sumLine == 0))
% 
%         if max(find(sumLineTail == 0)) > (n/2)
%            %movefile(strcat(DIRETORY,dirDat(imkdir).name,'\',fileName),'C:\Users\Administrator\Desktop\RP\1');
%         end
%         
%         if min(find(sunLineHead == 0)) < (n/2)
%             deleteAllRetralFileFlag = true;
%             if exist(strcat(DIRETORY,dirDat(imkdir).name,'\',fileName),'file')
%                
%                % movefile(strcat(DIRETORY,dirDat(imkdir).name,'\',fileName),'C:\Users\Administrator\Desktop\RP\1');
%             end
%         end      
% 
%     end
% %     
% %     
%     fileDat =dir(fullfile(strcat(DIRETORY,dirDat(imkdir).name),'*.jpeg'));
%     numFileForSum = size(fileDat,1);
%     sumImage = zeros(numFileForSum,1);
%     
%     
%     
% %% Erase black border.   
% %
% %         for p = 1:numFileForSum
% %              fileName = fileDat(p,1).name;
% %             im=imread(fileName);
% %             imOriginal = im;
% %         if size(im,3) == 3
% %             im = rgb2gray(im);
% %         end
% %         
% %         im = im2bw(im);
% %         [row,col] = size(im);
% %             iflag = zeros(1,row);
% %             
% %             for iR =1:row
% %                 for jR = 1:col
% %                     if im(iR,jR) == 1 
% %                         iflag(iR) = 1;
% %                         break;
% %                     else
% %                         iflag(iR) = 0;
% %                     end
% %                 end
% %             end
% %             
% %             iObjectBeginFlag = 0;
% %             iObjectEndFlag = 0;
% %             iObjectBegin = 1;
% %             iObjectEnd = row;
% %            if (max(find(iflag==1))-min(find(iflag==1)))>300
% %             imC = imOriginal(min(find(iflag==1)):max(find(iflag==1)),:,:);
% %             movefile(strcat(DIRETORY,dirDat(imkdir).name,'\',fileName),'C:\Users\Administrator\Desktop\RP\1');
% %             imwrite(imC,strcat(fileName))
% %            end
% %         end
%     
% %% Choose the master slipped image.        
%     for j = 1:numFileForSum
%          fileName = fileDat(j,1).name;
%         im=imread(fileName);
%         
%         if size(im,3) == 3
%             im = rgb2gray(im);
%         end        
%          im = ~im2bw(im);
%         sumImage(j)= sum(sum(im));
%         sumN = sumN + sumImage(j);    
%     end
%     
%     
%     for k = 1:numFileForSum
%         fileName = fileDat(k,1).name;
%         im=imread(fileName);
%         
%         if size(im,3) == 3
%             im = rgb2gray(im);
%         end        
%          im = ~im2bw(im);
%          
%         if sum(sum(im))< (0.7*(sumN/numFileForSum))
%             movefile(strcat(DIRETORY,dirDat(imkdir).name,'\',fileName),'C:\Users\Administrator\Desktop\RP\1');
%         end    
%     end
%     
% end


 














































% sumN = 0
% sumImage = zeros(1,numFile);
% % Project method.
% for i = 1 :  numFile
%     tic
%     fileName = fileDat(i,1).name;
%     im=imread(fileName);
% 
% %     pause(0.3)
%     if size(im,3) == 3
%         im = rgb2gray(im);
%     end
%     im = im2bw(im);
%      imshow(im)
% %    pause(0.3)
%     [m,n] = size(im);
%     sumLine = sum(im);
%     if sumLine(end-2:end) < 50
%         fileName;
%     end
%     if sumLine(1:5) < 100
%         'begin:'
%         fileName;
%     end
%     sumImage(i)= sum(sum(im));
%    sumN = sumN + sum(sum(im));
% %     h=zeros(1,m);    
% %     for i=1:m
% %        for j=1:n
% %           h(i)=h(i)+double(im(i,j));
% %        end
% %     end %进行行投影
% %     
% %     w=zeros(1,n);
% %     for j=1:n
% %           for i=1:m
% %               w(j)=w(j)+double(im(i,j));DIRETORY
% %           end
% %       end %进行列投影
% %           w=1:1:m;
% %         figure
% %         plot(w,h);
%          
%   toc
% end
% 
% for i = 1:numFile
%     if sumImage(i)< (sumN/numFile)
%         i
%     end
% end



% %Find red feature.I think this is a reliable feature.
% for i = 1 : numFile
%     tic
%     fileName = fileDat(i,1).name;
%     im=imread(fileName);
% %     imshow(im)
% %     pause(0.3)
%     im=rgb2ycbcr(im);
%     imCr=im(:,:,3);
%   if  ~isempty( find(imCr>150))
%              movefile(fileName,'C:\Users\Administrator\Desktop\RP\red');
%        
%            fileName;
%            t = t+1;
%   end
%   toc
% end