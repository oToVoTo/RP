% This program do extract signal object from the image.The signal object
% use to sample.

% fileFolder=fullfile('E:\Matlab³ÌÐò');
% dirOutput=dir(fullfile(fileFolder,'*.bmp'));
% 
% for i=1:2
%     
%     fileNames={dirOutput(2).name}';
%     fileFolder=fullfile('E:\Matlab³ÌÐò');
%     imshow(fileNames)
%     pause(0.5)
% end
clc
clear all
close all
im = imread('3.jpg');

imOriginal = im;

if size(im,3) == 3
    im=rgb2gray(im);
end 
im=im2bw(im);
im = bwareaopen(im,400,8);
%  imshow(im)
[row,col] = size(im);
iflag = zeros(1,row);

for i =1:row
    for j = 1:col
        if im(i,j) == 1 
            iflag(i) = 1;
            break;
        else
            iflag(i) = 0;
        end
    end
end
% 
iObjectFlag = 0;
iObjectFlag2 = 0;
iObjectBegin = 0;
iObjectEnd = 0;
t=0;
iflagRow=zeros(1,col);
%
for k = 1:row-1
    if iflag(k) == 0 && iflag(k+1) == 1 && iObjectFlag == 0
        iObjectBegin = k;
        iObjectFlag = 1;
    end
    if iflag(k) == 1 && iflag(k+1) == 0 && iObjectFlag == 1
        iObjectEnd = k;
        if(iObjectEnd-iObjectBegin>50)
            iObjectFlag = 0;
            imtemp = im(iObjectBegin:iObjectEnd,:);
            [rowtemp,coltemp] = size(imtemp);

                 for jj = 1:coltemp-1
                     for ii = 1:rowtemp-1
                        if imtemp(ii,jj) == 1 
                            iflagRow(jj) = 1;
                            break;
                        else
                            iflagRow(jj) = 0;
                        end
                     end
                 end
               for kk = 1:coltemp-1
                  if iflagRow(kk) == 0 && iflagRow(kk+1) == 1 && iObjectFlag2 == 0
                    iObjectBeginRol = kk;
                    iObjectFlag2 = 1;
                  end
                  if iflagRow(kk) == 1 && iflagRow(kk+1) == 0 && iObjectFlag2 == 1
                      iObjectEndRol = kk;
                      iObjectFlag2 = 0;
                      if iObjectEndRol-iObjectBeginRol>200
                          imsingle= imOriginal(iObjectBegin:iObjectEnd,iObjectBeginRol:iObjectEndRol,:);
                          
                          [up,down,left,right]= pure(imsingle);
                          imfinal = imsingle(up:down,left:right,:);
                          t = t+1;
                          imwrite(imfinal,strcat('E:\Matlab³ÌÐò\new\',num2str(t),'.bmp'))
                      end
                end
               end

        end
    end

end
