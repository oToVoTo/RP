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
%
%This program is the first step.

clc
clear all
close all
DIRETORY = 'C:\Users\Administrator\Desktop\frame85\';
cd (DIRETORY)
fileDat = dir([DIRETORY '\*.jpeg']);
numFile =  length(fileDat);
t=0;
sumGrayA = zeros(numFile,1);
sumGrayB = zeros(numFile,1);
sumGrayC = zeros(numFile,1);
numObject = 0;
isA = zeros(numFile,1);
isB = zeros(numFile,1);
isC = zeros(numFile,1);
t = 0;
oddObjectBegin = false;
oddObjectEnd = false;
evenObjectBegin = false;
evenObjectEnd = false;
oddObjectHasIncrease = false;
evenObjectHasIncrease = false;
new_folder='C:\Users\Administrator\Desktop\getframe\';
frameNum =0;
oddt = 0;
event = 0;

frameBegin = 0;
frameEnd = 0;

oddImageT = 0;
evenImageT = 0;
imTemple = [];%Stroe the temple image for recongition.
imTempleForDiaplay = zeros(391,126);



for i =2:numFile
    
   
    
    fileName = fileDat(i,1).name;
    im=imread(fileName);
    % A
    imA = im(90:500,545:665,:);
    imAColor = imA;
    % B
    imB = im(270:375,1090:1230,:);
    imBColor = imB;
    % C
    imC = im(570:615,800:1050,:);
    
    imCColor = imC;
    imA = rgb2gray(imA);
    imB = rgb2gray(imB);
    imC = rgb2gray(imC);

    [mA,nA] = size(imA);
    [mB,nB] = size(imB);
    [mC,nC] = size(imC);

    sumGrayA(i) = sum(sum(imA))/(mA*nA);
    sumGrayB(i) = sum(sum(imB))/(mB*nB);
    sumGrayC(i) = sum(sum(imC))/(mC*nC);

    % A area.sumGrayA(i) > 100
    if sumGrayA(i) > 85
         isA(i) = true;
    end

    % B area.sumGrayB(i) >50
    if sumGrayB(i) >70
         isB(i) = true;
    end

    % C area.
    if sumGrayC(i) >130
         isC(i) = true;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The <odd number>object does appear.

    if  isA(i) == true && isB(i) == false &&  oddObjectEnd == false && mod(numObject,2) == 0 &&  oddObjectBegin == false
       oddObjectBegin = true;  
       numObject = numObject + 1;
       oddObjectHasIncrease = true;
       frameBegin = i;

    end

    if oddObjectHasIncrease == true
        oddImageT = oddImageT + 1;
        imTemple(:,:,:,oddImageT) = imAColor;
    end

    if evenObjectHasIncrease == true
        evenImageT = evenImageT + 1;
        imTemple(:,:,:,evenImageT) = imAColor;
    end

% The <odd number>object reach the destination.
     if isB(i-1) == false && isB(i) == true && isC(i) == true && oddObjectBegin == true && mod(numObject,2) == 1
        oddt = oddt +1;
        oddObjectEnd = true;
        oddObjectBegin = false;
        frameEnd = i;
        frameNum = frameEnd-frameBegin;    
        oddObjectHasIncrease = false;
        i-frameBegin;


      mkdir(strcat(new_folder,int2str(numObject)));
      cd(strcat(new_folder,int2str(numObject)));
      for imwriteT = 1:oddImageT-1
          if imwriteT<10
             imwrite(uint8(imTemple(:,:,:,imwriteT)),strcat('000',int2str(imwriteT),'.jpeg'),'jpeg');
          end
          if imwriteT >9 && imwriteT<100
            imwrite(uint8(imTemple(:,:,:,imwriteT)),strcat('00',int2str(imwriteT),'.jpeg'),'jpeg');
          end
          if imwriteT >99 && imwriteT<1000
            imwrite(uint8(imTemple(:,:,:,imwriteT)),strcat('0',int2str(imwriteT),'.jpeg'),'jpeg');
          end
      end
        cd(DIRETORY);
        frameBegin = 0;
        imTemple = [];
        oddImageT = 0;
     end


% The <even number>object does appear.
   % if  isA(i) == true && isB(i) == true && mod(numObject,2) == 1
    if  isA(i) == true && mod(numObject,2) == 1 && evenObjectEnd == false && oddObjectBegin == false && isB(i) == true
        
        evenObjectBegin = true;
        numObject = numObject + 1;
        frameBegin = i;
        evenObjectHasIncrease = true;
    end
    
% The <even number>object reach the destination.
    if evenObjectBegin == true && mod(numObject,2) == 0 && evenObjectEnd == false &&... 
        ((isB(i) == true && isA(i-1) == true && isA(i) == false) ||...
        (  isA(i) == true && isC(i-1) == true && isC(i) == false))
    
        event = event +1;
        evenObjectEnd = true;
        evenObjectBegin = false; 
        frameEnd = i;
        evenObjectHasIncrease = false;
        i-frameBegin;

        % Choose the even number non-obstruct object.
        if i-frameBegin < 20
%             imshow(uint8(imTemple(:,:,3)));
%             pause(3)            
        end
        if i-frameBegin > 19
%             imshow(uint8(imTemple(:,:,2)));
%             pause(3)            
        end 
        
      mkdir(strcat(new_folder,int2str(numObject)));
      cd(strcat(new_folder,int2str(numObject)));
      for imwriteT = 1:evenImageT-1
           if imwriteT<10
             imwrite(uint8(imTemple(:,:,:,imwriteT)),strcat('000',int2str(imwriteT),'.jpeg'),'jpeg');
          end
          if imwriteT >9 && imwriteT<100
            imwrite(uint8(imTemple(:,:,:,imwriteT)),strcat('00',int2str(imwriteT),'.jpeg'),'jpeg');
          end
          if imwriteT >99 && imwriteT<1000
            imwrite(uint8(imTemple(:,:,:,imwriteT)),strcat('0',int2str(imwriteT),'.jpeg'),'jpeg');
          end
         
      end
        cd(DIRETORY);
        imTemple = [];
        frameBegin = 0;
        evenImageT = 0;
     end
 

     if isC(i-1) == true && isC(i) == false 
         evenObjectEnd = false;
         oddObjectEnd =false;
     end
        
        
end


