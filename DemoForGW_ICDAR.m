function allResult = DemoForGW_ICDAR(technique,per,mul)
global stroke
allFeatures = load ('ICDARCompetetion_columnFeature_makeDoubleHeight_Old_Normalize.mat');

normalizeFunc = 'Old_Normalize';
heightMatter = 'makeDoubleHeight';
featureFunc = 'columnFeature';

addpath(fullfile('.','RGMesquita_CABMello','IRACE+POD_H src','POD_H'));
inputImgDir = fullfile('.','ICDAR_2015_Competetion','Valdation');

query_img_path_grey = fullfile('.','ICDAR_2015_Competetion','Valdation','Validation_QueryByExample','grey');
query_img_path_bin = fullfile('.','ICDAR_2015_Competetion','Valdation','Validation_QueryByExample','bin');

testBinImgPath = '.\ICDAR_2015_Competetion\Valdation\Validation_SegmentedWord_Images\bin\';
testGreyImgPath = '.\ICDAR_2015_Competetion\Valdation/Validation_SegmentedWord_Images\grey\';

bin_files = dir(fullfile(query_img_path_bin,'*.jpg'));
bin_fileNames = {bin_files.name}';

grey_files = dir(fullfile(query_img_path_grey,'*jpg'));
grey_fileNames = {grey_files.name}';
grey_nquery = length(grey_fileNames);


% allFeatures = allFeatures.keepAllFeature;
allFeatures = allFeatures.allFeatures;

% keepCharCnt  = zeros(1,1);
% parfor kdr = 1:size(allFeatures,1);
%     testImgPath = allFeatures{kdr,4};
%     
%     [~, testName, extTest] = fileparts(testImgPath);
%     testImgBin = imread ([testBinImgPath,testName,extTest]);
%     testImgBin = imcomplement(testImgBin);
%     testImgGrey = imread ([testGreyImgPath,testName,extTest]);
%     if(size(testImgBin,3)==3)
%         testImgBin = rgb2gray(testImgBin);
%     end
%     if(size(testImgGrey,3)==3)
%         testImgGrey = rgb2gray(testImgGrey);
%     end
%     level = graythresh(testImgBin);
%     testImgBin = im2bw(testImgBin,level);
%     ncompTest = NumberOfCharacter(testImgGrey,testImgBin);
%     keepCharCnt(kdr,1) = ncompTest;
%     %         end
% end
% for hj  = 1:1:size(allFeatures,1)
%     allFeatures{hj,5} = keepCharCnt(hj,1);
% end


% Read text file "relvance_judgement.txt"
fid = fopen(fullfile(inputImgDir,'validation_set_GT.txt'),'rt');
nLinesT1 = 0;

while (fgets(fid) ~= -1),
    nLinesT1 = nLinesT1+1;
end
fclose(fid);
[P,Q,R,S,T,U] = textread(fullfile(inputImgDir,'validation_set_GT.txt'),'%s %s %d %d %d %d',nLinesT1);
allResult = cell(1,1);


%% for calculating the intelligent jusmcosts
% distMatForEachRef = cell(1,1);
% for ichk = 1:1:2 % just do the operation of JC calculation for 2 image only
%     [~, refname, ~] = fileparts(grey_fileNames{ichk,1}) ;
%     temImgRefGrey = imread(fullfile(query_img_path_grey,grey_fileNames{ichk,1}));
%     if(size(temImgRefGrey,3)==3)
%         temImgRefGrey = rgb2gray(temImgRefGrey);
%     end
%     % Binary reference image reading
%     temImgRefBin = imread(fullfile(query_img_path_bin,bin_fileNames{ichk,1}));
%     temImgRefBin = imcomplement(temImgRefBin);
%     level = graythresh(temImgRefBin);
%     temImgRefBin = im2bw(temImgRefBin,level);
%     if(size(temImgRefBin,3)==3)
%         temImgRefBin = rgb2gray(temImgRefBin);
%     end
%
%     % ******** get the GT for this particular query image
%     storSameImgPath = cell(1,1);
%     cnt1 = 1;
%     for getSame = 1:1:(length(Q))
%         if(strcmp(refname,Q{getSame}))
%             storSameImgPath{cnt1,1} = P{getSame}; % getting the same image names
%             cnt1 = cnt1 +1;
%         end
%     end
%     wd = storSameImgPath;
%     [~,idx]=unique(wd);
%     withoutduplicatesNm = wd(idx,:);
%     % create the GT file for the comparison
%     myGT = cell(1,1);
%     for oi = 1:1:size(withoutduplicatesNm,1)
%         myGT{1,oi} = withoutduplicatesNm{oi,1};
%     end
%     %*********
%     distForEachRef = cell(1,1);
%     for eachGTgo = 1:1:2%length(myGT)
%         targetNm = myGT{1,eachGTgo};
%         gotIndex = 0;
%         for k = 1:length(allFeatures)
%             testImgPath = allFeatures{k,4};
%             for io = 1:1:length(testImgPath)% changing the path form windows style to mac style
%                 if((strcmp(testImgPath(1,io),'\') ) && (~ispc))
%                     testImgPath(1,io) = '/';
%                 end
%             end
%             [~, testName, ~] = fileparts(testImgPath);
%             if(strcmp(testName,targetNm))
%                 gotIndex = k;
%                 break;
%             end
%         end
%         targetFeature = allFeatures{gotIndex,1};
%         avgWidth = allFeatures{k,3}(1,5);
%         testImgRw = allFeatures{gotIndex,3}(1,7);
%         testImgCol = allFeatures{gotIndex,3}(1,8);
%
%         [~,~,~,~,componentRefImg,ImgRef] = mainBasicFuncForRef(temImgRefBin,temImgRefGrey,normalizeFunc,heightMatter);
%         [refComponentMat,~, ~,~] = AnalyzeComponentRefWordForWordLevel_OldICDAR...
%             (testImgRw,testImgCol,componentRefImg,ImgRef,featureFunc,avgWidth,heightMatter);
%
%         % *******************  Just Distance Calculation % **************
%         [noOfSamplesInRefSample,N] = size(refComponentMat{1,3});
%         [noOfSamplesInTestSample,M] = size(targetFeature);
%
%         Dist = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample);
%
%         for i=1:noOfSamplesInRefSample
%             for j=1:noOfSamplesInTestSample
%                 total = zeros(N,1);
%                 for goFeature = 1:N
%                     total(goFeature,1) = (double((refComponentMat{1,3}(i,goFeature)-targetFeature(j,goFeature))^2));
%                 end
%                 Dist(i,j) = sqrt(sum(total));
%             end
%         end
%         % ********************  Just Distance Calculation % **************
%         distForEachRef{eachGTgo,1} = Dist;
%     end
%     distMatForEachRef{ichk,1} = distForEachRef;
% end
% % global JC
% % global sJC
%
% [jumpcost,smalJC] =  calculateIntelligentJumpCost(distMatForEachRef);
% % JC = jumpcost;
% % sJC = smalJC;
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


shortenedGrey_nquery = [90;40;64;79;59];

for ick = 1:length(shortenedGrey_nquery)
    ichk = shortenedGrey_nquery(ick,1);
    [~, refname, ~] = fileparts(grey_fileNames{ichk,1}) ;
    temImgRefGrey = imread(fullfile(query_img_path_grey,grey_fileNames{ichk,1}));
    if(size(temImgRefGrey,3)==3)
        temImgRefGrey = rgb2gray(temImgRefGrey);
    end
    % Binary reference image reading
    temImgRefBin = imread(fullfile(query_img_path_bin,bin_fileNames{ichk,1}));
    temImgRefBin = imcomplement(temImgRefBin);
    level = graythresh(temImgRefBin);
    temImgRefBin = im2bw(temImgRefBin,level);
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
    
    storSameImgPath = cell(1,1);
    
    cnt1 = 1;
    
    for getSame = 1:1:(length(Q))
        if(strcmp(refname,Q{getSame}))
            storSameImgPath{cnt1,1} = P{getSame}; % getting the same image names
            cnt1 = cnt1 +1;
        end
    end
    
    wd = storSameImgPath;
    [~,idx]=unique(wd);
    withoutduplicatesNm = wd(idx,:);
    
    % create the GT file for the comparison
    myGT = cell(1,1);
    for oi = 1:1:size(withoutduplicatesNm,1)
        myGT{1,oi} = withoutduplicatesNm{oi,1};
    end
    
%     if(strcmpi(technique,'PDTW') ||strcmpi(technique,'PDDTW')||strcmpi(technique,'DTW_CW') )
%         per = round(strokeWidth*mul);
%         disp(per);
%     else
%         per = 0;
%     end
    %     stroke = per;
    resultArrSingleQuery = matchFeatureOffline_ICDAR(allFeatures,myGT,technique,per,temImgRefBin,temImgRefGrey,refname,ncomp);
    allResult{ick,1} = resultArrSingleQuery;
end
return;
end