function resultArr  = matchFeatureOffline_ICDAR_ACPR(keepAllFeature,myGT,technique,percent,temImgRefBin,temImgRefGrey,refname,ncomp)
% keepAllFeature = keepAllFeature.keepAllFeature;
[beforeRLSARef] = temImgRefBin;
normalizeFunc = 'Old_Normalize';
heightMatter = 'makeDoubleHeight';
featureFunc = 'columnFeature';
if(ispc)
    imageFiePath_1 = ['.\ICDAR_2015_Competetion\' refname '\'];
else
    imageFiePath_1 = ['./ICDAR_2015_Competetion/' refname '/'];
end
if((exist(imageFiePath_1,'dir'))==0)
    mkdir(imageFiePath_1);
end
[l1Ref,l4Ref,topLineRef,baseLineRef,componentRefImg,ImgRef] = mainBasicFuncForRef(beforeRLSARef,temImgRefGrey,normalizeFunc,heightMatter);

keepAllInfoRef{1,1} = l1Ref;
keepAllInfoRef{1,2} = l4Ref;
keepAllInfoRef{1,3} = topLineRef;
keepAllInfoRef{1,4} = baseLineRef;
keepAllInfoRef{1,5} = componentRefImg;
keepAllInfoRef{1,6} = ImgRef;
keepAllInfoRef{1,7} = imageFiePath_1;
nImages = size(keepAllFeature,1);


avgWidth = keepAllFeature{1,3}(1,5);
testImgRw = keepAllFeature{1,3}(1,7);
testImgCol = keepAllFeature{1,3}(1,8);

[refComponentMat,realRWRef, realColRef,nForeGdPixelsRef] = AnalyzeComponentRefWordForWordLevel_OldICDAR(testImgRw,testImgCol,componentRefImg,ImgRef,featureFunc,avgWidth,heightMatter);

beta = 2;
sigma = 2;
alfa = 2;
zeta = 2;

level1 = cell(1,1); cnt1 = 1;
level2 = cell(1,1); cnt2 = 1;
level3 = cell(1,1); cnt3 = 1;
keepDistAllTest = cell(nImages,1);
keepName = cell(nImages,1);
parfor k = 1:nImages
    
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
    realRwTest = keepAllFeature{k,3}(1,9);
    realColTest = keepAllFeature{k,3}(1,10);
    nofForeGdPixelsTest = keepAllFeature{k,3}(1,11);
    testImgPath = keepAllFeature{k,4};
    
    ncompTest = keepAllFeature{k,5};
    [~, testName, ~] = fileparts(testImgPath);
    if ( ((1/alfa) <=( (realColRef/realRWRef)  / (realColTest/realRwTest) )  ) ...
            && ( ( (realColRef/realRWRef)  / (realColTest/realRwTest) ) < alfa  ) )
%         level1 {cnt1,1} = testName; cnt1 = cnt1 + 1;
        if (     (( (1/sigma) <=( (realRWRef * realColRef)  / (realColTest * realRwTest) ) ) && ...
                ( ( (realRWRef * realColRef)  / (realColTest * realRwTest) ) < sigma  ) )  || ...
                ( ((1/zeta) <= (ncompTest/ncomp) ) && ( (ncompTest/ncomp) < zeta)) || ...
                (( (1/beta) <=(nForeGdPixelsRef / nofForeGdPixelsTest)  ) && ...
                ( (nForeGdPixelsRef / nofForeGdPixelsTest) < beta  ) ) )
%             level3 {cnt3,1} = testName; cnt3 = cnt3 + 1;
            distVal = wordSpottingBatchOperationComponentImgICDAR(featureMatForImage,realIndexMatForImage,...
                            l1,l4,topTest,baseTest,testImgRw,testImgCol,keepAllInfoRef,featureFunc,normalizeFunc,...
                            technique,avgWidth,avgHeight,heightMatter,testImgPath,imageFiePath_1,testName,percent,refComponentMat);
            keepDistAllTest{k,1} = distVal;
%         else
%             keepDistAllTest(k,1) = -5;
        end
%     else
%         keepDistAllTest(k,1) = -5;
    end
    keepName{k,1} = testName;
end


% [hitted1,missed1,totalGT] = calculateHitMissACPR(myGT,level1);
% if(missed1 >0)
%     fprintf('The missed elements after level1 is: %d out of %d; whereas total considered prunned elements %d out of total %d\n',missed1,totalGT,length(level1),nImages);
% end
%
% [hitted2,missed2,totalGT] = calculateHitMiss(myGT,level2);
% fprintf('The missed elements after level2 is: %d out of %d; whereas total considered prunned elements %d out of total %d\n',missed2,totalGT,length(level2),nImages);

% [hitted3,missed3,totalGT] = calculateHitMissACPR(myGT,level3);
% if(missed3 >0)
%     fprintf('The missed elements after level3 is: %d out of %d;  whereas total considered prunned elements %d out of total %d\n\n\n',missed3,totalGT,length(level3),nImages);
% end


keepDistAllTest_ = zeros(1,1);
keepName_ = cell(1,1);
cnt11 = 1;
for iu = 1:1:size(keepDistAllTest,1)
    if(~isempty(keepDistAllTest{iu,1}))
        if( keepDistAllTest{iu,1} ~= -5) 
            keepDistAllTest_(cnt11,1) = keepDistAllTest{iu,1};
            keepName_{cnt11,1} = keepName{iu,1};
            cnt11 = cnt11 + 1;
        end
    end
end
keepDistAllTest = keepDistAllTest_;
keepName = keepName_;
for eachRefImgPath = 1:1:1
    keepDist = keepDistAllTest(:,eachRefImgPath);
    refName = refname;
    
    if(ispc)
        imageFiePath_1 = ['.\ICDAR_2015_Competetion\', refName '\'];
    else
        imageFiePath_1 = ['./ICDAR_2015_Competetion/', refName '/'];
    end
    if((exist(imageFiePath_1,'dir'))==0)
        mkdir(imageFiePath_1);
    end
    
    distanceText1 = strcat(imageFiePath_1,'distanceValue.txt');
    fid1 = fopen(distanceText1, 'wt'); %open the file
    
    for eachIm = 1:1:size(keepName,1)
        fprintf(fid1,'The Distance Value of %s component is : %d \n',keepName{eachIm,1},keepDist(eachIm,1)); %write first value
    end
    fclose(fid1);
    if(ispc)
        imageFilePath_3 = [imageFiePath_1 '1st TopMost\'];
        imageFilePath_4 = [imageFiePath_1 '2nd TopMost\'];
        imageFilePath_5 = [imageFiePath_1 '3rd TopMost\'];
        imageFilePath_6 = [imageFiePath_1 '4th TopMost\'];
    else
        imageFilePath_3 = [imageFiePath_1 '1st TopMost/'];
        imageFilePath_4 = [imageFiePath_1 '2nd TopMost/'];
        imageFilePath_5 = [imageFiePath_1 '3rd TopMost/'];
        imageFilePath_6 = [imageFiePath_1 '4th TopMost/'];
    end
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
        refinedDist(prunCnt,1) = keepDist(removEntry,1);
        refinedDist(prunCnt,2) = removEntry;
        refinedKeepName{prunCnt,1} = keepName{removEntry,1};
        prunCnt = prunCnt + 1;
    end
    
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
    
    GtArray = myGT;
    keepNmPosition = cell(3,(size(GtArray,2)));
    GTmatchFlag = 0;
    gtCnt = 1;
    myPath = 0;
    GtArray_backing = zeros(1,1);
    for divInFol = 1:1:(size(sortedKeepName,1))
        distVal1 = sortedDistMat(divInFol,1);
        imgIndexOriginal = sortedDistMat(divInFol,2);
        imgName = sortedKeepName{divInFol,1};
        
        for fdNam  = 1:1:size(GtArray,2)
            namVal = GtArray{1,fdNam};
            if (strcmp( namVal,imgName ) )
                GtArray {2,fdNam} = divInFol;
                GtArray_backing(1,fdNam) = divInFol;
                GTmatchFlag = 1;
                break;
            end
            
        end
        %         [~,colIndex,~] = find(GtArray(1,:) == imgIndexOriginal);
        %         colIndex = colIndex';
        %         if(~isempty(colIndex))
        %             GtArray (2,colIndex) = divInFol;
        %         end
        
        if((0<= distVal1)&&(distVal1 <= prominentLevel1))
            %             imgSort = imread([imageFiePath_1 imgName '.jpg']);
            str1 = int2str(m1);
            %             imwrite(imgSort,[imageFilePath_3,str1 '_' (int2str(imgIndexOriginal)) '_' imgName '.jpg']);
            myPath = '1st folder';
            %             fprintf(fid3,'The Distance Value of %d component is : %d \n',m1,distVal1);
            m1 = m1+1;
        elseif ((prominentLevel1 < distVal1)&&(distVal1 <= prominentLevel2))
            %             imgSort = imread([imageFiePath_1 imgName '.jpg']);
            str1 = int2str(m2);
            %             imwrite(imgSort,[imageFilePath_4,str1 '_' (int2str(imgIndexOriginal)) '_' imgName '.jpg']);
            myPath = '2nd folder';
            %             fprintf(fid4,'The Distance Value of %d component is : %d \n',m2,distVal1);
            m2 = m2+1;
        elseif ((prominentLevel2 < distVal1)&& (distVal1 <= prominentLevel3))
            %             imgSort = imread([imageFiePath_1 imgName '.jpg']);
            str1 = int2str(m3);
            %             imwrite(imgSort,[imageFilePath_5,str1 '_' (int2str(imgIndexOriginal)) '_' imgName '.jpg']);
            myPath = '3rd folder';
            %             fprintf(fid5,'The Distance Value of %d component is : %d \n',m3,distVal1);
            m3 = m3+1;
        elseif (prominentLevel3 < distVal1 )
            %             imgSort = imread([imageFiePath_1 imgName '.jpg']);
            str1 = int2str(m4);
            %             imwrite(imgSort,[imageFilePath_6,str1 '_' (int2str(imgIndexOriginal)) '_' imgName '.jpg']);
            myPath = '4th folder';
            %             fprintf(fid6,'The Distance Value of %d component is : %d \n',m4,distVal1);
            m4 = m4+1;
        end
        if(GTmatchFlag == 1)
            keepNmPosition{1,gtCnt} = myPath;
            keepNmPosition{2,gtCnt} = str1;%(int2str(imgIndexOriginal));
            keepNmPosition{3,gtCnt} = imgName;
            gtCnt = gtCnt +1;
            GTmatchFlag = 0;
        end
    end
    fclose(fid3);
    fclose(fid4);
    fclose(fid5);
    fclose(fid6);
    
    % for generating the textfile with the values of precision and recall
    PrText = strcat(imageFiePath_1,'PR_Value.txt');
    fidPR = fopen(PrText, 'wt'); %open the file
    
    resultArr = cell((max(GtArray_backing(1,:))),4);
    for genPR = 1:1:max(GtArray_backing(1,:))
        % Precision Pi is defined as the number of retrieved relevant word instances divided
        % by index i, while recall Ri is defined as the number of relevant word instances divided
        % by the total number of existing relevant words in the dataset.
        noRelevantWords = find((GtArray_backing(1,:)) <= genPR);
        calP = (length(noRelevantWords)) / genPR ;
        calR = (length(noRelevantWords)) / size(GtArray,2);
        fMeasure = (2*calP*calR)/(calP+calR);
        %         fprintf(fidPR,'In the Index  %d   the precision is: %d and recall is : %d and F-Measure is : %d \n',genPR,calP,calR,fMeasure);
        resultArr{genPR,1} = calP;
        resultArr{genPR,2} = calR;
        resultArr{genPR,3} = fMeasure;
    end
    resultArr{1,4} = keepNmPosition;
    resultArr{1,5} = sortedDistMat;
    resultArr{1,6} = sortedKeepName;
    resultArr{1,7} = GtArray;
    fclose(fidPR);
    %     figure,plot(resultArr(:,1));
    %     title(refImgName)
end
return;
end