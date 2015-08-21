function  matchFeatureOfflineTestSmall(fileNames,refImgName,refImg,technique,normalizeFunc,featureFunc,heightMatter,keepAllFeature)
imageFilePathRef{1,1} = refImgName;
imageFilePathRef{1,2} = refImg;
nImages = (length(fileNames));

pathstr = '/Users/tanmoymondal/Documents/Study Guru/STUDY GURU/Dataset/dickDoom/CSER/testOnComponentImage/';
orgImgPath = [pathstr technique '/' normalizeFunc '/' featureFunc '/' heightMatter '/'];% the path of folder where the folders named by their refence image will be created


keepDistAllTest = zeros(nImages,1);
keepName = cell(nImages,1);
keepAllInfoRef = cell(1,7);

varName = [refImgName '_' featureFunc '_' heightMatter '_' normalizeFunc '.' 'mat'];
% load(varName);
avgHeight = keepAllFeature{1,3}(1,6);

for eachRefPath = 1:1:1
    [~,refImgName,~] = fileparts((imageFilePathRef{eachRefPath,1}));
    imageFiePath_1 = [orgImgPath refImgName '/'];
    ImgRef = imageFilePathRef{eachRefPath,2};
    if(size(ImgRef,3)==3)
        ImgRef = rgb2gray(ImgRef);
    end
    if((exist(imageFiePath_1,'dir'))==0)
        mkdir(imageFiePath_1);
    end
    ImgRef = uint8(ImgRef);
    [beforeRLSARef] = wordSpottingBasicOperationRefNoRLSA(ImgRef); % for reference image
    [l1Ref,l4Ref,topLineRef,baseLineRef,componentRefImg,ImgRef] = mainBasicFuncForRef(beforeRLSARef,ImgRef,avgHeight,normalizeFunc,heightMatter);
    
    keepAllInfoRef{eachRefPath,1} = l1Ref;
    keepAllInfoRef{eachRefPath,2} = l4Ref;
    keepAllInfoRef{eachRefPath,3} = topLineRef;
    keepAllInfoRef{eachRefPath,4} = baseLineRef;
    keepAllInfoRef{eachRefPath,5} = componentRefImg;
    keepAllInfoRef{eachRefPath,6} = ImgRef;
    keepAllInfoRef{eachRefPath,7} = imageFiePath_1;
end

parfor k = 1:(nImages)
%     if(k == 12)
%         disp('just see');
%     end
    featureMatForImage = keepAllFeature{k,1};
    realIndexMatForImage = keepAllFeature{k,2};
    l1 = keepAllFeature{k,3}(1,1);
    l4 = keepAllFeature{k,3}(1,2);
    topTest = keepAllFeature{k,3}(1,3);
    baseTest = keepAllFeature{k,3}(1,4);
    avgWidth = keepAllFeature{k,3}(1,5);
    avgHeight = keepAllFeature{k,3}(1,6);
    testImgRw = keepAllFeature{k,3}(1,7);
    testImgCol = keepAllFeature{k,3}(1,8);
    testImgPath = keepAllFeature{k,4};
    [~, testName, ~] = fileparts(testImgPath);
   
    distVal = wordSpottingBatchOperationComponentImg(featureMatForImage,realIndexMatForImage,...
        l1,l4,topTest,baseTest,testImgRw,testImgCol,keepAllInfoRef,featureFunc,normalizeFunc,...
        technique,avgWidth,avgHeight,heightMatter,testImgPath,imageFiePath_1,testName);
%      disp(k);
    keepDistAllTest(k,:) = distVal;
    keepName{k,1} = testName;
end


for eachRefImgPath = 1:1:1
    keepDist = keepDistAllTest(:,eachRefImgPath);
    refName = imageFilePathRef{eachRefImgPath,1};
    GtArray = getGT(refName);
    imageFiePath_1 = [orgImgPath refName '/'];
    
    if((exist(imageFiePath_1,'dir'))==0)
        mkdir(imageFiePath_1);
    end
    
    distanceText1 = strcat(imageFiePath_1,'distanceValue.txt');
    fid1 = fopen(distanceText1, 'wt'); %open the file
    
    for eachIm = 1:1:nImages
        fprintf(fid1,'The Distance Value of %s component is : %d \n',keepName{eachIm,1},keepDist(eachIm,1)); %write first value
    end
    fclose(fid1);
    imageFilePath_3 = [imageFiePath_1 '1st TopMost/'];
    imageFilePath_4 = [imageFiePath_1 '2nd TopMost/'];
    imageFilePath_5 = [imageFiePath_1 '3rd TopMost/'];
    imageFilePath_6 = [imageFiePath_1 '4th TopMost/'];
    
    if((exist(imageFilePath_3,'dir'))==0)
        mkdir(imageFilePath_3);
    end
    if((exist(imageFilePath_4,'dir'))==0)
        mkdir(imageFilePath_4);
    end
    if((exist(imageFilePath_5,'dir'))==0)
        mkdir(imageFilePath_5);
    end
    if((exist(imageFilePath_6,'dir'))==0)
        mkdir(imageFilePath_6);
    end
    
    
    distanceText3 = strcat(imageFilePath_3,'distanceValue.txt');
    fid3 = fopen(distanceText3, 'wt'); %open the file
    
    distanceText4 = strcat(imageFilePath_4,'distanceValue.txt');
    fid4 = fopen(distanceText4, 'wt'); %open the file
    
    distanceText5 = strcat(imageFilePath_5,'distanceValue.txt');
    fid5 = fopen(distanceText5, 'wt'); %open the file
    
    distanceText6 = strcat(imageFilePath_6,'distanceValue.txt');
    fid6 = fopen(distanceText6, 'wt'); %open the file
    
    % For removing the entries -5, we entered -5 when the component is not passing the check for size
    refinedDist = zeros(1,2);
    refinedKeepName = cell(1,1);
    prunCnt = 1;
    for removEntry = 1:1:(size(keepDist,1))
%         if(keepDist(removEntry,1) > 0)
            refinedDist(prunCnt,1) = keepDist(removEntry,1);
            refinedDist(prunCnt,2) = removEntry;
            refinedKeepName{prunCnt,1} = keepName{removEntry,1};
            prunCnt = prunCnt + 1;
%         end
    end
    
    % No need of them
    %     [~,~,refinedDist] = find(refinedDist);
    %     [~,~,refinedKeepName] = findApplicableForCell(refinedKeepName);
    
    [sortedDistMat,indx] = sort(refinedDist(:,1));
    sortedKeepName = cell( (length(indx)),1);
    for dx = 1:1:length(indx)
        sortedDistMat(dx,2) = refinedDist((indx(dx,1)),2);
        sortedKeepName{dx,1} =  refinedKeepName{indx(dx,1),1};
    end
    
    topEntries_1 = ceil(((size(sortedDistMat,1))*15)/100);
    topEntries_2 = ceil(((size(sortedDistMat,1))*30)/100);
    topEntries_3 = ceil(((size(sortedDistMat,1))*65)/100);
    
    prominentLevel1 = sortedDistMat(topEntries_1,1);
    prominentLevel2 = sortedDistMat(topEntries_2,1);
    prominentLevel3 = sortedDistMat(topEntries_3,1);
    
    m1 = 1;
    m2 = 1;
    m3 = 1;
    m4 = 1;
    
    for divInFol = 1:1:(size(sortedKeepName,1))
        distVal1 = sortedDistMat(divInFol,1);
        imgIndexOriginal = sortedDistMat(divInFol,2);
        imgName = sortedKeepName{divInFol,1};
        
        for fdNam  = 1:1:size(GtArray,2)
            namVal = GtArray(1,fdNam);
            if (strcmp(  (num2str(namVal)),imgName ) )
                GtArray (2,fdNam) = divInFol;
            end
            
        end
        %         [~,colIndex,~] = find(GtArray(1,:) == imgIndexOriginal);
        %         colIndex = colIndex';
        %         if(~isempty(colIndex))
        %             GtArray (2,colIndex) = divInFol;
        %         end
        
        if((0<= distVal1)&&(distVal1 <= prominentLevel1))
            imgSort = imread([imageFiePath_1 imgName '.jpg']);
            str1 = int2str(m1);
            imwrite(imgSort,[imageFilePath_3,str1 '_' (int2str(imgIndexOriginal)) '_' imgName '.jpg']);
            fprintf(fid3,'The Distance Value of %d component is : %d \n',m1,distVal1);
            m1 = m1+1;
        elseif ((prominentLevel1 < distVal1)&&(distVal1 <= prominentLevel2))
            imgSort = imread([imageFiePath_1 imgName '.jpg']);
            str1 = int2str(m2);
            imwrite(imgSort,[imageFilePath_4,str1 '_' (int2str(imgIndexOriginal)) '_' imgName '.jpg']);
            fprintf(fid4,'The Distance Value of %d component is : %d \n',m2,distVal1);
            m2 = m2+1;
        elseif ((prominentLevel2 < distVal1)&& (distVal1 <= prominentLevel3))
            imgSort = imread([imageFiePath_1 imgName '.jpg']);
            str1 = int2str(m3);
            imwrite(imgSort,[imageFilePath_5,str1 '_' (int2str(imgIndexOriginal)) '_' imgName '.jpg']);
            fprintf(fid5,'The Distance Value of %d component is : %d \n',m3,distVal1);
            m3 = m3+1;
        elseif (prominentLevel3 < distVal1 )
            imgSort = imread([imageFiePath_1 imgName '.jpg']);
            str1 = int2str(m4);
            imwrite(imgSort,[imageFilePath_6,str1 '_' (int2str(imgIndexOriginal)) '_' imgName '.jpg']);
            fprintf(fid6,'The Distance Value of %d component is : %d \n',m4,distVal1);
            m4 = m4+1;
        end
    end
    fclose(fid3);
    fclose(fid4);
    fclose(fid5);
    fclose(fid6);
    
    % for generating the textfile with the values of precision and recall
    PrText = strcat(imageFiePath_1,'PR_Value.txt');
    fidPR = fopen(PrText, 'wt'); %open the file
    
    resultArr = zeros((max(GtArray(2,:))),3);
    for genPR = 1:1:max(GtArray(2,:))
        % Precision Pi is defined as the number of retrieved relevant word instances divided
        % by index i, while recall Ri is defined as the number of relevant word instances divided
        % by the total number of existing relevant words in the dataset.
        noRelevantWords = find((GtArray(2,:)) <= genPR);
        calP = (length(noRelevantWords)) / genPR ;
        calR = (length(noRelevantWords)) / size(GtArray,2);
        fMeasure = (2*calP*calR)/(calP+calR);
        fprintf(fidPR,'In the Index  %d   the precision is: %d and recall is : %d and F-Measure is : %d \n',genPR,calP,calR,fMeasure);
        resultArr(genPR,1) = calP;
        resultArr(genPR,2) = calR;
        resultArr(genPR,3) = fMeasure;
    end
    fclose(fidPR);
%     figure,plot(resultArr(:,1));
%     title(refImgName)
end
return;
end