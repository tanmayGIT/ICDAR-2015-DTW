function [DistanceValMain,indxColMain,indxRwMain] = OnlineDynamicTimeWarping(refSample,testSample,avgWidth)
% the idea here is to see first the number of division possible for the query signal as it is the shortest signal among both
noOfPartRef = round(size(refSample,2)/avgWidth); % number of possible division
targetPartlength = round(size(testSample,2)/noOfPartRef); % this is the size of target subimages
refPartKeeper = cell(noOfPartRef,1);
targetPartKeeper = cell(noOfPartRef,1);

for ut = 1:1:noOfPartRef-1
    refPartKeeper{ut,1} = refSample(:,(((ut-1)+1)*avgWidth):ut*avgWidth);
end
refPartKeeper{ut,1} = refSample(:,(((ut-1)+1)*avgWidth):end);

for lt = 1:1:noOfPartRef-1
    targetPartKeeper{lt,1} = testSample(:,(((lt-1)+1)*targetPartlength):lt*targetPartlength);
end

targetPartKeeper{lt,1} = testSample(:,(((lt-1)+1)*targetPartlength):end);
keepAllDTWInfo = cell(noOfPartRef,3);
[DistanceValMain,indxColMain,indxRwMain,distMat] = EfficientDynamicTimeWarping(refPartKeeper{1,1},targetPartKeeper{1,1});
keepAllDTWInfo{1,1} = DistanceValMain;
keepAllDTWInfo{1,2} = indxColMain;
keepAllDTWInfo{1,3} = indxRwMain;
keepAllDTWInfo{1,4} = distMat;
for laterPart = 2:1:noOfPartRef
     K_0 = theta * (size(refPartKeeper{laterPart-1,1},1)); % considering reference signal length as the parameter for overlapping window
    [ref_A,terget_A,removeDist] = getOverlapMembers(refPartKeeper{laterPart-1,1},targetPartKeeper{laterPart-1,1},...
                    keepAllDTWInfo{laterPart-1,2},keepAllDTWInfo{laterPart-1,3},K_0,keepAllDTWInfo{laterPart-1,4});
     ref_dash = Inf(size(ref_A,1)+size(refPartKeeper{laterPart,1},1),size(refPartKeeper{laterPart,1},2));
     ref_dash(1:size(ref_A,1),:) = ref_A(:,:);
     ref_dash((size(ref_A,1)+1):end,:) = refPartKeeper{laterPart,1}(:,:); 
     
     
     target_dash = Inf(size(terget_A,1)+size(targetPartKeeper{laterPart,1},1),size(targetPartKeeper{laterPart,1},2));
     target_dash(1:size(terget_A,1),:) = terget_A(:,:);
     target_dash((size(terget_A,1)+1):end,:) = targetPartKeeper{laterPart,1}(:,:); 
     [DistanceValPart,indxColPart,indxRwPart] = EfficientDynamicTimeWarping(ref_dash,target_dash);
     
     keepAllDTWInfo{laterPart,1} = DistanceValPart;
     keepAllDTWInfo{laterPart,2} = indxColPart;
     keepAllDTWInfo{laterPart,3} = indxRwPart;
     
     [DistanceValMain,indxRwMain,indxColMain] = unionValues(DistanceValMain,indxRwMain,indxColMain,...
                                                DistanceValPart,indxColPart,indxRwPart,removeDist);
end
return
end
function [combinedDist,combinedIndxRw,combinedIndxCol] = unionValues(distValMain,indxRwMain,indxColMain,distValTemp,indxRwTemp,indxColTemp,removeDist)
combinedDist = (distValMain + distValTemp) - removeDist;
combinedIndxRw = Inf((size(indxRwMain,1) + size(indxRwTemp,1)),1);
combinedIndxCol = Inf((size(indxColMain,1) + size(indxColTemp,1)),1);

combinedIndxRw(1:size(indxRwMain,1),1) = indxRwMain(:,1);
combinedIndxRw((size(indxRwMain,1)+1):end,1) = indxRwTemp(:,1);

combinedIndxCol(1:size(indxColMain,1),1) = indxColMain(:,1);
combinedIndxCol((size(indxColMain,1)+1):end,1) = indxColTemp(:,1);
end
function [refPartCrop,targetPartCrop,removeDist] = getOverlapMembers(refPart,targetPart,indxRw,indxCol,K_0,distMat)
stIndxRw = (size(indxRw,1)-K_0)+1;
stIndxCol = (size(indxCol,1)-K_0)+1;
refPartCrop = refPart(stIndxRw:end,:);
targetPartCrop = targetPart(stIndxCol:end,:);
removeDist = 0;
for iiu = stIndxRw:1:size(indxRw,1)
    removeDist = removeDist + distMat(indxRw(iiu,1),indxCol(iiu,1));
end
return;
end
function [DistanceVal,indxCol,indxRw,DistMat] = EfficientDynamicTimeWarping(refSample,testSample)
[noOfSamplesInRefSample,N]=size(refSample);
[noOfSamplesInTestSample,M]=size(testSample);

if(N == M) % each set containing same no. of feature
    
   DistMat = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample); % Initializing the array
   for i=1:noOfSamplesInRefSample % xSize
        for j=1:noOfSamplesInTestSample %ySize
            total = zeros(N,1);
            for goFeature=1:N %or M as N & M are same
                 total(goFeature,1) = (double((refSample(i,goFeature)-testSample(j,goFeature))^2));
            end
            DistMat(i,j) =  sqrt(sum(total));
        end
    end
    
    D=Inf(size(DistMat));
    D(1,1)=DistMat(1,1);

    for n=2:noOfSamplesInRefSample
        D(n,1)=DistMat(n,1)+D(n-1,1);
    end
    for m=2:noOfSamplesInTestSample
        D(1,m)=DistMat(1,m)+D(1,m-1);
    end
    for n=2:noOfSamplesInRefSample
        for m=2:noOfSamplesInTestSample
            D(n,m)=DistMat(n,m)+min([D(n-1,m-1),D(n,m-1),D(n-1,m)]);
        end
    end
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
            [~,place] = min([D(X-1,Y-1),D(X,Y-1),D(X-1,Y)]);
            switch place
                case 1
                    X = X-1;
                    Y = Y-1;
                case 2
                    Y = Y-1;
                case 3
                    X = X-1;
            end
        end
        k=k+1; % The number of steps it took to come to the place [1,1]
        Wrapped = cat(1,[X,Y],Wrapped);
    end
 indxRw =  Wrapped(:,1);
 indxCol = Wrapped(:,2);
 DistanceVal = (D(noOfSamplesInRefSample,noOfSamplesInTestSample)) ;

else
    return;
end
end
