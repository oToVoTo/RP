%This program aims to find the white margin in the middle of the image.
clc
clear all
close all
DIRETORY = 'C:\Users\Administrator\Desktop\postrain - Rp\';
cd(DIRETORY)
dirDat = dir([DIRETORY]);
numDir =  length(dirDat);

for imkdir = 3:numDir
    cd(strcat(DIRETORY,dirDat(imkdir).name));
    fileDat =dir(fullfile(strcat(DIRETORY,dirDat(imkdir).name),'*.jpeg'));
    numFile = size(fileDat,1);
    sumN = 0;
    sumImage = zeros(1,numFile);
    
    for iDetectR = 1:numFile
        
        fileName = fileDat(iDetectR,1).name;
        im=imread(fileName);
        if size(im,3) == 3
            im =rgb2gray(im);
        end
        im=~im2bw(im);
        im = bwareaopen(im,400,8);
        im= im(20:end-20,:);

        L = im;
        [m,n]=size(im);
        pixNum = sum(im);
        
        if iDetectR == 1
            pixNumBegin = sum(im,2);
%                 subplot(1,2,1)

        end

        % If there has a white margin and this margin don't locate at the 
        % begining or end of the image.
        if find(pixNum==0) & iDetectR >3 & iDetectR < numFile-3 & size(find(pixNum==0),2) >4

            if min(find(pixNum<20))>15 & max(find(pixNum<20))<n-15  
                
                sumLine= sum(im,2);
                sumLine(find(sumLine<5)) =0;
                [L,num]  = bwlabeln(sumLine, 4);
                S = regionprops(L, 'Area');
                S(1).Area;
                subplot(1,2,1)
                imshow(im)                 
                w=1:1:m;
                hold on
                subplot(1,2,2);
                plot(sumLine,w);
                
                pause(1)    
                
                numHisgram = size(S,1);
                if numHisgram >1
                    for numHisgram =1:size(S,1)-1
                       if( min(find(L == (numHisgram+1)))-max(find(L == (numHisgram))))<20
                           num = num -1;
                       end
                    end
                end

 %               
                switch num
                    case 1
                        if S(1).Area< 90
                            strcat( dirDat(imkdir).name,' is 2Bamboo')
                            
                            
                        else
                            strcat( dirDat(imkdir).name,' is 2dot')
                        end
                       break;
                       
                    case 2
                        if S(1).Area < 90 
                            pixNumBegin(find(pixNumBegin<2)) =0;
                            [L1,num1]  = bwlabeln(pixNumBegin, 4);
                            S1 = regionprops(L1, 'Area');
                numHisgram1 = size(S1,1);
                if numHisgram1 >1
                    for numHisgram1 =1:size(S1,1)-1
                       if( min(find(L1 == (numHisgram1+1)))-max(find(L1 == (numHisgram1))))<20
                           num1 = num1 -1;
                       end
                    end
                end

                            switch num1
                                case 1
                                    strcat( dirDat(imkdir).name,' is  8Bamboo')
                                    break;
                                case 2
                                    strcat( dirDat(imkdir).name,' is  4Bamboo')
                                    break;
                            end
                        else
                            strcat( dirDat(imkdir).name,' is 4dot')   
                        end
                        break;
                        
                    case 3 
                        pixNumBegin(find(sumLine<5)) =0;
                        [L2,num2]  = bwlabeln(pixNumBegin, 4);
                        S2 = regionprops(L2, 'Area');
                            switch num2
                                case 1
                                    strcat( dirDat(imkdir).name,' is  3Bamboo')
                                    break;
                                case 2
                                    strcat( dirDat(imkdir).name,' is  3Bamboo')
                                    break;
                                case 3
                                    strcat( dirDat(imkdir).name,' is  6Bamboo')
                                    break;
                                otherwise
                                    strcat( dirDat(imkdir).name,' do not know what is it£¬but it has three objection!')
                                    break;
                            end
                    otherwise
                        strcat( dirDat(imkdir).name,' do not know what is it.')
                        break;
                end;
                

               
            end
%         else
%             strcat( dirDat(imkdir).name,' is the others!') 
%             break;
        end
       
    end
end