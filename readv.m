clc
clear all
close all
%[filename,pathname,fileindex]=uigetfile('*.avi','��ѡ��һ��Avi�ļ�');

xyloObj = VideoReader('C:\Users\Administrator\Desktop\test\IMG_0263.MOV')

nFrames = xyloObj.NumberOfFrames
vidHeight = xyloObj.Height;
vidWidth = xyloObj.Width;

% Preallocate movie structure.
mov(1:nFrames) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []);

%Read one frame at a time.
for k = 1 :3: nFrames
    mov(k).cdata = read(xyloObj, k);
     if k<10
        imwrite(mov(k).cdata,strcat('0000',int2str(k),'.jpeg'),'jpeg');%��ÿ֡ͼ�����Ӳ��
    elseif k>=10 & k<100
        imwrite(mov(k).cdata,strcat('000',int2str(k),'.jpeg'),'jpeg');%��ÿ֡ͼ�����Ӳ��
    elseif k>=100 & k<1000
        imwrite(mov(k).cdata,strcat('00',int2str(k),'.jpeg'),'jpeg');%��ÿ֡ͼ�����Ӳ��
    elseif k>=1000 & k<1000
        imwrite(mov(k).cdata,strcat('0',int2str(k),'.jpeg'),'jpeg');%��ÿ֡ͼ�����Ӳ��  
    else
        imwrite(mov(k).cdata,strcat(int2str(k),'.jpeg'),'jpeg');%��ÿ֡ͼ�����Ӳ��
        
    end
end


