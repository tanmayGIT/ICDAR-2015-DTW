function [distVal] = performMatchingOnComponentImg_OldGW(refFeature,targetFeature,technique,percent,imageFiePath_1,targetImg,refImg,testName)
[distVal,getIndexes] = stringMatchingWithFunction_GW(refFeature,targetFeature,technique,percent);
beforeRLSATest = targetImg;
[sz1,sz2] = size(beforeRLSATest);
topRw =  1;
botRow = sz1;
leftCol = 1;
rightCol = sz2;
% Finding the top row
flag = 0;
for topI = 1:1:sz1
    for topJ = 1:1:sz2
        if(beforeRLSATest(topI,topJ) == 1)
            topRw = topI;
            flag = 1;
            break;
        end
    end
    if(flag == 1)
        break;
    end
end

% Finding the bottom row
flag = 0;
for topI = sz1:-1:1
    for topJ = 1:1:sz2
        if(beforeRLSATest(topI,topJ) == 1)
            botRow = topI;
            flag = 1;
            break;
        end
    end
    if(flag == 1)
        break;
    end
end
% Finding the left col
flag = 0;

for topJ = 1:1:sz2
    for topI = 1:1:sz1
        if(beforeRLSATest(topI,topJ) == 1)
            leftCol = topJ;
            flag = 1;
            break;
        end
    end
    if(flag == 1)
        break;
    end
    
end
% Finding the right Col
flag = 0;

for topJ = sz2:-1:1
    for topI = 1:1:sz1
        if(beforeRLSATest(topI,topJ) == 1)
            rightCol = topJ;
            flag = 1;
            break;
        end
    end
    if(flag == 1)
        break;
    end
end
Img = beforeRLSATest(topRw:botRow,leftCol:rightCol);
[nRowsComponent,nColsComponent] = size(Img);
changedRefImg = refImg;
[nRowsRef,nColsRef] = size(changedRefImg);

if(nColsComponent > nColsRef)
    stitchImage = zeros((nRowsRef+nRowsComponent+120),(nColsComponent+20));
else
    stitchImage = zeros((nRowsRef+nRowsComponent+120),(nColsRef+20));
end

stitchImage(3:4,5:nColsRef+4) = 255;
stitchImage((nRowsRef+5):(nRowsRef+6),5:nColsRef+4) = 255;
stitchImage((nRowsRef+80+3):(nRowsRef+80+4),5:nColsComponent+4) = 255;
stitchImage((nRowsRef+4+80+nRowsComponent+1):(nRowsRef+4+80+nRowsComponent+2),5:nColsComponent+4) = 255;

stitchImage(5:(nRowsRef+4),5:(nColsRef+4)) = changedRefImg(1:nRowsRef,1:nColsRef);
stitchImage((nRowsRef+80+5):(nRowsRef+4+80+nRowsComponent),(5):(nColsComponent+4)) = Img;

mergedImg = (stitchImage);
%         figure, imshow(mergedImg);
%         set(gcf,'Visible', 'on');
[~, ~, numberOfColorChannels] = size(mergedImg);
if numberOfColorChannels == 1
    % It's monochrome, so convert to color.
    afterBinarizedTest = cat(3, mergedImg, mergedImg, mergedImg);
end
RGB = zeros(3,3);
RGB(1,:) = [0,255,0];
RGB(2,:) = [255,0,0];
RGB(3,:) = [0,0,255];

if((size(getIndexes{1,1},1)) == (size(getIndexes{1,2},1)))  % check if nCols in both image are same or not
    colorPlat = 1;
    for element = 1:1:(size(getIndexes{1,1},1))
        
        if(colorPlat >3)
            colorPlat = 1;
        end
        refWordColNo = getIndexes{1,1}(element,1);
        testWordColNo = getIndexes{1,2}(element,1);
        
        mergedImgRefRw = nRowsRef + 5+3;
        mergedImgRefCol = 4+refWordColNo;
        
        mergedImgTestRw = nRowsRef+80+5-3;
        mergedImgTestCol = 4+testWordColNo;
        
        % As row index in image is considered as Y axis in polar
        % coordinate in matlab and vice versa
        x1 = mergedImgRefCol;
        x2 = mergedImgTestCol;
        y1 = mergedImgRefRw;
        y2 = mergedImgTestRw;
        [x,y] = bresenham(x1,y1,x2,y2);
        for pt =1:1:length(y)
            afterBinarizedTest((y(pt,1)),(x(pt,1)),1) = RGB(colorPlat,1);
            afterBinarizedTest((y(pt,1)),(x(pt,1)),2) = RGB(colorPlat,2);
            afterBinarizedTest((y(pt,1)),(x(pt,1)),3) = RGB(colorPlat,3);
        end
        colorPlat = colorPlat +1;
    end
else
    error ('The size of warping path for this component is not same')
end

imwrite(afterBinarizedTest,[imageFiePath_1,testName]);
end