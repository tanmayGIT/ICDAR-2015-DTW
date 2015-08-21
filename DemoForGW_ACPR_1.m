function allResult = DemoForGW_ACPR_1(technique,per,mul)
global stroke
allFeatures = load ('ACPR_columnFeature_makeDoubleHeight_Old_Normalize.mat');

normalizeFunc = 'Old_Normalize';
heightMatter = 'makeDoubleHeight';
featureFunc = 'columnFeature';

addpath(fullfile('.','RGMesquita_CABMello','IRACE+POD_H src','POD_H'));
inputImgDir = fullfile('.','ICDAR_2015_Competetion','Valdation');

query_img_path_grey = fullfile('.','allCroppedImgOriginal','grey');
query_img_path_bin = fullfile('.','allCroppedImgOriginal','bin');

testBinImgPath = '.\allCroppedImgOriginal\bin\';
testGreyImgPath = '.\allCroppedImgOriginal\grey\';

bin_files = dir(fullfile(query_img_path_bin,'*.tif'));
bin_fileNames = {bin_files.name}';

grey_files = dir(fullfile(query_img_path_grey,'*tif'));
grey_fileNames = {grey_files.name}';
grey_nquery = length(grey_fileNames);


allFeatures = allFeatures.keepAllFeature;
% allFeatures = allFeatures.allFeatures;

keepCharCnt  = zeros(1,1);
parfor kdr = 1:size(allFeatures,1);
    testImgPath = allFeatures{kdr,4};
    
    [~, testName, extTest] = fileparts(testImgPath);
    testImgBin = imread ([testBinImgPath,testName,extTest]);
    testImgBin = imcomplement(testImgBin);
    testImgGrey = imread ([testGreyImgPath,testName,extTest]);
    if(size(testImgBin,3)==3)
        testImgBin = rgb2gray(testImgBin);
    end
    if(size(testImgGrey,3)==3)
        testImgGrey = rgb2gray(testImgGrey);
    end
    %     level = graythresh(uint8(testImgBin));
    %     testImgBin = im2bw(testImgBin,level);
    ncompTest = NumberOfCharacter(testImgGrey,testImgBin);
    keepCharCnt(kdr,1) = ncompTest;
    %         end
end
for hj  = 1:1:size(allFeatures,1)
    allFeatures{hj,5} = keepCharCnt(hj,1);
end

%% There exists 19 groups and each group contains 5 images; first of all we choose 5 group from this 19 group
% now the idea os to choose randomly 1 image from each of this 5 group
% reqImg = 5;
% chooseGrp = randperm(19,reqImg);
% learningImgIndexes = Inf(reqImg,1);
% for hu = 1:1:length(chooseGrp)
%     % for each group generate one random number between 1-5
%     oneRandNum = randperm(reqImg,1);
%
%     endGrp = chooseGrp(hu)*reqImg;
%     startGrp = (endGrp - reqImg)+1;
%     indexInGrp = ( startGrp + oneRandNum )-1;
%     while(indexInGrp == 54) % just to avoid one particular bad query image; the 54th image is bad image
%         endGrp = chooseGrp(hu)*reqImg;
%         startGrp = (endGrp - reqImg)+1;
%         indexInGrp = ( startGrp + oneRandNum )-1;
%     end
%     learningImgIndexes(hu,1) = indexInGrp;
% end
[~,makeWordCluster] = getGT_GWComplete();
for ichk = 1:length(makeWordCluster)
    [~, refname, ~] = fileparts(grey_fileNames{randRefImgIndex,1}) ;
    temImgRefGrey = imread(fullfile(query_img_path_grey,grey_fileNames{randRefImgIndex,1}));
    if(size(temImgRefGrey,3)==3)
        temImgRefGrey = rgb2gray(temImgRefGrey);
    end
    % Binary reference image reading
    temImgRefBin = imread(fullfile(query_img_path_bin,bin_fileNames{randRefImgIndex,1}));
    temImgRefBin = imcomplement(temImgRefBin);
    %     level = graythresh(int8(temImgRefBin));
    %     temImgRefBin = im2bw(temImgRefBin,level);
    if(size(temImgRefBin,3)==3)
        temImgRefBin = rgb2gray(temImgRefBin);
    end
    ncomp = NumberOfCharacter(temImgRefGrey,temImgRefBin);
    %     angle = slantDetection(temImgRefBin);
    %     if(angle > 0)
    %         [componentImgforStroke,greyStroke] = slantCorrection(temImgRefBin,temImgRefGrey,angle);
    %         [~,componentImgforStroke] =  generatePerfectBoundary(greyStroke,componentImgforStroke);
    %     end
    %     strokeWidth = averageStrokeWidth(imcomplement(componentImgforStroke));
    
    
    if(strcmpi(technique,'PDTW') ||strcmpi(technique,'PDDTW')||strcmpi(technique,'DTW_CW') )
        per = round(strokeWidth*mul);
        disp(per);
    else
        per = 0;
    end
    %         stroke = per;
    resultArrSingleQuery = matchFeatureOffline_ICDAR(allFeatures,myGT,technique,per,temImgRefBin,temImgRefGrey,refname,ncomp);
    allResult{ichk,1} = resultArrSingleQuery;
end
return;
end