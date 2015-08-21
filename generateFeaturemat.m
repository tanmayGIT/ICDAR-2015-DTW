function [keepAllFeature] = generateFeaturemat(imgPath,fileNames,matchingFunc,featureFunc,heightMatter)

nImages = (length(fileNames));

% Now calculate the average width by using all the segmented word images in
% the folder
keepAllWidth = zeros(1,1);
keepAllHeight = zeros(1,1);
lastIndx = 1;
for k = 1:(nImages)
    if(( (strcmp(matchingFunc,'Old_Normalize')) && (strcmp(heightMatter,'makeDoubleHeight')) ) ||(strcmp(featureFunc,'HOGFeature')) )
        imageFilePath = [imgPath,fileNames{k}];
        ImgTest = imread(imageFilePath);
        if(size(ImgTest,3)==3)
            ImgTest = rgb2gray(ImgTest);
        end
        ImgTest = uint8(ImgTest);
        comWidth = getWidthOfEachComponent(ImgTest);
        comHeight = getHeightOfEachComponent(ImgTest);
        keepAllWidth(lastIndx:((lastIndx+length(comWidth))-1)) = comWidth;
        keepAllHeight(lastIndx:((lastIndx+length(comWidth))-1)) = comHeight;
        lastIndx = (lastIndx+length(comWidth));
    end
end
if(( (strcmp(matchingFunc,'Old_Normalize')) && (strcmp(heightMatter,'makeDoubleHeight')) )||(strcmp(featureFunc,'HOGFeature')) )
    avgWidth = getPerfectAvgValues(keepAllWidth);
    avgHeight = getPerfectAvgValues(keepAllHeight);
else
    % As these values are not required
    avgWidth = 0;
    avgHeight = 0;
end

keepAllFeature = cell(1,4);

for k = 1:(nImages)
    imageFilePath = [imgPath,fileNames{k}];
    disp(k);
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
for uui = 1:1:size(keepAllFeature,1)
    keepAllFeature{uui,2} = keepAllFeature1{uui,1};
    keepAllFeature{uui,3} = keepAllFeature2{uui,1};
    keepAllFeature{uui,4} = keepAllFeature3{uui,1};
end
end


function [featureMat,realIndexMat,keepAllOthers] = calculateFeatureVector(Img,featureFunc,matchingFunc,avgWidth,avgHeight,heightMatter)


% level = graythresh(Img);
% Img1 = im2bw(Img,level);
% Img1 = imcomplement(Img1);
% beforeRLSATest = ApplyMorphology(Img1,false);
%
% [sz1,sz2] = size(beforeRLSATest);
% topRw =  1;
% botRow = sz1;
% leftCol = 1;
% rightCol = sz2;
% % Finding the top row
% flag = 0;
% for topI = 1:1:sz1
%     for topJ = 1:1:sz2
%         if(beforeRLSATest(topI,topJ) == 1)
%             topRw = topI;
%             flag = 1;
%             break;
%         end
%     end
%     if(flag == 1)
%         break;
%     end
% end
%
% % Finding the bottom row
% flag = 0;
% for topI = sz1:-1:1
%     for topJ = 1:1:sz2
%         if(beforeRLSATest(topI,topJ) == 1)
%             botRow = topI;
%             flag = 1;
%             break;
%         end
%     end
%     if(flag == 1)
%         break;
%     end
% end
% % Finding the left col
% flag = 0;
%
% for topJ = 1:1:sz2
%     for topI = 1:1:sz1
%         if(beforeRLSATest(topI,topJ) == 1)
%             leftCol = topJ;
%             flag = 1;
%             break;
%         end
%     end
%     if(flag == 1)
%         break;
%     end
%
% end
% % Finding the right Col
% flag = 0;
%
% for topJ = sz2:-1:1
%     for topI = 1:1:sz1
%         if(beforeRLSATest(topI,topJ) == 1)
%             rightCol = topJ;
%             flag = 1;
%             break;
%         end
%     end
%     if(flag == 1)
%         break;
%     end
% end
%
% componentImg = beforeRLSATest(topRw:botRow,leftCol:rightCol);
% Img = Img(topRw:botRow,leftCol:rightCol);



[temImgBin] = mainDP(Img);
componentImg = imcomplement(temImgBin);
[Img,componentImg] =  generatePerfectBoundary(Img,componentImg);

if( (strcmp(matchingFunc,'Old_Normalize')) && (strcmp(heightMatter,'makeDoubleHeight')) )
    componentImg = imresize(componentImg,[(avgHeight*2),NaN]); % resizing the image with 2*average height
    Img = imresize(Img,[(avgHeight*2),NaN]);
end
newRw = size(componentImg,1);
newCol = size(componentImg,2);

if(strcmp(featureFunc,'columnFeature'))
    [featureMat,realIndexMat] = GetFeatureOfComponentUpdated_3ExpWithSpaces(componentImg,Img);
elseif ((strcmp(featureFunc,'HOGFeature')))
    [featureMat,realIndexMat] = getHOGFeature(Img,componentImg,avgWidth);
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
end