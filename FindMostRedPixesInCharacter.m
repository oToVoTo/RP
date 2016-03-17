%This programe aims to recognition the most pixes(contain the red pixes) 
%in the image of the Character catelog.

clc
clear all
close all

DIRETORY = 'C:\Users\Administrator\Desktop\testPostive\';
DIRETORYTempImage = 'C:\Users\Administrator\Desktop\image\';

cd(DIRETORY)
numDirunRed = 0;

% Directory
dirDat = dir([DIRETORY]);
numDir =  length(dirDat);
tNumImage = 4; %Select numbers of the most pixes.

for imkdir = 3:numDir
    dirDat(imkdir).name
    cd(strcat(DIRETORY,dirDat(imkdir).name));
     fileDat =dir(fullfile(strcat(DIRETORY,dirDat(imkdir).name),'*.bmp'));
     numFile = size(fileDat,1);
     pixNum =zeros(numFile,1);
    picTemp = cell(numFile,1);
     for iDetectR = 1:numFile
        fileName = fileDat(iDetectR,1).name;
        im=imread(fileName);
%% Step 1:Find the image contain the most black pixes. 
        imCbCr=rgb2ycbcr(im);
        imCr=imCbCr(:,:,3);        
       
        imOriginal = im;
        if size(im,3) == 3
            im =rgb2gray(im);
        end
        if  ~isempty( find(imCr>140))

             pixNum(iDetectR) = sum(sum(find(imCr>140)));
             picTemp{iDetectR} = imOriginal;
        end
     end
     cd(DIRETORYTempImage)
    % mkdir(strcat(DIRETORYMAXPIXES,dirDat(imkdir).name));
     %cd(dirDat(imkdir).name)
     
     %% Step 2:Store the images in the defined directory.
    [B, IX] =  sort(pixNum);

    for i = 1:tNumImage
        imwrite(picTemp{IX(numFile-i+1)},strcat(dirDat(imkdir).name,'___',num2str(i),'.bmp'),'bmp');
    end
end
