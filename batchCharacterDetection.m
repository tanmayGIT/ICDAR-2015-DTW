clear all;
close all
clc;
addpath('.\RGMesquita_CABMello\IRACE+POD_H src\POD_H');
dirOutputSourceImgFolders = '.\ICDAR_2015_Competetion\Valdation\Validation_QueryByExample\grey\';
binPath = '.\ICDAR_2015_Competetion\Valdation\Validation_QueryByExample\bin\';

filesInFolder = dir(fullfile(dirOutputSourceImgFolders, '*.jpg'));
fileNamesInFolder = {filesInFolder.name}';
for k = 1:length(fileNamesInFolder)
    imageFilePath = [dirOutputSourceImgFolders,fileNamesInFolder{k}];
   
    ImgTest = imread(imageFilePath);
    if(size(ImgTest,3)==3)
        ImgTest = rgb2gray(ImgTest);
    end
    ImgTest = uint8(ImgTest);
    [temImgBin] = mainDP(ImgTest);
    componentImg = imcomplement(temImgBin);
    angle = slantDetection(componentImg);
    if(angle > 0)
        [componentImg,ImgTest] = slantCorrection(componentImg,ImgTest,angle);
    end
    [ImgTest,componentImg] =  generatePerfectBoundary(ImgTest,componentImg) ;
    BW2 = thinningAlgo(componentImg);
    SE = strel('square', 3); % generating a structuring element of 3*3 square
    BW2 = bwmorph(BW2,'bridge');
    BW2 = bwmorph(BW2,'fill');
    %     BW2 = bwmorph(BW2,'majority');
    BW2 = bwmorph(BW2,'clean');
    BW2 = bwmorph(BW2,'spur');
    
    keepPotentialRwIndex = zeros(1,1);
    cnt = 1;
    for jj = 1:1:size(BW2,2) % represents columns
        tempCnt = 0;
        for ii  = 1:1:size(BW2,1) % represents rows
            if(BW2(ii,jj) == 1)
               tempCnt = tempCnt +1; 
            end
        end
        if(tempCnt <= 1)
            keepPotentialRwIndex(cnt,1) = jj; % potential column candidates for the character segmentation
            cnt = cnt + 1; 
        end
    end
    % If the difference between two consecutive PSC is less than certain threshold then they are merged together
    tempAdder = keepPotentialRwIndex(1,1);
    refinedPotentialRw = zeros(1,1);
    myCnt = 1;
    dickCnt = 1;
    for t = 2:1:length(keepPotentialRwIndex)
        if( (keepPotentialRwIndex(t,1) - keepPotentialRwIndex(t-1,1)) <= 7)
            tempAdder = tempAdder + keepPotentialRwIndex(t,1);
            dickCnt = dickCnt + 1;
        else
            refinedPotentialRw(myCnt,1) = round(tempAdder/dickCnt);
            tempAdder = keepPotentialRwIndex(t,1);
            dickCnt = 1;
            myCnt  = myCnt +1;
        end
    end
    for ji = 1:1:size(refinedPotentialRw,1)
        BW2(:,refinedPotentialRw(ji,1)) = 1;
    end
    
    %     savepath = [binPath,fileNamesInFolder{k}];
    %     imwrite(temImgBin,savepath);
end
