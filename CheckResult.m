% This programe aims to detect the result of classify.Because check the
% result cost much time.
%
clc
clear all
close all
HOME='C:\Users\Administrator\Desktop\RP';
DIRETORY = 'D:\testtemp\';
RESULTDIR = 'C:\Users\Administrator\Desktop\testPostive\';
cd(DIRETORY)
dirDat = dir([DIRETORY]);
numDir =  length(dirDat);

t = 0;
for imkdir = 3:numDir
    imkdir
    %cd(strcat(DIRETORY,dirDat(imkdir).name));
    dirDat(imkdir).name
    % Image file.
    fileDat =dir(fullfile(strcat(DIRETORY,dirDat(imkdir).name)))
    numFile = size(fileDat,1);
    cd(RESULTDIR)
     mkdir(strcat(dirDat(imkdir).name));
     for dir = 3:numFile
         fileNameDisposeFrame = fileDat(dir,1).name;
         directoryDisposeFrame = strcat(strcat(DIRETORY,dirDat(imkdir).name,'\'),fileNameDisposeFrame);
         cd(HOME)
         DisposeFrame(directoryDisposeFrame);
     end
    for i = 3:numFile

            fileName = fileDat(i,1).name;
            directory = strcat(strcat(DIRETORY,dirDat(imkdir).name,'\'),fileName);
            cd(HOME)
            im = FindMostBlackPixForCheckResult(directory);
            
            cd(strcat(RESULTDIR,dirDat(imkdir).name))
            if ~isempty(im)
                imwrite(im,strcat(fileName,'.jpeg'),'jpeg');
            else
                strcat('OPPS!The directory do not have unred image: ',directory)
            end
    end

    end
   cd(HOME)

