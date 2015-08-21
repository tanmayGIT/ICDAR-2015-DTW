function [DistanceVal,indxCol,indxRw] = fastDTW(refSignal,testSignal)

searchRad = (size(testSignal,1)) - (size(refSignal,1));
if(searchRad<0)
    searchRad = 0;
end
minTSsize = searchRad+2;
if((size(refSignal,1) <minTSsize)||(size(testSignal,1)<minTSsize))
    [DistanceVal,indxCol,indxRw] = DynamicTimeWarping(refSignal,testSignal);
    return;
else
    [shrinkRefSignal,blockEntryRef] = PAA_IterativeDeepning(refSignal);
    [shrinkTestSignal,blockEntryTest] = PAA_IterativeDeepning(testSignal);
    [~,indxCol,indxRw] = fastDTW(shrinkRefSignal,shrinkTestSignal);
    
    
    
    dummyDistMat = ExpandedResWindow(refSignal,testSignal,blockEntryRef,blockEntryTest,indxRw,indxCol,searchRad);
    [DistanceVal,indxCol,indxRw] = constraintDTW(refSignal,testSignal,dummyDistMat);
end
end

function dummyDistMat = ExpandedResWindow(refSignal,testSignal,blockEntryRef,blockEntryTest,indxRw,indxCol,searchRad)

global minValues
global maxValues
global maxJ
global sz
global modCount

refSz = (size(refSignal,1));
minValues = zeros(1,refSz);
minValues = minValues-1; % to initialize with -1
maxValues = zeros(1,(size(refSignal,1))); % to initialize with zeros
maxJ = (size(testSignal,1));
sz = 0;
modCount = 0;

dummyDistMat = zeros(size(refSignal,1),size(testSignal,1));
indxRw = flipud(indxRw);
indxCol = flipud(indxCol);
currentI = min(indxRw);
currentJ = min(indxCol);

lastWarpI = Inf;
lastWarpJ = Inf;
% extendedMat = zeros(2,2);
for w = 1:1:length(indxRw)
    warpI = indxRw(w);
    warpJ = indxCol(w);
    
    blockISize = blockEntryRef(warpI);
    blockJSize = blockEntryTest(warpJ);
    
    if(warpI > lastWarpI)
        currentI = currentI + blockEntryRef(lastWarpI);
    end
    
    if(warpJ > lastWarpJ)
        currentJ = currentJ + blockEntryTest(lastWarpJ);
    end
    
    if((warpJ > lastWarpJ)&&(warpI > lastWarpI))
        %         dummyDistMat(currentI-1,currentJ) = 5;
        markVisited(currentI-1,currentJ);
        %         dummyDistMat(currentI,currentJ-1) = 5;
        markVisited(currentI,currentJ-1);
        
        %         extendedMat(cnt1,1) = currentI-1;
        %         extendedMat(cnt1,2) = currentJ;
        %
        %         extendedMat(cnt1+1,1) = currentI;
        %         extendedMat(cnt1+1,2) = currentJ-1;
        
        %         cnt1 = cnt1+1;
    end
    for x = 1:1:blockISize
        %         dummyDistMat(currentI+x,currentJ) = 5;
        markVisited(currentI+(x-1),currentJ);
        %         dummyDistMat(currentI+x,currentJ+blockJSize-1) = 5;
        markVisited(currentI+(x-1),currentJ+blockJSize-1);
        
        %         extendedMat(cnt1,1) = currentI+x;
        %         extendedMat(cnt1,2) = currentJ;
        %
        %         extendedMat(cnt1+1,1) = currentI+x;
        %         extendedMat(cnt1+1,2) = currentJ+blockJSize-1;
        
        %         cnt1 = cnt1+1;
    end
    lastWarpI = warpI;
    lastWarpJ = warpJ;
end
dummyDistMat = expandWindow(searchRad,dummyDistMat);
clear minValues;
clear maxValues;
clear sz;
clear modCount;
return;
end



function markVisited(row,col)

global minValues
global maxValues

global sz
global modCount

if(minValues(1,row) == -1)
    minValues(1,row) = col;
    maxValues(1,row) = col;
    sz = sz +1;
    modCount = modCount+1;
elseif(minValues(1,row) > col)
    sz = sz + (minValues(1,row) - col);
    minValues(1,row) = col;
    modCount = modCount+1;
elseif(maxValues(1,row) < col)
    sz = sz + (col - maxValues(1,row));
    maxValues(1,row) = col;
    modCount = modCount+1;
end
end



function dummyDistMat = expandWindow(searchRad,dummyDistMat)
global minValues
global maxValues
storWindow = zeros(length(minValues),1);
windowCnt = zeros(length(minValues),1);

for ik = 1:1:length(minValues)
    pickMin = minValues(1,ik);
    pickMax = maxValues(1,ik);
    storWindow(ik,1:((pickMax - pickMin)+1)) = pickMin:pickMax;
    windowCnt(ik,1) = ((pickMax - pickMin)+1); % keeping the information of the band width of the particular row
end
[nRow,nCol] = size(dummyDistMat);

if(searchRad > 0)
    for i = 1:1:(size(storWindow,1))
        for j = 1:1:(windowCnt(i,1))
            % move to the upper left
            winRw = i;
            winCol = storWindow(i,j);
            dummyDistMat(winRw,winCol) = 5;
            if((winRw~=1)&&(winCol~=1))
                targetRw = winRw - searchRad;
                targetCol = winCol - searchRad;
                if((targetRw >= 1)&&(targetCol>=1))
                    dummyDistMat((targetRw:winRw),(targetCol:winCol)) = 5;
                elseif((targetRw < 1)&&(targetCol < 1))
                    dummyDistMat(1:winRw,1:(winCol)) = 5;
                elseif(targetRw < 1)
                    dummyDistMat(1:winRw,targetCol:(winCol)) = 5;
                elseif(targetCol < 1)
                    dummyDistMat((targetRw:winRw),1:(winCol)) = 5;
                end
            end
            % move to the upper side
            if((winRw~=1))
                targetRw = winRw - searchRad;
                if((targetRw >= 1))
                    dummyDistMat((targetRw:winRw),(winCol)) = 5;
                elseif(targetRw < 1)
                    dummyDistMat(1:(winRw),(winCol)) = 5;
                end
            end
            % move to the upper right
            if((winRw~=1)&&(winCol~=nCol))
                targetRw = winRw - searchRad;
                targetCol = winCol + searchRad;
                if((targetRw >= 1)&&(targetCol<=nCol))
                    dummyDistMat((targetRw:winRw),(winCol):targetCol) = 5;
                elseif((targetRw < 1)&&(targetCol > nCol))
                    dummyDistMat(1:(winRw),(winCol):nCol) = 5;
                elseif(targetRw < 1)
                    dummyDistMat(1:(winRw),(winCol):targetCol) = 5;
                elseif(targetCol > nCol)
                    dummyDistMat((targetRw:winRw),(winCol):nCol) = 5;
                end
            end
            % move to the left
            if((winCol~=1))
                targetCol = winCol - searchRad;
                if((targetCol>=1))
                    dummyDistMat((winRw),targetCol:(winCol)) = 5;
                elseif(targetCol < 1)
                    dummyDistMat((winRw),1:(winCol)) = 5;
                end
            end
            % move to the right
            if((winCol~=nCol))
                targetCol = winCol + searchRad;
                if(targetCol<=nCol)
                    dummyDistMat((winRw),(winCol):targetCol) = 5;
                elseif(targetCol > nCol)
                    dummyDistMat((winRw),(winCol):nCol) = 5;
                end
            end
            % move to the down left
            if((winRw~=nRow)&&(winCol~=1))
                targetRw = winRw + searchRad;
                targetCol = winCol - searchRad;
                if((targetRw <= nRow)&&(targetCol>=1))
                    dummyDistMat((winRw):targetRw,(targetCol:winCol)) = 5;
                elseif((targetRw > nRow)&&(targetCol < 1))
                    dummyDistMat((winRw):nRow,1:(winCol)) = 5;
                elseif(targetRw > nRow)
                    dummyDistMat((winRw):nRow,targetCol:(winCol)) = 5;
                elseif(targetCol < 1)
                    dummyDistMat((winRw):targetRw,1:(winCol)) = 5;
                end
            end
            % move to the down Right
            if((winRw~=nRow)&&(winCol~=nCol))
                targetRw = winRw + searchRad;
                targetCol = winCol + searchRad;
                if((targetRw <= nRow)&&(targetCol<=nCol))
                    dummyDistMat((winRw):targetRw,(winCol):targetCol) = 5;
                elseif((targetRw > nRow)&&(targetCol > nCol))
                    dummyDistMat((winRw):nRow,(winCol):nCol) = 5;
                elseif(targetRw > nRow)
                    dummyDistMat((winRw):nRow,(winCol):targetCol) = 5;
                elseif(targetCol > nCol)
                    dummyDistMat((winRw):targetRw,(winCol):nCol) = 5;
                end
            end
            % move to the down side
            if((winRw~=nRow))
                targetRw = winRw + searchRad;
                if((targetRw <= nRow))
                    dummyDistMat((winRw):targetRw,(winCol)) = 5;
                elseif(targetRw > nRow)
                    dummyDistMat((winRw):nRow,(winCol)) = 5;
                end
            end
        end
    end
end
end



function [DistanceVal,indxCol,indxRw] = constraintDTW(refSample,testSample,dummyDistMat)

[noOfSamplesInRefSample,N]=size(refSample);
[noOfSamplesInTestSample,M]=size(testSample);

if(N == M) % each set containing same no. of feature
    
    Dist = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample); % Initializing the array
    for i=1:noOfSamplesInRefSample % xSize
        for j=1:noOfSamplesInTestSample %ySize
            if(dummyDistMat(i,j) == 5)
                total = zeros(N,1);
                for goFeature=1:N %or M as N & M are same
                    total(goFeature,1) = (double((refSample(i,goFeature)-testSample(j,goFeature))^2));
                end
                Dist(i,j) =  sqrt(sum(total));
            end
        end
    end
    
    D=Inf(size(Dist));
    D(1,1)=Dist(1,1);
    
    for n=2:noOfSamplesInRefSample
        if(dummyDistMat(n,1) == 5)
            D(n,1)=Dist(n,1)+D(n-1,1);
        end
    end
    for m=2:noOfSamplesInTestSample
        if(dummyDistMat(1,m) == 5)
            D(1,m)=Dist(1,m)+D(1,m-1);
        end
    end
    for n=2:noOfSamplesInRefSample
        for m=2:noOfSamplesInTestSample
            if(dummyDistMat(n,m) == 5)
                D(n,m)=Dist(n,m)+min([D(n-1,m),(min([D(n-1,m-1),D(n,m-1)]))]); % Thanks for the suggestion by "Sven Mensing" in Matlab Central
            end
        end
    end
    
    % Once the accumulated cost matrix built the warping path could be found
    % by the simple backtracking from the point pEnd = (M,N) to the pstart=(1,1)
    % following the greedy strategy as described by the below Algorithm; ref:
    % "Dynamic Time Warping Algorithm Review" by Pavel Senin
    
    X = noOfSamplesInRefSample;
    Y = noOfSamplesInTestSample;
    k=1;
    Wrapped(1,:)=[X,Y];
    while ((X>1)||(Y>1))
        if ((X-1)==0)
            Y = Y-1;
        elseif ((Y-1)==0)
            X = X-1;
        else
            [~,place] = min([D(X-1,Y),D(X,Y-1),D(X-1,Y-1)]);
            switch place
                case 1
                    X = X-1;
                case 2
                    Y = Y-1;
                case 3
                    X = X-1;
                    Y = Y-1;
            end
        end
        k=k+1; % The number of steps it took to come to the place [1,1]
        Wrapped = cat(1,Wrapped,[X,Y]);
    end
    indxRw =  Wrapped(:,1);%1:(size(refSample,1));
    %  indxRw = indxRw';
    indxCol = Wrapped(:,2);%1:(size(testSample,1));
    %  indxCol = indxCol';
    DistanceVal = (D(noOfSamplesInRefSample,noOfSamplesInTestSample))/ k ;
else
    return;
end
end