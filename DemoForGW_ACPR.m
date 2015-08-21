function allResult = DemoForGW_ACPR(technique,per)
addpath('.\RGMesquita_CABMello\IRACE+POD_H src\POD_H');
%%%%%%%%%%%%%%%%%  Feature Generation For Complete Dataset %%%%%%%%%%%%%%%
if(ispc)
    inputImgDir = '.\allCroppedImgOriginal\';
%     inputImgDirBin = '.\washington_good_set\Binary\';
%     inputFeatureDir = '.\washington_good_set\washington_good_set_features\';
    files = dir(fullfile(inputImgDir, '*.tif'));
    fileNames = {files.name}';
    nImagesRef = (length(fileNames));
else
    inputImgDir = './allCroppedImgOriginal/';
    inputImgDirBin = './washington_good_set/Binary/';
    inputFeatureDir = './washington_good_set/washington_good_set_features/';
    files = dir(fullfile(inputImgDir, '*.tif'));
    fileNames = {files.name}';
    nImagesRef = (length(fileNames));
end

%%.............................   Start of feature Generation  ............
% allFeatures = cell(1,1);
% for i = 1:1:nImagesRef
%     imgNm = fileNames{i,1};
%     [pathstr,refname,refext] = fileparts(imgNm);
%     temImg = imread([inputImgDir,fileNames{i,1}]);
%     justNm = str2num(refname(1,9:11));
%     featureNm = ['features_' num2str(justNm) '.dat'];
%     featureDir = [inputFeatureDir featureNm];
% %     keepAllFeature = generateFeaturemat(inputImgDir,fileNames,'Old_Normalize','columnFeature','keepOriginalHeight');
%     [f1 f2 f3 f4]= textread(featureDir, '%f %f %f %f', 'headerlines', 1);
%     tempMat = zeros(length(f1),4);
%     tempMat(:,1) = f1;
%     tempMat(:,2) = f2;
%     tempMat(:,3) = f3;
%     tempMat(:,4) = f4;
%     allFeatures{i,1} = tempMat;
% end
% save('Rath_GW_Features','allFeatures');
%%.............................   End of feature Generation  ............


%%.............................   Start of feature Generation  ............
% allFeatures = cell(1,1);
% keepName = cell(1,1);
% storRefinedBinImage = cell(1,1);
% storRefinedGreyImage = cell(1,1);
% parfor i = 1:nImagesRef
%     imgNm = fileNames{i,1};
%     temImgGrey = imread([inputImgDir,fileNames{i,1}]);
%     [temImgBin]=mainDP(temImgGrey);
%     temImgBin = imcomplement(temImgBin);
%     [refinedGreyImg,refinedBinImg] =  generatePerfectBoundary(temImgGrey,temImgBin); 
%     [refinedStorFearureMat,~] = GetFeatureOfComponentUpdated_3ExpWithSpaces(refinedBinImg,refinedGreyImg);
%     storRefinedBinImage{i,1} = refinedBinImg;
%     storRefinedGreyImage{i,1} = refinedGreyImg;
%     allFeatures{i,1} = refinedStorFearureMat;
%     keepName{i,1} = imgNm;
% %     disp(i);
% end
% save('Rath_GW_BinImageACPR','storRefinedBinImage');
% save('Rath_GW_GreyImageACPR','storRefinedGreyImage');
% save('Rath_GW_FeaturesACPR','allFeatures');
% save('Rath_GW_NamesACPR','keepName');
%%.............................   End of feature Generation  ............


allFeatures = load ('Rath_GW_FeaturesACPR.mat');

Rath_GW_BinImage = load('Rath_GW_BinImageACPR');
allBinImage = Rath_GW_BinImage.storRefinedBinImage;

Rath_GW_GreyImage = load('Rath_GW_GreyImageACPR');
allGreyImage = Rath_GW_GreyImage.storRefinedGreyImage;

keepName = load('Rath_GW_NamesACPR.mat');
keepName = keepName.keepName;

completeGT = getGT_GWComplete();
% randNum = [1633 1797 1846 54 1052 1429 781 205 206 208 248 249 713 1712];

allResult = cell(1,1);
for ichk = 1:1:nImagesRef%(length(randNum))
    [~,refname,~] = fileparts(keepName{ichk,1});
    myGT = completeGT(ichk,:);
    myGT(myGT==0) = [];
    % Binary reference image reading 
    refImgRead = allBinImage{ichk,1};
    temImgRefBin = refImgRead;
    temImgRefBin = imcomplement(temImgRefBin);
    if(size(temImgRefBin,3)==3)
        temImgRefBin = rgb2gray(temImgRefBin);
    end
    
        % Binary reference image reading 
    testImgRead = allGreyImage{ichk,1};
    temImgRefGrey = testImgRead;
    if(size(temImgRefGrey,3)==3)
        temImgRefGrey = rgb2gray(temImgRefGrey);
    end
    
    ncomp = NumberOfCharacter(temImgRefGrey,temImgRefBin);
    angle = slantDetection(temImgRefBin);
    if(angle > 0)
        [componentImgforStroke,greyStroke] = slantCorrection(temImgRefBin,temImgRefGrey,angle);
        [~,componentImgforStroke] =  generatePerfectBoundary(greyStroke,componentImgforStroke);
    end
    strokeWidth = averageStrokeWidth(componentImgforStroke);
    % figure,imshow(testImgRead);
   
    if(strcmpi(technique,'PDTW') ||strcmpi(technique,'PDDTW')||strcmpi(technique,'DTW_CW') )
        per = 3*strokeWidth;
    end
    resultArrSingleQuery = matchFeatureOffline_ICDAR(allFeatures,myGT,technique,per,temImgRefBin,temImgRefGrey,refname,ncomp);
    allResult{ick,1} = resultArrSingleQuery;
end
return;
end