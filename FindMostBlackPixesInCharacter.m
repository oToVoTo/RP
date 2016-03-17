%This programe aims to recognition the most pixes(not contain the red pixes) 
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
tNumImage = 3; %Select numbers of the most pixes.

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
        %im = im(:,1:end-15,:);
%% Step 1:Find the image contain the most black pixes. 
        imCbCr=rgb2ycbcr(im);
        imCr=imCbCr(:,:,3);        
       
        imOriginal = im;
        if size(im,3) == 3
            im =rgb2gray(im);
        end
        if  isempty( find(imCr>140))
            im=~im2bw(im,0.27);
%             imshow(im)
%             pause(0.5)
            im = bwareaopen(im,400,8);
            im= im(20:end-20,:);
             pixNum(iDetectR) = sum(sum(im));
             picTemp{iDetectR} = imOriginal;
        end
     end
     cd(DIRETORYTempImage)
    % mkdir(strcat(DIRETORYMAXPIXES,dirDat(imkdir).name));
     %cd(dirDat(imkdir).name)
     
     %% Step 2:Store the images in the defined directory.
    [B, IX] =  sort(pixNum);

    for i = 1:tNumImage
        if ~isempty(picTemp{IX(numFile-i+1)})
            imwrite(picTemp{IX(numFile-i+1)},strcat(dirDat(imkdir).name,'___',num2str(i),'.jpeg'),'jpeg');
        end
    end
end
