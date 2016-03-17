% This file is aim to select the bigger information frame from all
% the frames.To do this,there has three steps to do:
%
% 1、select all frames of an object.This used A、B、C status.
% 2、Delete the unsuitable frame,such as the beginning frame which has the 
%    gap.
% 3、Choose the frame which has more information to recognition.
%
% This program has specified the directory.When you want to use this program
% you should change the directory.


clc
clear all
close all
DIRETORY = 'C:\Users\Administrator\Desktop\testtemp\';
cd(DIRETORY)

% Directory
dirDat = dir([DIRETORY]);
numDir =  length(dirDat);
t = 0;

%% The Second step.
 for imkdir = 3:numDir              %From one directory to another directory
    %% Coarse earse the images.
    imkdir
    cd(strcat(DIRETORY,dirDat(imkdir).name));
    dirDat(imkdir).name
    % Image file.
    fileDat =dir(fullfile(strcat(DIRETORY,dirDat(imkdir).name),'*.jpeg'));
    numFile = size(fileDat,1)
    
    sumN = 0;
    deleteAllRetralFileFlag = false;
    
    for i = 1:numFile
        
        fileName = fileDat(i,1).name;
        im=imread(fileName);
        
        if deleteAllRetralFileFlag == true
       movefile(strcat(DIRETORY,dirDat(imkdir).name,'\',fileName),'C:\Users\Administrator\Desktop\RP\1');
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
            
          movefile(strcat(DIRETORY,dirDat(imkdir).name,'\',fileName),'C:\Users\Administrator\Desktop\RP\1');
          continue;
        end
        if min(find(sunLineHead == 0)) < (n/2) & (i < floor(numFile/2)+1)
            if exist(strcat(DIRETORY,dirDat(imkdir).name,'\',fileName),'file')
               
             movefile(strcat(DIRETORY,dirDat(imkdir).name,'\',fileName),'C:\Users\Administrator\Desktop\RP\1');
            end
        end
        if min(find(sunLineHead == 0)) < (n/2) & (i > floor(numFile/2))
            deleteAllRetralFileFlag = true;
            
            if exist(strcat(DIRETORY,dirDat(imkdir).name,'\',fileName),'file')
               
               movefile(strcat(DIRETORY,dirDat(imkdir).name,'\',fileName),'C:\Users\Administrator\Desktop\RP\1');
            end
        end      

    end
%     
%     
    fileDat =dir(fullfile(strcat(DIRETORY,dirDat(imkdir).name),'*.jpeg'));
    numFileForSum = size(fileDat,1);
    sumImage = zeros(numFileForSum,1);
    
    
    
%% Erase black border.   
%
        for p = 1:numFileForSum
             fileName = fileDat(p,1).name;
            im=imread(fileName);
            imOriginal = im;
        if size(im,3) == 3
            im = rgb2gray(im);
        end
        
        im = im2bw(im,0.2);
        im=bwareaopen(im,200,8);

        [row,col] = size(im);
            iflag = zeros(1,row);
            
            for iR =1:row
                if sum(im(iR,:)) > 20 
                    iflag(iR) = 1;
                else
                    iflag(iR) = 0;
                end
            end
            
            iObjectBeginFlag = 0;
            iObjectEndFlag = 0;
            iObjectBegin = 1;
            iObjectEnd = row;
           if (max(find(iflag==1))-min(find(iflag==1)))>200
            imC = imOriginal(min(find(iflag==1)):max(find(iflag==1)),:,:);
            movefile(strcat(DIRETORY,dirDat(imkdir).name,'\',fileName),'C:\Users\Administrator\Desktop\RP\1');
            imwrite(imC,strcat(fileName))
           end
        end
    
%% Choose the master slipped image.        
    for j = 1:numFileForSum
         fileName = fileDat(j,1).name;
        im=imread(fileName);
        
        if size(im,3) == 3
            im = rgb2gray(im);
        end        
         im = ~im2bw(im);
        sumImage(j)= sum(sum(im));
        sumN = sumN + sumImage(j);    
    end
    
    
    for k = 1:numFileForSum
        fileName = fileDat(k,1).name;
        im=imread(fileName);
        
        if size(im,3) == 3
            im = rgb2gray(im);
        end        
         im = ~im2bw(im);
         
        if sum(sum(im))< (0.2*(sumN/numFileForSum))
            %movefile(strcat(DIRETORY,dirDat(imkdir).name,'\',fileName),'C:\Users\Administrator\Desktop\RP\1');
        end    
    end
    
 end

cd(DIRETORY);

 