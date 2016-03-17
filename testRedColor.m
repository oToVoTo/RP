clc
clear all
close all

DIRETORY = 'C:\Users\Administrator\Desktop\test-Rp\';
DIRETORYTempImage = 'C:\Users\Administrator\Desktop\image\';

cd(DIRETORY)
numDirunRed = 0;

% Directory
dirDat = dir([DIRETORY]);
numFile =  length(dirDat)
 fileDat =dir(fullfile(strcat(DIRETORY),'*.bmp'));


for iDetectR = 3:numFile
        fileName = fileDat(iDetectR,1).name;
        im=imread(fileName);

        im = im(:,1:end-15,:);

%% Step 1:Find the image contain the most black pixes. 
        imCbCr=rgb2ycbcr(im);
        imCr=imCbCr(:,:,3);        
       
        imOriginal = im;
        if size(im,3) == 3
            im =rgb2gray(im);
        end
        if  ~isempty( find(imCr>140))

    movefile(strcat(DIRETORY,fileDat(iDetectR,1).name),'C:\Users\Administrator\Desktop\test-Rp\Red','f')   
        end
     end
    