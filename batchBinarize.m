clear all;
close all
clc;
addpath('.\RGMesquita_CABMello\IRACE+POD_H src\POD_H');
dirOutputSourceImgFolders = 'C:\Users\21209993t\Documents\wordSpotting\trunk\GW_Full_Images\grey\';
binPath = 'C:\Users\21209993t\Documents\wordSpotting\trunk\GW_Full_Images\bin\';

filesInFolder = dir(fullfile(dirOutputSourceImgFolders, '*.tif'));
fileNamesInFolder = {filesInFolder.name}';
for k = 1:length(fileNamesInFolder)
    imageFilePath = [dirOutputSourceImgFolders,fileNamesInFolder{k}];
    
    ImgTest = imread(imageFilePath);
    if(size(ImgTest,3)==3)
        ImgTest = rgb2gray(ImgTest);
    end
    ImgTest = uint8(ImgTest);
    [temImgBin] = mainDP(ImgTest);
%     componentImg = imcomplement(temImgBin);
    savepath = [binPath,fileNamesInFolder{k}];
    imwrite(temImgBin,savepath);
end
