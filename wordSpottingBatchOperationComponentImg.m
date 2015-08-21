function [distVal] = wordSpottingBatchOperationComponentImg(featureMatForImage,realIndexMatForImage,l1,l4,...
                                topTest,baseTest,testImgRw,testImgCol,allRefImgInfo,featureFunc,matchingFunc,technique,...
                                            avgWidth,avgHeight,heightMatter,testImgPath,imageFiePath_1,testName,percent)
for eachRefPath = 1:1:size(allRefImgInfo,1)
    l1Ref = allRefImgInfo{eachRefPath,1};
    l4Ref = allRefImgInfo{eachRefPath,2};
    topLineRef = allRefImgInfo{eachRefPath,3};
    baseLineRef = allRefImgInfo{eachRefPath,4};
    componentRefImg = allRefImgInfo{eachRefPath,5};
    ImgRef = allRefImgInfo{eachRefPath,6};
    
    if(strcmp(matchingFunc,'Old_Normalize'))
        distVal = performMatchingOnComponentImg_Old(featureMatForImage,realIndexMatForImage,...
            componentRefImg,ImgRef,testImgRw,testImgCol,technique,featureFunc,avgWidth,heightMatter,testImgPath,imageFiePath_1,testName,percent);
    elseif(strcmp(matchingFunc,'New_Normalize'))
        distVal = performMatchingOnComponentImg(l1,l4,topTest,baseTest,...
            featureMatForImage,realIndexMatForImage,Img,ImgName,l1Ref,l4Ref,topLineRef,...
            baseLineRef,componentRefImg,ImgRef,technique,featureFunc,avgWidth,avgHeight);
    end   
end
end