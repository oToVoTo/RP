% This program aims to deal with classify the Character catalog.

clc
clear all
close all

DIRETORY = 'C:\Users\Administrator\Desktop\postrain - Rp\';
cd(DIRETORY)
numDirunRed = 0;

% Directory
dirDat = dir([DIRETORY]);
numDir =  length(dirDat);
t = 0;
numMostPixes = 4
 %% Step1:find the image contain the most red pixes.
%  for imkdir = 3:numDir
%     
%     cd(strcat(DIRETORY,dirDat(imkdir).name));
%     dirName = dirDat(imkdir).name;
%     %Image file
%     fileDat =dir(fullfile(strcat(DIRETORY,dirDat(imkdir).name),'*.jpeg'));
%     numFile = size(fileDat,1);
%     nameFile = '';
%     redPixsSum = 0;
%     numRedFrame = 0;
%     for i = 1:numFile
%         fileName = fileDat(i,1).name;
%         im=imread(fileName);
%         
%         % Recongition Red color.
%         im=rgb2ycbcr(im);
%         imCr=im(:,:,3);
%         %If there has red color in the image of the object.
%         
%         if  ~isempty( find(imCr>150))
% 
%             if redPixsSum <size(find(imCr>150),1)
%                redPixsSum = size(find(imCr>150),1);
%               % nameFile = strcat(strcat(redDIRCTORY,dirDat(imkdir).name),'\',fileName);
%               nameFile = fileName;
%             end
%                numRedFrame = numRedFrame + 1;
%                continue;
%         end
%     end
%     strcat((strcat(DIRETORY,dirDat(imkdir).name)),'\',nameFile)
%     
%     copyfile(nameFile,'C:\Users\Administrator\Desktop\MaxRedImage')
%     cd ('C:\Users\Administrator\Desktop\MaxRedImage')
%     system(['rename'  ' ' nameFile  ' ' strcat(dirName,'.jpeg')])
%  end
 
%% Step2: find the image contain the most black pixes.
 for imkdir = 3:numDir
    
    cd(strcat(DIRETORY,dirDat(imkdir).name));
    dirName = dirDat(imkdir).name;
    %Image file
    fileDat =dir(fullfile(strcat(DIRETORY,dirDat(imkdir).name),'*.jpeg'));
    numFile = size(fileDat,1);
    nameFile = '';
    blackPixsSum = 0;
    numBlackFrame = 0;
    for i = 1:numFile
        fileName = fileDat(i,1).name;
        im=imread(fileName);

        % Recongition Red color.
        imCbCr=rgb2ycbcr(im);
        imCr=imCbCr(:,:,3);
        
        if size(im,3) == 3
            im = rgb2gray(im);
        end
        imBW = im2bw(im);

        if  isempty( find(imCr>150))
            
        size(find(imBW == 1),1)
%         imshow(imBW)
%         pause(1)
        
            if blackPixsSum <size(find(imBW == 1),1)
               blackPixsSum = size(find(imBW == 1),1);
              % nameFile = strcat(strcat(redDIRCTORY,dirDat(imkdir).name),'\',fileName);
              nameFile = fileName;
            end
               numBlackFrame = numBlackFrame + 1;
               continue;
        end
    end
    
    strcat((strcat(DIRETORY,dirDat(imkdir).name)),'\',nameFile);
    t = t+1;
    copyfile(nameFile,'C:\Users\Administrator\Desktop\MaxRedImage');
    cd ('C:\Users\Administrator\Desktop\MaxRedImage')
    system(['rename'  ' ' nameFile  ' ' strcat(int2str(t),'.jpeg')])
 end