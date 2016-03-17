% This program extract the singal object from the pictures in a directory
% that has many objects.When I want to make samples for feature extraction 
% and classification,use this program is convenient.
%
% NOTE:This program may not suitable for you.For more details,you can read
% README.txt file.
%
% Email: 42453807@qq.com
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% log:
% 2015-11-23: Complete.
% 2012-11-23: Modify the description and comments.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clc
clear all
close all
DIRETORY = 'C:\Users\Administrator\Desktop\RP\13';
cd (DIRETORY)
fileDat = dir([DIRETORY '\*.jpeg']);
numFile =  length(fileDat);
tFileName = 0;

for i = 1:numFile
    tFileName= tFileName +1;
    fileName = fileDat(i,1).name;
    im=imread(fileName);
    im=im(:,:,:);
    imOriginal = im;

if size(im,3) == 3
    im=rgb2gray(im);
end 
im=im2bw(im);
im = bwareaopen(im,400,8);
[rowIm,colIm] = size(im);
iFlagImPixisChangedInRowArray = zeros(1,rowIm);

for i =1:rowIm
    for j = 1:colIm
        if im(i,j) == 1 
            iFlagImPixisChangedInRowArray(i) = 1;
            break;
        else
            iFlagImPixisChangedInRowArray(i) = 0;
        end
    end
end

iFlagObjectIsFound = 0;
 iFlagImPixisChangedInColArray = 0;
iBeginPerRow = 0;
iEndPerRow = 0;
t=0;
iflagRow=zeros(1,rowIm);
%**************************************************************************
%**************************************************************************
for k = 1:rowIm-1
    
    % The pix has changed from 0 to 1,and iFlagObjectIsFound equal 0,then
    % this situation shows that a object is coming.
    if k<40 || k> 350
    
     isChanged01 = iFlagImPixisChangedInRowArray(k) == 0 &&...
                iFlagImPixisChangedInRowArray(k+1) == 1;
    if isChanged01 && ~iFlagObjectIsFound 
        iBeginPerRow = k;
        iFlagObjectIsFound = 1;
    end
    % The pix has changed from 1 to 0,and iFlagObjectIsFound equal 1,then
    % this situation shows that a object is gone.
    isChanged10 = iFlagImPixisChangedInRowArray(k) == 1 &&...
                  iFlagImPixisChangedInRowArray(k+1) == 0;
    if isChanged10 && iFlagObjectIsFound 
        iEndPerRow = k;
        if(iEndPerRow-iBeginPerRow>30)
            
            iFlagObjectIsFound = 0;
            imTemp = im(iBeginPerRow:iEndPerRow,:);
            imTempColor = imOriginal(iBeginPerRow:iEndPerRow,:,:);
            [rowImTemp,colImTemp] = size(imTemp);
            imwrite(imTempColor,strcat('E:\Matlab³ÌÐò\new\pp\',num2str(tFileName),'.jpeg'))
                 for jj = 1:colImTemp-1
                     for ii = 1:rowImTemp-1
                        if imTemp(ii,jj) == 1 
                            iflagRow(jj) = 1;
                            break;
                        else
                            iflagRow(jj) = 0;
                        end
                     end
                 end
                 iObjectFlag2 =0;
               for kk = 1:colImTemp-2
                  if iflagRow(kk) == 0 && iflagRow(kk+1) == 1 && iObjectFlag2 == 0
                    iObjectBeginRol = kk;
                    iObjectFlag2 = 1;
                  end
                  if iflagRow(kk) == 1 && iflagRow(kk+1) == 0 && iObjectFlag2 == 1
                      iObjectEndRol = kk;
                      iObjectFlag2 = 0;
                      if iObjectEndRol-iObjectBeginRol>1
                          imsingle= imOriginal(iBeginPerRow:iEndPerRow,iObjectBeginRol:iObjectEndRol,:);
                          
                          [up,down,left,right]= pure(imsingle);
                          imfinal = imsingle(up:down,left:right,:); 
                           imshow(imfinal);
%                            pause(0.1)
%                           t = t+1;
                         % imwrite(imfinal,strcat('E:\Matlab³ÌÐò\new\pp\',num2str(tFileName),num2str(t),'.jpeg'))
                      end
                end
               end %afasdfasd

        end%adfasdf
    end%adfadf
    end
end
end