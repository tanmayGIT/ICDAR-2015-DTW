function [keepAllFeature_Refined] = generateFeaturematICDAR(imgPath,fileNames,matchingFunc,featureFunc,heightMatter)

nImages = (length(fileNames));

% Now calculate the average width by using all the segmented word images in
% the folder
keepAllWidthHeight = zeros(1,1);

for k = 1:(nImages)
%     if(( (strcmp(matchingFunc,'Old_Normalize')) && (strcmp(heightMatter,'makeDoubleHeight')) )  )
        imageFilePath = [imgPath,fileNames{k}];
        ImgTest = imread(imageFilePath);
        if(size(ImgTest,3)==3)
            ImgTest = rgb2gray(ImgTest);
        end
        ImgTest = uint8(ImgTest);
        [rw,col] = size(ImgTest);
        keepAllWidthHeight(k,1) = rw;
        keepAllWidthHeight(k,2) = col;
%         comWidth = getWidthOfEachComponent(ImgTest);
%         comHeight = getHeightOfEachComponent(ImgTest);
%         keepAllWidth(lastIndx:((lastIndx+length(comWidth))-1)) = comWidth;
%         keepAllHeight(lastIndx:((lastIndx+length(comWidth))-1)) = comHeight;
%         lastIndx = (lastIndx+length(comWidth));
%     end
end
% if(( (strcmp(matchingFunc,'Old_Normalize')) && (strcmp(heightMatter,'makeDoubleHeight')) ) )
    avgWidth = getPerfectAvgValues(keepAllWidthHeight(:,2)');
    avgHeight = getPerfectAvgValues(keepAllWidthHeight(:,1)');
% end

keepAllFeature = cell(1,4);

for k = 1:(nImages)
    imageFilePath = [imgPath,fileNames{k}];
%     disp(k);
    ImgTest = imread(imageFilePath);
    if(size(ImgTest,3)==3)
        ImgTest = rgb2gray(ImgTest);
    end
    ImgTest = uint8(ImgTest);
    [featureMat,realIndexMat,keepAllOthers] = calculateFeatureVector(ImgTest,featureFunc,matchingFunc,avgWidth,avgHeight,heightMatter);
    keepAllFeature{k,1} = featureMat;
    keepAllFeature1{k,1} = realIndexMat;
    keepAllFeature2{k,1} = keepAllOthers;
    keepAllFeature3{k,1} = imageFilePath;
end
cnt = 1;
keepAllFeature_Refined = cell(1,1);
for uui = 1:1:size(keepAllFeature,1)
    if (~isempty(keepAllFeature{uui,1}))
        keepAllFeature_Refined{cnt,1} = keepAllFeature{uui,1};
        keepAllFeature_Refined{cnt,2} = keepAllFeature1{uui,1};
        keepAllFeature_Refined{cnt,3} = keepAllFeature2{uui,1};
        keepAllFeature_Refined{cnt,4} = keepAllFeature3{uui,1};
        cnt = cnt +1;
    end
end
end


function [featureMat,realIndexMat,keepAllOthers] = calculateFeatureVector(Img,featureFunc,matchingFunc,avgWidth,avgHeight,heightMatter)
level = graythresh(Img);
temImgBin = im2bw(Img,level);
% [temImgBin] = mainDP(Img);
componentImg = imcomplement(temImgBin);
[Img,componentImg] =  generatePerfectBoundary(Img,componentImg);

% angle = slantDetection(componentImg);
% if(angle > 0)
%     [componentImg,Img] = slantCorrection(componentImg,Img,angle);
% end
[Img,componentImg] =  generatePerfectBoundary(Img,componentImg);

[realRw,realCol] = size(Img);

if( (strcmp(matchingFunc,'Old_Normalize')) && (strcmp(heightMatter,'makeDoubleHeight')) )
    componentImg = imresize(componentImg,[(avgHeight*2),NaN]); % resizing the image with 2*average height
    Img = imresize(Img,[(avgHeight*2),NaN]);
elseif( (strcmp(matchingFunc,'Old_Normalize')) && (strcmp(heightMatter,'keepOriginalHeight')) )
    componentImg = imresize(componentImg,[(avgHeight),NaN]); % resizing the image with 2*average height
    Img = imresize(Img,[(avgHeight),NaN]);
end
nofForeGdPixels = sum(componentImg(:));
newRw = size(componentImg,1);
newCol = size(componentImg,2);
if(strcmp(featureFunc,'columnFeature'))
    if(nofForeGdPixels > 50)
        [featureMat,realIndexMat] = GetFeatureOfComponentUpdated_3ExpWithSpaces(componentImg,Img);
    else
        featureMat = 0;
        realIndexMat = 0;
    end
elseif ((strcmp(featureFunc,'HOGFeature')))
%     strokeWidth = averageStrokeWidth(componentImg);
    [featureMat,realIndexMat] = getHOGFeature(Img,componentImg,10);
end

% First we calculate the boundaries of test word and then we with this
% values we now resize the reference image after calculating the
% boundary of reference image
if(strcmp(matchingFunc,'New_Normalize'))
    [l1,l4,topLineTest,bottomLineTest] = callTestAscenderDescenderFunc(componentImg);
elseif (strcmp(matchingFunc,'Old_Normalize'))
    % As you don't ned these values
    l1 = 0;
    l4 = 0;
    topLineTest = 0;
    bottomLineTest = 0;
end
keepAllOthers(1,1) = l1;
keepAllOthers(1,2) = l4;
keepAllOthers(1,3) = topLineTest;
keepAllOthers(1,4) = bottomLineTest;
keepAllOthers(1,5) = avgWidth;
keepAllOthers(1,6) = avgHeight;
keepAllOthers(1,7) = newRw;
keepAllOthers(1,8) = newCol;
keepAllOthers(1,9) = realRw;
keepAllOthers(1,10) = realCol;
keepAllOthers(1,11) = nofForeGdPixels; 
end