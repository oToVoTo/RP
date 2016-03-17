function  image = FindMostBlackPixForCheckResult(directory)
    cd(directory);
    fileDat =dir(fullfile(directory,'*.jpeg'));
    numFile = size(fileDat,1);
    pixNum =zeros(numFile,1);
    picTemp = cell(numFile,1);
    tNumImage = 1;
    for i = 1:numFile
        fileName = fileDat(i,1).name;
        im=imread(fileName);

        % Find the image contain the most black pixes. 
        imCbCr=rgb2ycbcr(im);
        imCr=imCbCr(:,:,3);        
       
        imOriginal = im;
        if size(im,3) == 3
            im =rgb2gray(im);
        end
        if  isempty( find(imCr>140))
            im=~im2bw(im,0.27);
            im = bwareaopen(im,400,8);
             pixNum(i) = sum(sum(im));
             picTemp{i} = imOriginal;
        end
    end
    
    [B, IX] =  sort(pixNum);
    
        for t = 1:tNumImage
        if ~isempty( picTemp{IX(numFile-t+1)}) 
            image = picTemp{IX(numFile-t+1)};
            %imwrite(picTemp{IX(numFile-t+1)},strcat(num2str(t),'.jpeg'),'jpeg');
        end
    end
    image = picTemp{IX(numFile)};
end