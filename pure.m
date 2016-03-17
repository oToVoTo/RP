function [up,down,left,right] = pure(im)

    if size(im,3) == 3
        im = rgb2gray(im);
    end
    im=im2bw(im);
    
    [row,col] = size(im);
    flagRow = zeros(1,row);
    flagCol = zeros(1,col);
    flagRowNum = 0;
    flagColNum = 0;
    for i = 1:row
        for j = 1:col
            if im(i,j) ==1
                flagRow(i) = 1;
                break;
            else
                flagRow(i) = 0;
            end
        end
    end

    for jj = 1:col
        for ii =1:row
            if im(ii,jj) == 1
                flagCol(jj) = 1;
                break;
            else
                flagCol(jj) = 0;
            end

        end
    end
     A=find(flagRow);

    B=find(flagCol);
    im = im(min(A):max(A),min(B):max(B));
    up =min(A);
    down=max(A);
    left=min(B);
    right=max(B);
end