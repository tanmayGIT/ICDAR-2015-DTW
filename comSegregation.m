close all;
clear all;
clc;

imgPath = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/testOnFullImage/AllComponentImagesGrey/';
comImgFolder = '/Volumes/Macintosh_HD_2/Word Spotting Dataset/Dataset_CESR/Grouped_Images_3/comImgCollection/';
filesInFolder = dir(fullfile(imgPath, '*.jpg'));
fileNamesInFolder = {filesInFolder.name}';
nImages = (length(fileNamesInFolder));
for k = 1:(nImages)
    imageFilePath = [imgPath,fileNamesInFolder{k}];
    img = imread(imageFilePath);
    if(size(img,3)==3)
        img = rgb2gray(img);
    end
    [~, testImgName, ~] = fileparts(imageFilePath);
    imgNm = [];
    folderNm = [];
    iGotFlg = 0;
    for chr = 1:1:length(testImgName)
        if(testImgName(1,chr) == '#')
            iGotFlg = 1;
        else
            if(iGotFlg == 0)
                imgNm = [imgNm,testImgName(1,chr)];
            elseif(iGotFlg == 1)
                folderNm = [folderNm,testImgName(1,chr)];
            end
        end
        
    end
    componentImgSavinigPath_Full = [comImgFolder folderNm '/'];
    if((exist(componentImgSavinigPath_Full,'dir'))==0)
        mkdir(componentImgSavinigPath_Full);
%     else
%         rmdir(componentImgSavinigPath_Full,'s'); % If the directory is already exist then first remove it then make new
%         mkdir(componentImgSavinigPath_Full);
    end
    imgSavingPath = [componentImgSavinigPath_Full imgNm '.jpg'];
    imwrite(img,imgSavingPath);
end