function ImgRef = DrawColorLine(ImgRef,l1,l4,alternativeTopPt,alternativeBottomPt)
[~, nCol] = size(ImgRef);
% if numberOfColorChannels == 1
%     % It's monochrome, so convert to color.
%     afterBinarizedTest = cat(3, ImgRef, ImgRef, ImgRef);
% end

for pt =1:1:nCol
%     afterBinarizedTest(bottomLineTest,pt,1) = 255;
%     afterBinarizedTest(bottomLineTest,pt,2) = 0; % RED COLOR
%     afterBinarizedTest(bottomLineTest,pt,3) = 0;
%     
%     afterBinarizedTest(topLineTest,pt,1) = 0;
%     afterBinarizedTest(topLineTest,pt,2) = 255; % GREEN COLOR
%     afterBinarizedTest(topLineTest,pt,3) = 0;
    
%     ImgRef(l1,pt) = 0;
    ImgRef(l1,pt,2) = 255; % CYAN COLOR
    ImgRef(l1,pt,3) = 255;
    
%     ImgRef(l4,pt) = 1;
    ImgRef(l4,pt,2) = 255; % YELLOW COLOR
    ImgRef(l4,pt,3) = 0;
    
%     ImgRef(alternativeTopPt,pt) = 0;
    ImgRef(alternativeTopPt,pt,2) = 0;   % magenta
    ImgRef(alternativeTopPt,pt,3) = 255;
    
%     ImgRef(alternativeBottomPt,pt) = 0;
    ImgRef(alternativeBottomPt,pt,2) = 0;
    ImgRef(alternativeBottomPt,pt,3) = 255; % bLUE COLOR
end
if(size(ImgRef,3)==3)
    ImgRef = rgb2gray(ImgRef);
end

return;
end