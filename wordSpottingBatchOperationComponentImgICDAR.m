function [distVal] = wordSpottingBatchOperationComponentImgICDAR(featureMatForImage,realIndexMatForImage,l1,l4,...
    topTest,baseTest,testImgRw,testImgCol,allRefImgInfo,featureFunc,matchingFunc,technique,...
    avgWidth,avgHeight,heightMatter,testImgPath,imageFiePath_1,testName,percent,refComponentMat)

for eachRefPath = 1:1:size(allRefImgInfo,1)
    l1Ref = allRefImgInfo{eachRefPath,1};
    l4Ref = allRefImgInfo{eachRefPath,2};
    topLineRef = allRefImgInfo{eachRefPath,3};
    baseLineRef = allRefImgInfo{eachRefPath,4};
    componentRefImg = allRefImgInfo{eachRefPath,5};
    ImgRef = allRefImgInfo{eachRefPath,6};
    
    if(strcmp(matchingFunc,'Old_Normalize'))
        distVal = -5;
        if(ceil ( (size(ImgRef,2)) * (60/100) ) <=  (testImgCol) )
            refMatForMatch = (refComponentMat{1,3});
            realIndexRef = (refComponentMat{1,4});
            [~,distVal,~] = stringMatchingWithFunction(refMatForMatch,featureMatForImage,realIndexRef,realIndexMatForImage,technique,featureFunc,avgWidth,percent);
        end
    elseif(strcmp(matchingFunc,'New_Normalize'))
        distVal = performMatchingOnComponentImg(l1,l4,topTest,baseTest,...
            featureMatForImage,realIndexMatForImage,Img,ImgName,l1Ref,l4Ref,topLineRef,...
            baseLineRef,componentRefImg,ImgRef,technique,featureFunc,avgWidth,avgHeight);
    end
end
end