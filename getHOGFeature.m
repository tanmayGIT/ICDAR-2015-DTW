function [updatedFeatureMat,updatedRealColInfo] = getHOGFeature(greyImg,binImg,avgWidth)
addpath('./HOG_FeatureOnly/')
[nRw,nCol] = size(greyImg);
% avgWidth = round(avgWidth/2);
% Now we try to divide the image using avgWidth, if the image width can be
% truly divided by the avgWidth, then it is very good but it is a bit hard
% to happen
% So, here our techique is to get the residue after division by avgWidth, if
% the residue is 0 then it is well and good if not then we look into the
% reside and see whether the residue is less than (avgWidth/2), if it is
% then that residue would be added with the last slice and if not then we
% will consider anothe slice and the width of the slice will be equal to
% the residue

% Number of cells do you want
% H = 4;% Number of cells in Y direction or in height
% W = 2;% Number of cells in X direction or in width
% 
% % Number of cells do you want per block
% % Try to keek this parameter as even as we want that 50% overlap
% % between the blocks
% h = 2;
% w = 2;
% 
% % Number of orientation
% nOri = 9;
% 
% nFeaturePerSlice = ((H-h+1)*(W-w+1)) * (h*w) * nOri;

% divRem = rem(nCol,avgWidth);
% nSlice = (nCol - divRem)/avgWidth;

BlockSize = [2 2];
BlockOverlap = ceil(BlockSize/2) ;
CellSize = [8 8];
NumBins = 9;
BlocksPerImage = floor(([nRw nCol]./CellSize-BlockSize)./(BlockSize-BlockOverlap)+ 1);
N = prod([BlocksPerImage BlockSize NumBins]);

featureMat = zeros(1,1);
realColInfo = zeros(1,2); % This wil keep the information start column and end column of slice
addedSlice = 0;
% if(divRem ~=0)&&(divRem >= (ceil(avgWidth/2)))
%     addedSlice = 1;
% %     nSlice = nSlice +1;
%     featureMat = zeros(1,N+2);
%     realColInfo = zeros(1,2);
% end

% when the image can be perfectly sliced
% if((addedSlice == 0)&&(divRem == 0))
%     eachslice = 1;
%     for j = 1:(round(avgWidth/2)):nCol
%         slicedImg = greyImg(:,j:(j+avgWidth-1));
%         slicedBinImg = binImg(:,j:(j+avgWidth-1));
%         if(nnz(slicedBinImg)> ( ((size(slicedBinImg,1))*(size(slicedBinImg,2)))*(10/100) ) )
%             % Here I need to take the foreground pixels locations in (M*2)
%             % array format.
%             [topRw,botRow,leftCol,rightCol,pixelList] = getBoundaryOfSlice(slicedBinImg);
%             cgX = round((botRow-topRw)/2);
%             cgY = round((rightCol-leftCol)/2);
%             %             slicedImg = slicedImg(topRw:botRow,leftCol:rightCol);
%             sliceFeature = extractHOGFeatures(slicedImg,'UseSignedOrientation',true);
%             sliceFeature(1,N+1) = cgX;
%             sliceFeature(1,N+2) = cgY;
%             %             sliceFeature = getBlocksFromSlice(slicedImg,H,W,h,w,nOri);
%             featureMat(eachslice,:) = sliceFeature;
%             realColInfo(eachslice,1) = j;
%             realColInfo(eachslice,2) = (j+avgWidth-1);
%             eachslice = eachslice +1;
%         end
%     end
% end

% when the (divRem < (avgWidth/2))
% if((addedSlice == 0)&&(divRem ~= 0))
    eachslice = 1;
    for j = 1:(round(avgWidth/2)):(nCol-(avgWidth)) % so basically here we are subtracting the last slice, as the last slice will be bigger in width
       if(j <nCol)
            slicedImg = greyImg(:,j:(j+avgWidth-1));
            slicedBinImg = binImg(:,j:(j+avgWidth-1));
            if(nnz(slicedBinImg)> ( ((size(slicedBinImg,1))*(size(slicedBinImg,2)))*(10/100) ) )
                [topRw,botRow,leftCol,rightCol,pixelList] = getBoundaryOfSlice(slicedBinImg);
                cgX = round((botRow-topRw)/2);
                cgY = round((rightCol-leftCol)/2);
                %             slicedImg = slicedImg(topRw:botRow,leftCol:rightCol);
                 cellSzHeight = 20;
                 cellSzWidth = 5;
                 if(size(slicedImg,1)< (2*cellSzHeight)) || (size(slicedImg,2)< (2*cellSzWidth))
                     error('The size of the image should be more than the twice of cell size')
                 end
                 sliceFeature = findBlocksHOG (slicedImg,0,cellSzHeight,cellSzWidth,25,'nomatrix','noshowWindow');
%                 sliceFeature = extractHOGFeatures(slicedImg,'UseSignedOrientation',true);
                sliceFeature(1,end+1) = cgX;
                sliceFeature(1,end+1) = cgY;
%                 %             sliceFeature = getBlocksFromSlice(slicedImg,H,W,h,w,nOri);
                if(j == 1)
                    featureMat = Inf(1,size(sliceFeature,2)); 
                end
                featureMat(eachslice,:) = sliceFeature;
                realColInfo(eachslice,1) = j;
                realColInfo(eachslice,2) = (j+avgWidth-1);
                eachslice = eachslice +1;
            end
       end
    end
    lastJ = j+avgWidth;
    slicedImg = greyImg(:,(lastJ-(round(avgWidth/2))):end);
    slicedImg = imresize(slicedImg,[nRw,avgWidth]);
    slicedBinImg = binImg(:,(lastJ-(round(avgWidth/2))):end);
    slicedBinImg = imresize(slicedBinImg,[nRw,avgWidth]);
    
    if(nnz(slicedBinImg)> ( ((size(slicedBinImg,1))*(size(slicedBinImg,2)))*(10/100) ) )
        [topRw,botRow,leftCol,rightCol,pixelList] = getBoundaryOfSlice(slicedBinImg);
        cgX = round((botRow-topRw)/2);
        cgY = round((rightCol-leftCol)/2);
        %         slicedImg = slicedImg(topRw:botRow,leftCol:rightCol);
        sliceFeature = findBlocksHOG (slicedImg,0,cellSzHeight,cellSzWidth,25,'nomatrix','noshowWindow');
        sliceFeature(1,end+1) = cgX;
        sliceFeature(1,end+1) = cgY;
        %         sliceFeature = getBlocksFromSlice(slicedImg,H,W,h,w,nOri);
        featureMat(eachslice,:) = sliceFeature;
        realColInfo(eachslice,1) = lastJ;
        realColInfo(eachslice,2) = nCol;
    end
% end

% % when the (divRem > (avgWidth/2))
% if((addedSlice == 1)&&(divRem ~= 0))
%     eachslice = 1;
%     for j = 1:avgWidth:(nCol-(divRem)) % so basically here we are subtracting the last slice, as the last slice wil be an added slice according to the previously said rule
%         slicedImg = greyImg(:,j:(j+avgWidth-1));
%         slicedBinImg = binImg(:,j:(j+avgWidth-1));
%         if(nnz(slicedBinImg)> ( ((size(slicedBinImg,1))*(size(slicedBinImg,2)))*(10/100) ) )
%             [topRw,botRow,leftCol,rightCol,pixelList] = getBoundaryOfSlice(slicedBinImg);
%             cgX = round((botRow-topRw)/2);
%             cgY = round((rightCol-leftCol)/2);
%             %             slicedImg = slicedImg(topRw:botRow,leftCol:rightCol);
%             sliceFeature = extractHOGFeatures(slicedImg,'UseSignedOrientation',true);
%             sliceFeature(1,N+1) = cgX;
%             sliceFeature(1,N+2) = cgY;
%             %             sliceFeature = getBlocksFromSlice(slicedImg,H,W,h,w,nOri);
%             featureMat(eachslice,:) = sliceFeature;
%             realColInfo(eachslice,1) = j;
%             realColInfo(eachslice,2) = (j+avgWidth-1);
%             eachslice = eachslice +1;
%         end
%     end
%     
%     slicedImg = greyImg(:,((nCol-divRem)+1):end);
%     slicedImg = imresize(slicedImg,[nRw,avgWidth]);
%     slicedBinImg = binImg(:,((nCol-divRem)+1):end);
%     slicedBinImg = imresize(slicedBinImg,[nRw,avgWidth]);
%     
%     if(nnz(slicedBinImg)> ( ((size(slicedBinImg,1))*(size(slicedBinImg,2)))*(10/100) ) )
%         [topRw,botRow,leftCol,rightCol,pixelList] = getBoundaryOfSlice(slicedBinImg);
%         cgX = round((botRow-topRw)/2);
%         cgY = round((rightCol-leftCol)/2);
%         %         slicedImg = slicedImg(topRw:botRow,leftCol:rightCol);
%         sliceFeature = extractHOGFeatures(slicedImg,'UseSignedOrientation',true);
%         sliceFeature(1,N+1) = cgX;
%         sliceFeature(1,N+2) = cgY;
%         %         sliceFeature = getBlocksFromSlice(slicedImg,H,W,h,w,nOri);
%         featureMat(eachslice,:) = sliceFeature;
%         realColInfo(eachslice,1) = ((nCol-divRem)+1);
%         realColInfo(eachslice,2) = nCol;
%     end
% end

updatedRealColInfo = zeros(1,2);
updatedFeatureMat = zeros(1,size(featureMat,2));
no_0 = 1;
for remove0 = 1:1:length(realColInfo)
    if(realColInfo(remove0,1) ~= 0)
        updatedRealColInfo(no_0,:) = realColInfo(remove0,:);
        updatedFeatureMat(no_0,:) = featureMat(remove0,:);
        no_0 = no_0 +1;
    end
end

return;
end

function totalFeature = getBlocksFromSlice(slicedImg,H,W,h,w,nOri)
[nRw,nCol] = size(slicedImg);

% Number of unique block exists
nUniqueBlock = (H-h+1)*(W-w+1);

% So, we need to make H number of cells along the height and W number of cells along the width
remInCellDivRw = rem(nRw,H);
pixPerCellRw = round((nRw-remInCellDivRw)/H); % anyway it would always be round offed even we don't use the function
remInCellDivCol = rem(nCol,W);
pixPerCellCol = round((nCol-remInCellDivCol)/W);
dividedCellImg = cell(H,W);
p = 1;
% q = 1;
rwInfo = zeros(1,2);
colInfo = zeros(1,2);
rwColInfo = cell(1,2);
for i = 1:pixPerCellRw:(nRw-(pixPerCellRw + remInCellDivRw))
    q = 1;
    for j = 1:pixPerCellCol:(nCol - (pixPerCellCol + remInCellDivCol))
        rwInfo(1,1) = i;
        rwInfo(1,2) = (i+pixPerCellRw-1);
        colInfo(1,1) = j;
        colInfo(1,2) = (j+pixPerCellCol-1);
        rwColInfo{1,1} = rwInfo;
        rwColInfo{1,2} = colInfo;
        dividedCellImg{p,q} = rwColInfo;
        q = q + 1;
    end
    p = p+1;
end

q = 1;
for j = 1:pixPerCellCol:(nCol - (pixPerCellCol + remInCellDivCol))
    rwInfo(1,1) = ((nRw-(pixPerCellRw + remInCellDivRw))+1);
    rwInfo(1,2) = nRw;
    colInfo(1,1) = j;
    colInfo(1,2) = (j+pixPerCellCol-1);
    rwColInfo{1,1} = rwInfo;
    rwColInfo{1,2} = colInfo;
    dividedCellImg{H,q} = rwColInfo;
    q = q + 1;
end

p = 1;
for i = 1:pixPerCellRw:(nRw-(pixPerCellRw + remInCellDivRw))
    rwInfo(1,1) = i;
    rwInfo(1,2) = (i+pixPerCellRw-1);
    colInfo(1,1) = ((nCol - (pixPerCellCol + remInCellDivCol))+1);
    colInfo(1,2) = nCol;
    rwColInfo{1,1} = rwInfo;
    rwColInfo{1,2} = colInfo;
    dividedCellImg{p,W} = rwColInfo;
    p = p+1;
end
rwInfo(1,1) = ((nRw-(pixPerCellRw + remInCellDivRw))+1);
rwInfo(1,2) = nRw;
colInfo(1,1) = ((nCol - (pixPerCellCol + remInCellDivCol))+1);
colInfo(1,2) = nCol;
rwColInfo{1,1} = rwInfo;
rwColInfo{1,2} = colInfo;
dividedCellImg{H,W} = rwColInfo;

totalFeature = zeros((nUniqueBlock*h*w*nOri),1);
% A block is consisting of h*w cells
% Here we are considering 50% overlap in block height as well as width
index = 1;
for m = 1:(h/2):H
    for n = 1:(w/2):W
        if(((m+h-1) <= H) && ((n+w-1) <= W))
            
            rwStart = dividedCellImg{m,n}{1,1}(1,1);
            rwEnd = dividedCellImg{m+h-1,n+w-1}{1,1}(1,2);
            
            colStart = dividedCellImg{m,n}{1,2}(1,1);
            colEnd = dividedCellImg{m+h-1,n+w-1}{1,2}(1,2);
            
            getBlkImg = slicedImg(rwStart:rwEnd,colStart:colEnd); % In this block image we have h*w cells
            cellCoord = cell((((m+h-1)-m)+1),(((n+w-1)-n)+1));
            s = 1;
            for celR = m:1:(m+h-1)
                t = 1;
                for celC = n:1:(n+w-1)
                    cellCoord{s,t} = dividedCellImg{celR,celC};
                    t = t +1;
                end
                s = s+1;
            end
            refRwStart = rwStart;
            refColStart = colStart;
            
            hogFeature = HOG(getBlkImg,cellCoord,nOri,refRwStart,refColStart);
            totalFeature(index:(index+((h*w*nOri)-1)),1) = hogFeature;
            
            index = index + (h*w*nOri);
        end
    end
end

end

function [topRw,botRow,leftCol,rightCol,pixelList] = getBoundaryOfSlice(beforeRLSATest)
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

pixelList = zeros(1,2);
t1 = 1;
for i = topRw:1:botRow
    for j = leftCol:1:rightCol
        if(beforeRLSATest(i,j)~=0)
            pixelList(t1,1) = j;
            pixelList(t1,2) = i;
            t1 = t1+1;
        end
    end
end

% componentImg = beforeRLSATest(topRw:botRow,leftCol:rightCol);
return
end