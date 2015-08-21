function strokeWidth = averageStrokeWidth(binImg)
% this function calculates stroke width from the handwritten image
Iedge = edge(binImg, 'Canny');
binEdgeImage=(Iedge);
distanceImage = bwdist(Iedge);
strokeWidthImage = helperStrokeWidth(distanceImage);
k=1;
widthOfPixels = zeros(1,1);
for iRow=1:size(binImg,1)
    for iCol=1:size(binImg,2)
        if binImg(iRow,iCol)==0 && binEdgeImage(iRow,iCol)~=1
            widthOfPixels(k) = strokeWidthImage(iRow,iCol);
            k=k+1;
        end
    end
end
strokeWidth = median(widthOfPixels);
return;
end