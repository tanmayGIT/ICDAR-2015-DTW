function allResult = DemoForGW(technique,per)
addpath('.\RGMesquita_CABMello\IRACE+POD_H src\POD_H');
%%%%%%%%%%%%%%%%%  Feature Generation For Complete Dataset %%%%%%%%%%%%%%%
if(ispc)
    inputImgDir = '.\washington_good_set\';
    inputImgDirBin = '.\washington_good_set\Binary\';
    inputFeatureDir = '.\washington_good_set\washington_good_set_features\';
    files = dir(fullfile(inputImgDir, '*.tif'));
    fileNames = {files.name}';
    nImagesRef = (length(fileNames));
else
    inputImgDir = './washington_good_set/';
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
allFeatures = cell(1,1);
keepName = cell(1,1);
storRefinedBinImage = cell(1,1);
storRefinedGreyImage = cell(1,1);
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
%     disp(i);
% end
% save('Rath_GW_BinImage','storRefinedBinImage');
% save('Rath_GW_GreyImage','storRefinedGreyImage');
% save('Rath_GW_Features','allFeatures');
% save('Rath_GW_Names','keepName');
%%.............................   End of feature Generation  ............


allFeatures = load ('Rath_GW_Features.mat');

Rath_GW_BinImage = load('Rath_GW_BinImage');
allBinImage = Rath_GW_BinImage.storRefinedBinImage;

Rath_GW_GreyImage = load('Rath_GW_GreyImage');
allGreyImage = Rath_GW_GreyImage.storRefinedGreyImage;

keepName = load('Rath_GW_Names.mat');
keepName = keepName.keepName;

%generateExcelFilesForFeatures(allFeatures.allFeatures,keepName);

% Read text file "relvance_judgement.txt"
fid = fopen([inputImgDir,'relevance_judgment.txt'],'rt');
nLinesT1 = 0;

while (fgets(fid) ~= -1),
    nLinesT1 = nLinesT1+1;
end
fclose(fid);
[P,Q,R,S] = textread([inputImgDir,'relevance_judgment.txt'],'%d %s %d %d',nLinesT1);


%Read text line "testsuite_images.txt"
fid = fopen([inputImgDir,'testsuite_images.txt'],'rt');
nLinesT2 = 0;

while (fgets(fid) ~= -1),
    nLinesT2 = nLinesT2+1;
end
[A] = textread([inputImgDir,'testsuite_images.txt'],'%s',nLinesT2);
fclose(fid);

randNum = [1633 1797 1846 54 1052 1429 781 205 206 208 248 249 713 1712];

allResult = cell(1,1);
for ichk = 1:1:(length(randNum))
    refimgPath = A{(randNum(1,ichk)),1} ;
    [~, refname, ~] = fileparts(refimgPath) ;
    
    % Binary reference image reading 
    refImgRead = allBinImage{(randNum(1,ichk)),1};
    temImgRefBin = refImgRead;
    temImgRefBin = imcomplement(temImgRefBin);
    if(size(temImgRefBin,3)==3)
        temImgRefBin = rgb2gray(temImgRefBin);
    end
    strokeWidth = averageStrokeWidth(temImgRefBin);
    % figure,imshow(testImgRead);
    
    refimgIndex = getIndexOfImage(refname,A);
    storSameImgPath = cell(1,1);
    storMyIndex = zeros(1,1);
    indx1 = find(P == refimgIndex);
    indx2 = find(R == refimgIndex);
    cnt1 = 1;
    if(~isempty(indx1))
        for getSame = 1:1:(length(indx1))
            sameImageName = A{(R((indx1(getSame,1)),1)),1};
            fullImagePath = sameImageName;
            storSameImgPath{cnt1,1} = fullImagePath;
            storMyIndex(cnt1,1) = R((indx1(getSame,1)),1);
            % imwrite(sameImg,[imageFolder_1,(int2str(getSame)) '.jpg']);
            cnt1 = cnt1 +1;
        end
    end
    if(~isempty(indx2))
        for getSame = 1:1:(length(indx2))
            sameImageName = A{P((indx2(getSame,1)),1),1};
            fullImagePath = sameImageName;
            storSameImgPath{cnt1,1} = fullImagePath;
            storMyIndex(cnt1,1) = P(indx2(getSame,1));
            %             imwrite(sameImg,[imageFolder_1,(int2str(getSame)) '.jpg']);
            cnt1 = cnt1 +1;
        end
    end
    wd = storSameImgPath;
    [~,idx]=unique(wd,'rows');
    withoutduplicatesNm = wd(idx,:);
    withoutduplicatesIndex = storMyIndex(idx,:);
    
    % create the GT file for the comparison
    myGT = cell(1,1);
    for oi = 1:1:size(withoutduplicatesNm,1)
        myGT{1,oi} = withoutduplicatesNm{oi,1};
        myGT{4,oi} = withoutduplicatesIndex(oi,1);
    end
    fileNamesInFolder = keepName;
    if(strcmpi(technique,'PDTW') ||strcmpi(technique,'PDDTW')||strcmpi(technique,'DTW_CW') )
        per = 3*strokeWidth;
    end
    resultArrSingleQuery = matchFeatureOffline_DAS_GW(allFeatures,fileNamesInFolder,refimgIndex,refname,myGT,technique,per,allBinImage);
    allResult{ichk,1} = resultArrSingleQuery;
end
return;
end