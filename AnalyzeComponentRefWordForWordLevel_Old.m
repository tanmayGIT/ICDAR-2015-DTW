function [FilteredConnectedCom] = AnalyzeComponentRefWordForWordLevel_Old(testImgRw,testImgCol,beforeRLSARef,ImgRef,featureFunc,avgWidth,heightMatter)

componentImg = beforeRLSARef;
if(strcmp(heightMatter,'keepOriginalHeight'))
    % Making the height of reference image equal to the height of test image
    componentImg = imresize(componentImg,[testImgRw NaN]);
    ImgRef = imresize(ImgRef,[testImgRw NaN]);
elseif(strcmp(heightMatter,'makeDoubleHeight'))
    % Making the height of reference image equal to the height of test image
    componentImg = imresize(componentImg,[testImgRw NaN]);
    ImgRef = imresize(ImgRef,[testImgRw NaN]);
end
if(strcmp(featureFunc,'columnFeature'))
    [featureMat,lukUpTableForRealIndex] = GetFeatureOfComponentUpdated_3ExpWithSpaces(componentImg,ImgRef);
elseif ((strcmp(featureFunc,'HOGFeature')))
    [featureMat,lukUpTableForRealIndex] = getHOGFeature(ImgRef,componentImg,avgWidth);
end

FilteredConnectedCom{1,1} = 0;
FilteredConnectedCom{1,2} = ImgRef; % Storing by cutting with the proper boundary of the Component image
FilteredConnectedCom{1,3} = featureMat;
FilteredConnectedCom{1,4} = lukUpTableForRealIndex;
end