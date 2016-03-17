% This program is the main program of the project in this company.The
% program combine many programs in the same
% directory:C:\Users\Administrator\Desktop\RP.

clc
clear all
close all

DIRETORY = 'C:\Users\Administrator\Desktop\postrain - Rp\';
cd(DIRETORY)
numDirunRed = 0;

% Directory
dirDat = dir([DIRETORY]);
numDir =  length(dirDat);
t = 0;

% %% STEP1: Find red object and store it in the Red directory.
% for imkdir = 3:numDir
%     cd(strcat(DIRETORY,dirDat(imkdir).name));
%     % Image file.
%     fileDat =dir(fullfile(strcat(DIRETORY,dirDat(imkdir).name),'*.jpeg'));
%     numFile = size(fileDat,1);
%     for i = 1:numFile
%         fileName = fileDat(i,1).name;
%         im=imread(fileName);
%         
%         % Recongition Red color.
%         im=rgb2ycbcr(im);
%         imCr=im(:,:,3);
%         %If there has red color in the image of the object.
%         if  ~isempty( find(imCr>150))
%             cd(DIRETORY) 
%             
%              movefile(strcat(DIRETORY,dirDat(imkdir).name),'C:\Users\Administrator\Desktop\postrain - Rp\Red');
%             break;  
%         end
%     end
% end
% 
% cd(DIRETORY) 
% movefile('C:\Users\Administrator\Desktop\postrain - Rp\Red','C:\Users\Administrator\Desktop','f')
% movefile('C:\Users\Administrator\Desktop\postrain - Rp\*','C:\Users\Administrator\Desktop\Others','f')
% movefile('C:\Users\Administrator\Desktop\Others','C:\Users\Administrator\Desktop\postrain - Rp\','f')
% movefile('C:\Users\Administrator\Desktop\Red','C:\Users\Administrator\Desktop\postrain - Rp\','f')

%% STEP2:Classify the unRed category. 
unRedDIRETORY = 'C:\Users\Administrator\Desktop\postrain - Rp\Others\';
cd(unRedDIRETORY)
dirDat = dir([unRedDIRETORY]);
numDirunRed =  length(dirDat);
for imkdir = 3:numDirunRed
    cd(strcat(unRedDIRETORY,dirDat(imkdir).name));
    fileDat =dir(fullfile(strcat(unRedDIRETORY,dirDat(imkdir).name),'*.jpeg'));
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
        end

        % If there has a white margin and this margin don't locate at the 
        % begining or end of the image.
        if find(pixNum==0) & iDetectR >3 & iDetectR < numFile-3 & size(find(pixNum==0),2) >4

            if min(find(pixNum<20))>15 & max(find(pixNum<20))<n-15  

                sumLine= sum(im,2);
                sumLine(find(sumLine<5)) =0;
                [L,num]  = bwlabeln(sumLine, 4);
                S = regionprops(L, 'Area'); 
                
                numHisgram = size(S,1);
                if numHisgram >1
                    for numHisgram =1:size(S,1)-1
                       if( min(find(L == (numHisgram+1)))-max(find(L == (numHisgram))))<20
                           num = num -1;
                       end
                    end
                end
                
                switch num
                    case 1
                        if S(1).Area< 90
                            cd (unRedDIRETORY);
                            if exist(strcat(unRedDIRETORY,'Bamboo2'))
                                movefile(strcat(unRedDIRETORY,dirDat(imkdir).name),strcat(unRedDIRETORY,'Bamboo2'),'f')
                                %strcat( dirDat(imkdir).name,' is 2Bamboo')
                            else
                                mkdir(strcat(unRedDIRETORY,'Bamboo2'));
                                movefile(strcat(unRedDIRETORY,dirDat(imkdir).name),strcat(unRedDIRETORY,'Bamboo2'),'f')
                            end
                            
                        else
                            if exist(strcat(unRedDIRETORY,'dot2'))
                                movefile(strcat(unRedDIRETORY,dirDat(imkdir).name),strcat(unRedDIRETORY,'dot2'),'f')
                                %strcat( dirDat(imkdir).name,' is 2dot')
                            else
                                mkdir(strcat(unRedDIRETORY,'dot2'));
                                movefile(strcat(unRedDIRETORY,dirDat(imkdir).name),strcat(unRedDIRETORY,'dot2'),'f')
                            end   
                        end
                       break;
                       
                    case 2
                        if S(1).Area < 90 
                            %pixNumBegin(find(sumLine<5)) =0;
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
                                     if exist(strcat(unRedDIRETORY,'Bamboo8'))
                                        movefile(strcat(unRedDIRETORY,dirDat(imkdir).name),strcat(unRedDIRETORY,'Bamboo8'),'f')
                                    else
                                        mkdir(strcat(unRedDIRETORY,'Bamboo8'));
                                        movefile(strcat(unRedDIRETORY,dirDat(imkdir).name),strcat(unRedDIRETORY,'Bamboo8'),'f')
                                    end   
                                    %strcat( dirDat(imkdir).name,' is  8Bamboo')
                                    break;
                                case 2
                                    if exist(strcat(unRedDIRETORY,'Bamboo4'))
                                        movefile(strcat(unRedDIRETORY,dirDat(imkdir).name),strcat(unRedDIRETORY,'Bamboo4'),'f')
                                    else
                                        mkdir(strcat(unRedDIRETORY,'Bamboo4'));
                                        movefile(strcat(unRedDIRETORY,dirDat(imkdir).name),strcat(unRedDIRETORY,'Bamboo4'),'f')
                                    end                                   
                                    %strcat( dirDat(imkdir).name,' is  4Bamboo')
                                    break;
                            end
                        else
                                     if exist(strcat(unRedDIRETORY,'dot4'))
                                        movefile(strcat(unRedDIRETORY,dirDat(imkdir).name),strcat(unRedDIRETORY,'dot4'),'f')
                                    else
                                        mkdir(strcat(unRedDIRETORY,'dot4'));
                                        movefile(strcat(unRedDIRETORY,dirDat(imkdir).name),strcat(unRedDIRETORY,'dot4'),'f')
                                    end    
                            %strcat( dirDat(imkdir).name,' is 4dot')   
                        end
                        break;
                        
                    case 3 
                        pixNumBegin(find(sumLine<5)) =0;
                        [L2,num2]  = bwlabeln(pixNumBegin, 4);
                        S2 = regionprops(L2, 'Area');
                            switch num2
                                case 1
                                    if exist(strcat(unRedDIRETORY,'Bamboo3'))
                                        movefile(strcat(unRedDIRETORY,dirDat(imkdir).name),strcat(unRedDIRETORY,'Bamboo3'),'f')
                                    else
                                        mkdir(strcat(unRedDIRETORY,'Bamboo3'));
                                        movefile(strcat(unRedDIRETORY,dirDat(imkdir).name),strcat(unRedDIRETORY,'Bamboo3'),'f')
                                     end    
                                    
                                    %strcat( dirDat(imkdir).name,' is  3Bamboo')
                                    break;
                                case 2
                                    if exist(strcat(unRedDIRETORY,'Bamboo3'))
                                        movefile(strcat(unRedDIRETORY,dirDat(imkdir).name),strcat(unRedDIRETORY,'Bamboo3'),'f')
                                    else
                                        mkdir(strcat(unRedDIRETORY,'Bamboo3'));
                                        movefile(strcat(unRedDIRETORY,dirDat(imkdir).name),strcat(unRedDIRETORY,'Bamboo3'),'f')
                                     end    
                                    %strcat( dirDat(imkdir).name,' is  3Bamboo')
                                    break;
                                case 3
                                     if exist(strcat(unRedDIRETORY,'Bamboo6'))
                                        movefile(strcat(unRedDIRETORY,dirDat(imkdir).name),strcat(unRedDIRETORY,'Bamboo6'),'f')
                                    else
                                        mkdir(strcat(unRedDIRETORY,'Bamboo6'));
                                        movefile(strcat(unRedDIRETORY,dirDat(imkdir).name),strcat(unRedDIRETORY,'Bamboo6'),'f')
                                     end    
                                    %strcat( dirDat(imkdir).name,' is  6Bamboo')
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
%             if exist(strcat(unRedDIRETORY,'unclassify'))
%                 
%                  movefile(strcat(unRedDIRETORY,dirDat(imkdir).name),strcat(unRedDIRETORY,'unclassify'),'f')
%             else
%                 mkdir(strcat(unRedDIRETORY,'unclassify'));
%                 movefile(strcat(unRedDIRETORY,dirDat(imkdir).name),strcat(unRedDIRETORY,'unclassify'),'f')
%                 strcat( dirDat(imkdir).name,' is the others!') ;
                
%             end
            
        end
       % Here remain the 7 categrays:East West South North fa White
       % Dot8.Use the svm to classify the 7 categrays.
    end
end

 %% STEP3:Classify the Red category. 
% redDIRCTORY = 'C:\Users\Administrator\Desktop\postrain - Rp\Red\';
% cd(redDIRCTORY)
% dirDat = dir([redDIRCTORY]);
% numDir =  length(dirDat);
% 
% % % 1¡¢Classify the Character cateloge
% % % Method:choose the biggest redPixsSum in every object to classify.
% % 
% % for imkdir = 3:numDir
% %     
% %     cd(strcat(redDIRCTORY,dirDat(imkdir).name));
% %     dirName = dirDat(imkdir).name;
% %     %Image file
% %     fileDat =dir(fullfile(strcat(redDIRCTORY,dirDat(imkdir).name),'*.jpeg'));
% %     numFile = size(fileDat,1);
% %     nameFile = '';
% %     redPixsSum = 0;
% %     numRedFrame = 0;
% %     for i = 1:numFile
% %         fileName = fileDat(i,1).name;
% %         im=imread(fileName);
% %         
% %         % Recongition Red color.
% %         im=rgb2ycbcr(im);
% %         imCr=im(:,:,3);
% %         %If there has red color in the image of the object.
% %         
% %         if  ~isempty( find(imCr>150))
% % 
% %             if redPixsSum <size(find(imCr>150),1)
% %                redPixsSum = size(find(imCr>150),1);
% %               % nameFile = strcat(strcat(redDIRCTORY,dirDat(imkdir).name),'\',fileName);
% %               nameFile = fileName;
% %             end
% %                numRedFrame = numRedFrame + 1;
% %                continue;
% %         end
% %     end
% %    copyfile(nameFile,'C:\Users\Administrator\Desktop\test')
% %    cd('C:\Users\Administrator\Desktop\test')
% %    
% %     movefile( nameFile,strcat(dirName,'.jpeg'));
% %     
% % end
























% % 2¡¢Recongition Bamboo1.
% % Method:Count red pixs.The Bamboo1 has least pix number.
% 
%  for imkdir = 3:numDir
%     cd(strcat(redDIRCTORY,dirDat(imkdir).name));
%     % Image file.
%     fileDat =dir(fullfile(strcat(redDIRCTORY,dirDat(imkdir).name),'*.jpeg'));
%     numFile = size(fileDat,1);
%     redPixsSum= 0;
%     numRedFrame = 0;
%     redLocationMin = 0;
%     redLocationMax = 0;
%     for i = 1:numFile
%         fileName = fileDat(i,1).name;
%         im=imread(fileName);
%         
%         % Recongition Red color.
%         im=rgb2ycbcr(im);
%         imCr=im(:,:,3);
%         %If there has red color in the image of the object.
%         
%         if  ~isempty( find(imCr>150))
%                
%             if redPixsSum <size(find(imCr>150),1)
%                redPixsSum = size(find(imCr>150),1);
%             end
%                numRedFrame = numRedFrame + 1;
%              continue;
%         end
%     end
%       if numRedFrame == numFile
%         strcat(DIRETORY,dirDat(imkdir).name)
%             find(imCr>150)
%             redPixsSum
%             numRedFrame
% %         if sumRedPix > 0 & sumRedPix <10000
% %             'This is 9 bamboo'
% %         else
% %             'this is middle!'
% %         end
%       end
%      if redPixsSum<1000
%         strcat(redDIRCTORY,dirDat(imkdir).name,'red pixs is: ',num2str(redPixsSum),'so,it is Bamboo1')
%      end
% end
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
