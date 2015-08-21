
function [distVal] = performMatchingOnComponentImg(l1,l4,topLineTest,bottomLineTest,testMat,realIndexTest,ImgTest,ImgName,imageFiePath_1,l1Ref,l4Ref,topLineRef,baseLineRef,componentRefImg,ImgRef,technique,featureFunc,avgWidth,avgHeight)
distVal = -5;
if(ceil ( (size(ImgRef,2)) * (30/100) ) <=  (size(ImgTest,2)) )
    accumulatedBoundary(1,1) = l1;
    accumulatedBoundary(1,2) = l4;
    accumulatedBoundary(1,3) = topLineTest;
    accumulatedBoundary(1,4) = bottomLineTest;
    %     refComponentMat = AnalyzeComponentRefWordForWordLevel_Old(componentRefImg,ImgRef,(size(ImgTest,1)));
    refComponentMat = AnalyzeRefWord(l1Ref,l4Ref,topLineRef,baseLineRef,componentRefImg,ImgRef,accumulatedBoundary,featureFunc,avgWidth);
    changedRefImg = (refComponentMat{1,2});
    refMatForMatch = (refComponentMat{1,3});
    realIndexRef = (refComponentMat{1,4});
    
    [~,distVal,getIndexes] = stringMatchingWithFunction(refMatForMatch,testMat,realIndexRef,realIndexTest,technique,featureFunc);
    
    %     croppedComponent = DrawColorLine(ImgTest,l1,l4,topLineTest,bottomLineTest);
    croppedComponent = ImgTest;
    [nRowsComponent,nColsComponent] = size(croppedComponent);
    [nRowsRef,nColsRef] = size(changedRefImg);
    
    croppedComponent(l1,:) = 1;
    croppedComponent(l4,:) = 1;
    croppedComponent(topLineTest,:) = 1;
    croppedComponent(bottomLineTest,:) = 1;
    
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
    stitchImage((nRowsRef+80+5):(nRowsRef+4+80+nRowsComponent),(5):(nColsComponent+4)) = croppedComponent;
    
    mergedImg = mat2gray(stitchImage);
    %         figure, imshow(mergedImg);
    %         set(gcf,'Visible', 'on');
    [~, ~, numberOfColorChannels] = size(mergedImg);
    if numberOfColorChannels == 1
        % It's monochrome, so convert to color.
        afterBinarizedTest = cat(3, mergedImg, mergedImg, mergedImg);
    end
    RGB = zeros(3,3);
    RGB(1,:) = [0,0,255];
    RGB(2,:) = [255,0,0];
    RGB(3,:) = [0,255,0];
    if(strcmp(featureFunc,'columnFeature'))
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
                
                %                 X = [mergedImgRefCol mergedImgTestCol];
                %                 Y = [mergedImgRefRw mergedImgTestRw];
                x1 = mergedImgRefCol;
                x2 = mergedImgTestCol;
                y1 = mergedImgRefRw;
                y2 = mergedImgTestRw;
                [x y] = bresenham(x1,y1,x2,y2);
                
               
           
                
                for pt =1:1:length(y)
                    afterBinarizedTest((y(pt,1)),(x(pt,1)),1) = RGB(colorPlat,1);
                    afterBinarizedTest((y(pt,1)),(x(pt,1)),2) = RGB(colorPlat,2);
                    afterBinarizedTest((y(pt,1)),(x(pt,1)),3) = RGB(colorPlat,3);
                end
                colorPlat = colorPlat +1;
                %                 line(X,Y);
                %                 hold on
            end
        else
            error ('The size of warping path for this component is not same')
        end
    end
    if(strcmp(featureFunc,'HOGFeature'))
        if((size(getIndexes{1,1},1)) == (size(getIndexes{1,2},1)))  % check if nCols in both image are same or not
            colorPlat = 1;
            for element = 1:1:(size(getIndexes{1,1},1))
                
                if(colorPlat >3)
                    colorPlat = 1;
                end
                refWordColNoStart = getIndexes{1,1}(element,1);
                refWordColNoEnd = getIndexes{1,1}(element,2);
                
                testWordColNoStart = getIndexes{1,2}(element,1);
                testWordColNoEnd = getIndexes{1,2}(element,2);
                
                mergedImgRefRw = nRowsRef + 5+3;
                mergedImgRefColStart = 4+refWordColNoStart;
                mergedImgRefColEnd = 4+refWordColNoEnd;
                
                mergedImgTestRw = nRowsRef+80+5-3;
                mergedImgTestColStart = 4+testWordColNoStart;
                mergedImgTestColEnd = 4+testWordColNoEnd;
                
                
                x1Start = mergedImgRefColStart;
                x1End = mergedImgRefColEnd;
                
                x2Start = mergedImgTestColStart;
                x2End = mergedImgTestColEnd;
                
                y1 = mergedImgRefRw;
                y2 = mergedImgTestRw;
                [xStart yStart] = bresenham(x1Start,y1,x2Start,y2);
                [xEnd yEnd] = bresenham(x1End,y1,x2End,y2);
                
                for pt =1:1:length(yStart)
                    afterBinarizedTest((yStart(pt,1)),(xStart(pt,1)),1) = RGB(colorPlat,1);
                    afterBinarizedTest((yStart(pt,1)),(xStart(pt,1)),2) = RGB(colorPlat,2);
                    afterBinarizedTest((yStart(pt,1)),(xStart(pt,1)),3) = RGB(colorPlat,3);
                end
                for pt =1:1:length(yEnd)
                    afterBinarizedTest((yEnd(pt,1)),(xEnd(pt,1)),1) = RGB(colorPlat,1);
                    afterBinarizedTest((yEnd(pt,1)),(xEnd(pt,1)),2) = RGB(colorPlat,2);
                    afterBinarizedTest((yEnd(pt,1)),(xEnd(pt,1)),3) = RGB(colorPlat,3);
                end
                colorPlat = colorPlat +1;
            end
        else
            error ('The size of warping path for this component is not same')
        end
        
    end
    
    %         pause(0.2);
    %         f = getframe(gcf);
    %         pause(0.2);
    %         imFrame = frame2im(f);
    %         str1 = int2str(ImgName);
    
    imwrite(afterBinarizedTest,[imageFiePath_1,ImgName '.jpg']);
    %         hold off
    %         close;
    
    %     fprintf(fid1,'The Distance Value of %s component is : %d \n',ImgName,distVal); %write first value
else
    disp('wanna see your prob');
    
end
%     fclose(fid1);

end