%This programe aims to recognition the East、West、South、North、fa.

clc
clear all
close all

DIRETORY = 'C:\Users\Administrator\Desktop\postrain - Rp\testEastat\';
DIRETORYTempImage = 'C:\Users\Administrator\Desktop\image\';

cd(DIRETORY)
numDirunRed = 0;

% Directory
dirDat = dir([DIRETORY]);
numDir =  length(dirDat);
tNumImage = 6; %Select numbers of the most pixes.

for imkdir = 3:3
    cd(strcat(DIRETORY,dirDat(imkdir).name));
     fileDat =dir(fullfile(strcat(DIRETORY,dirDat(imkdir).name),'*.jpeg'));
     numFile = size(fileDat,1);
     pixNum =zeros(numFile,1);
    picTemp = cell(numFile,1);
     for iDetectR = 1:numFile
        fileName = fileDat(iDetectR,1).name;
        im=imread(fileName);
        
        %% Step 1:Find the image contain the most pixes.
        imOriginal = im;
        if size(im,3) == 3
            im =rgb2gray(im);
        end
        
        im=~im2bw(im);
        im = bwareaopen(im,400,8);
        im= im(20:end-20,:);
         pixNum(iDetectR) = sum(sum(im));
         picTemp{iDetectR} = imOriginal;
     end
     cd(DIRETORYTempImage)
    % mkdir(strcat(DIRETORYMAXPIXES,dirDat(imkdir).name));
     %cd(dirDat(imkdir).name)
     
     %% Step 2:Store the images in the defined directory.
    [B, IX] =  sort(pixNum);
    IX(numFile-2)
    IX(numFile-1)
    IX(numFile)
    for i = 1:tNumImage
        imwrite(picTemp{IX(numFile-i+1)},strcat(dirDat(imkdir).name,'___',num2str(i),'.jpeg'),'jpeg');
    end
    
    %% Step 3: Extract the hog feature of the images
    fntest = dir(fullfile(DIRETORYTempImage , '*.jpeg'));
    testnum = size(fntest,1)
    inametest= cell(testnum ,1);
    tt = 0;
    HOGtest = [];
    for t= 1:testnum
      tt=tt+1;
      str = ['Do hog at pic: ' num2str(tt) '...'];
      disp(str);
      inametest{t} = fntest(t).name;
      testpic= imread( inametest{t});
      testpic = imrotate(testpic,90);
      I= imResample(single(rotateim(imread( inametest{t}))),[121 350])/255;  
       % Hog detection.
           for p = 1:125, H=hog(I,8,9); end; 
           HOGtestr = [ ];
            for ix = 1:size(H,1)
                for j = 1:size(H,2)
                     for k = 1:size(H,3)/4
                        HOGtestr =[HOGtestr H(ix,j,k)];
                     end
                end
            end
               HOGtest = [HOGtest;HOGtestr];

      y = inametest{t};
      if strcmp(y(1), 'a')==1 ==1
       Labeltest(t,:) = 1;
      else  Labeltest(t,:) = -1;
      end 
    end 
    testfile='comtest.mat';
    cd('C:\Users\Administrator\Desktop\HOG-LBPdetection-Rp')
    save(testfile,'HOGtest','Labeltest','inametest','testnum');
    %% Step 4: Extract the hog feature of the images
    cd('C:\Users\Administrator\Desktop\HOG-LBPdetection-Rp')
    dirtraindata = 'C:\Users\Administrator\Desktop\HOG-LBPdetection-Rp\featuredata';
    traindata = dir(fullfile(dirtraindata , '*.mat'));
    traindatatypenum = size(traindata,1);
    traindataname = cell(traindatatypenum,1);
    
    new_folder='C:\Users\Administrator\Desktop\image\'
    for imkdir = 1:traindatatypenum
        traindataname{imkdir} = traindata(imkdir).name;
        traindataname{imkdir} = traindataname{imkdir}(1:end-4);
        strcat(new_folder,traindataname{imkdir});
        mkdir(strcat(new_folder,traindataname{imkdir}));
    end
     load comtest.mat
     HOGtest = double(HOGtest);
         p = 0;
      model_linear = [];
      dec_values = zeros(testnum,traindatatypenum);
      traindatanamemat = cell(traindatatypenum,1);
    for i = 1:traindatatypenum
        traindatanamemat{i} = traindata(i).name;
        datafile = strcat(dirtraindata,'\',traindatanamemat{i});
        load (datafile);
        train_data(1:size(HOGpostr,1),:) = HOGpostr(:,:);
        train_data(size(HOGpostr,1)+1:size(HOGpostr,1)+size(HOGnegtrResult,1),:) = HOGnegtrResult(:,:);
        train_data = double(train_data);
        train_label(1:size(Labelpostr,1),:) = 1;
        train_label(size(Labelpostr,1)+1:size(HOGpostr,1)+size(HOGnegtrResult,1),:) = -1;
       model = svmtrain(train_label, train_data, '-t 0');

       model_linear = [model_linear;model];
       
       for ii = 1:size(model_linear)
         model = model_linear(ii);
         [predict_label_L, accuracy_L, dec_values_L] = svmpredict(Labeltest, HOGtest, model);
         dec_values(:,ii) = dec_values_L;
       end
       
        cd(DIRETORYTempImage)
       for p = 1:testnum
            [C,I]=max(dec_values(p,:));
         if C>0.9
             filename = inametest(p);
            % movefile(filename{1},traindataname{I});
            dirDat(imkdir).name
            traindataname{I}
         end
       end
    %   
    %    
    %    
     end
end
