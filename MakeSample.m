clc
clear all
close all
DIRETORY = 'C:\Users\Administrator\Desktop\postrain - Rp\';
cd ('C:\Users\Administrator\Desktop\postrain - Rp\East');
fileDat = dir([DIRETORY])
numFile =  length(fileDat);
imwriteT = 0;
for i = 12:numFile
    fileName = fileDat(i,1).name;
    cd (strcat(DIRETORY,fileName));
    fileDatObject = dir([strcat(DIRETORY,fileName) '\*.bmp']);
    numFileObject =  length(fileDatObject);
    for t = 1:numFileObject
            fileName1 = fileDatObject(t,1).name;
            
            im=imread(fileName1);
            im=imresize(im,6);

            imSlip = im(214:314,:,:);

         
              imwrite(imSlip,strcat(fileName1(1:end-4),'.jpg'),'jpg');
              strcat(strcat(DIRETORY,fileName),'\',fileName1)
              movefile(strcat(strcat(DIRETORY,fileName),'\',fileName1),'C:\Users\Administrator\Desktop\RP\object');
    end
end
% for i = 1 : numFile
%     fileName = fileDat(i,1).name;
%     im=imread(fileName);
%     [m,n]=size(im(:,:,1));
%     imSlip = im(30:47,:,:);
% %     imshow(imSlip)
%     imwrite(imSlip,strcat(int2str(imwriteT),'.jpeg'),'jpeg');
% %     hold on 
% %     line([1 n],[30 30],'color','r');
% %     line([1 n],[47 47],'color','r');
%     imwriteT = imwriteT + 1;
% %     pause(2)
% end