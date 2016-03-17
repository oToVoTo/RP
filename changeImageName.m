%Change file name.
clc
clear all
close all
DIRETORY = 'E:\‘≠ º ”∆µ\';
cd(DIRETORY)
dirDat = dir([DIRETORY]);
numDir =  length(dirDat);
for imkdir = 3:numDir 
   imkdir
    cd(strcat(DIRETORY,dirDat(imkdir).name));
        fileDat =dir(fullfile(strcat(DIRETORY,dirDat(imkdir).name),'*.bmp'));
    numFile = size(fileDat,1);
     for i = 1:numFile
          fileName = fileDat(i,1).name;
          file = fileName(1:end-4);
          if str2num(file)<10
              reNameFile = strcat('0000',num2str(file));
              reNameFile = strcat(reNameFile,'.bmp');
              eval(['!rename' strcat(',',fileName)  strcat(',',reNameFile)]);
          end
          if  str2num(file)>9 &  str2num(file)<100
              reNameFile = strcat('000',num2str(file));
                            reNameFile = strcat(reNameFile,'.bmp');
              eval(['!rename' strcat(',',fileName)  strcat(',',reNameFile)]);
          end
          if  str2num(file)>99 &  str2num(file)<1000
              reNameFile = strcat('00',num2str(file));
                            reNameFile = strcat(reNameFile,'.bmp');
              eval(['!rename' strcat(',',fileName)  strcat(',',reNameFile)]);
          end
          if  str2num(file)>999 &  str2num(file)<10000
              reNameFile = strcat('0',num2str(file));
                            reNameFile = strcat(reNameFile,'.bmp');
              eval(['!rename' strcat(',',fileName)  strcat(',',reNameFile)]);
          end
          
     end
end