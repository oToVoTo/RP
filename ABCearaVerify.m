clc
clear all
close all
DIRETORY = 'C:\Users\Administrator\Desktop\frame85\';
cd (DIRETORY)
fileDat = dir([DIRETORY '\*.jpeg'])
numFile =  length(fileDat);
t=0;
sumGray=zeros(numFile,3);
for i = 50:numFile

    fileName = fileDat(i,1).name;
    im=imread(fileName);
      imshow(im)
%     
%     
%     
%      hold on
line([545 665],[90 90],'color','r');
line([545 665],[500 500],'color','r');
line([545 545],[90 500],'color','r');
line([665 665],[90 500],'color','r');
 pause(0.001)
 hold on
line([1130 1250],[270 270],'color','r');
line([1130 1250],[375 375],'color','r');
line([1130 1130],[270 375],'color','r');
line([1250 1250],[270 375],'color','r');
pause(0.01)
hold on
line([850 1050],[570 570],'color','r');
line([850 1050],[615 615],'color','r');
line([850 850],[570 615],'color','r');
line([1050 1050],[570 615],'color','r');
pause(0.01)
hold off
% A
 imA = im(50:460,559:679,:);

% B
 imB = im(270:375,1090:1230,:);

% C
 imC=im(570:615,800:1050,:);


%  figure
%  imshow(im(:,:,1))
%  figure
%  imshow(im(:,:,2))
%  figure
%   imshow(im(:,:,3))
 imA = rgb2gray(imA);
 imB = rgb2gray(imB);
 imC = rgb2gray(imC);
% % im= im2bw(im,0.5);
% % imshow(im)
% % pause(0.1)
% 
 [mA,nA] = size(imA);
 [mB,nB] = size(imB);
 [mC,nC] = size(imC);
% 
 sumGray(i,1) = sum(sum(imA))/(mA*nA);
 sumGray(i,2) = sum(sum(imB))/(mB*nB);
 sumGray(i,3) = sum(sum(imC))/(mC*nC);
% cd('C:\Users\Administrator\Desktop\RP');

% A area.
% if sumGray(i) >100
%       movefile(fileName,'C:\Users\Administrator\Desktop\testRP\object');
% end


% B area.
% if sumGray(i) >90
%      movefile(fileName,'C:\Users\Administrator\Desktop\testRP\object');
% end



% C area.
% if sumGray(i) >140
%      movefile(fileName,'C:\Users\Administrator\Desktop\testRP\object');
% end


% %imshow(im)

end
%im = im2bw(im,0.3);
