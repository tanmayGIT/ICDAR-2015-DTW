function allResult = DemoForGW_ACPR_2(technique,per,mul,makeWordCluster)
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


% allFeatures = allFeatures.keepAllFeature;
allFeatures = allFeatures.allFeatures;

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

for ichk = 1:length(makeWordCluster) % run for all the reference image 
    randRefImgIndex = makeWordCluster{ichk,1};
    myGT =  makeWordCluster{ichk,2};
    [~, refname, ~] = fileparts(grey_fileNames{randRefImgIndex,1}) ;
    temImgRefGrey = imread(fullfile(query_img_path_grey,grey_fileNames{randRefImgIndex,1}));
    if(size(temImgRefGrey,3)==3)
        temImgRefGrey = rgb2gray(temImgRefGrey);
    end
%     figure,imshow(temImgRefGrey);
    fullGTName = cell(1,1);
    for hyy = 1:1:length(myGT)
        temImgGTGrey = (fullfile(query_img_path_grey,grey_fileNames{myGT(hyy),1}));
        [~,nameOnly,~] = fileparts(temImgGTGrey);
        fullGTName{hyy,1} = nameOnly;
%         figure,imshow(temImgGTGrey);
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
    resultArrSingleQuery = matchFeatureOffline_ICDAR_ACPR(allFeatures,fullGTName,technique,per,temImgRefBin,temImgRefGrey,refname,ncomp);
    allResult{ichk,1} = resultArrSingleQuery;
end
return;
end