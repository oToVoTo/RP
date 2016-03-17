% This program is recognition the 9 bamboo and the middle.
clc
clear all
close all
DIRETORY = 'C:\Users\Administrator\Desktop\postrain - Rp\';
cd(DIRETORY)
tic
% Directory
dirDat = dir([DIRETORY]);
numDir =  length(dirDat);
t = 0;
tic
for imkdir = 3:numDir
    DetectRed = false;
    numRedFrame = 0;
    cd(strcat(DIRETORY,dirDat(imkdir).name));
    % Image file.
    fileDat =dir(fullfile(strcat(DIRETORY,dirDat(imkdir).name),'*.jpeg'));
    numFile = size(fileDat,1);
    sumRedPix = 0;
    for iDetectR = 1:numFile-5
        fileName = fileDat(iDetectR,1).name;
        im=imread(fileName);
        
        % Recongition Red color.
        im=rgb2ycbcr(im);
        imCr = im(:,:,3);
%         imshow(imCr)
%         pause(0.001)
        %If there has red color in the image of the object.
            if  ~isempty( find(imCr>150))
                    if sumRedPix <size(find(imCr>150),1)
                        sumRedPix = size(find(imCr>150),1);

                    end
                    DetectRed = true;
                    numRedFrame = numRedFrame + 1;
                    continue;
            end
            
    end
    if numRedFrame == numFile
        strcat(DIRETORY,dirDat(imkdir).name)
            
        if sumRedPix > 0 & sumRedPix <10000
            'This is 9 bamboo'
        else
            'this is middle!'
        end
     end
end
toc