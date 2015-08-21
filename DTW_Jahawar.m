function [DistanceVal,indxCol,indxRw] = DTW_Jahawar(refSample,testSample)

% Here it is assumed that always refSample is smaller or equal than testSample
% The DTW matching is drawn from reference sample to test sample. But when
% the test sample is shorter than reference sample then as the design of
% the algorithm the reference sample will be taken virtually as test sample
% and the rest process will be same.

[noOfSamplesInRefSample,N]=size(refSample);
[noOfSamplesInTestSample,M]=size(testSample);

if(N == M) % each set containing same no. of feature
    
    Dist = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample); % Initializing the array
    for i=1:noOfSamplesInRefSample % xSize
        for j=1:noOfSamplesInTestSample %ySize
            total = zeros(N,1);
            for goFeature=1:N %or M as N & M are same
                total(goFeature,1) = (double((refSample(i,goFeature)-testSample(j,goFeature))^2));
            end
            Dist(i,j) =  sqrt(sum(total));
        end
    end
    
    D=Inf(size(Dist));
    D(1,1)=Dist(1,1);
    
    for n=2:noOfSamplesInRefSample
        D(n,1)=Dist(n,1)+D(n-1,1);
    end
    for m=2:noOfSamplesInTestSample
        D(1,m)=Dist(1,m)+D(1,m-1);
    end
    for n=2:noOfSamplesInRefSample
        for m=2:noOfSamplesInTestSample
            D(n,m)=Dist(n,m)+min([D(n-1,m),(min([D(n-1,m-1),D(n,m-1)]))]); % Thanks for the suggestion by "Sven Mensing" in Matlab Central
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
    indxRw =  Wrapped(:,1);
    indxCol = Wrapped(:,2);
    
    % here rows defines reference signal
    L = size(indxCol,1);
    k = round(L/3);
    
    uniqEleRefForward = unique(indxRw(1:k,1));
    
    bestForwardIndx = 0;
    for forward_i = 1:1:length(uniqEleRefForward)
        uniqVal = uniqEleRefForward(forward_i,1);
        redundantIndex = find((indxRw(1:k,1)) == uniqVal);
        
        % now keep the strong bond
        if(length(redundantIndex) > 1)
            bestDist = Inf;
            strongRefIndx = 0;
            strongTargetIndx = 0;
            for getEachRedundant = 1:1:numel(redundantIndex)
                getIndex = redundantIndex(getEachRedundant,1);
                refCell =  indxRw(getIndex,1);
                targetCell = indxCol(getIndex,1);
                distAtTheCell = D(refCell,targetCell);
                if(distAtTheCell < bestDist)
                    strongRefIndx = refCell;
                    strongTargetIndx = targetCell;
                    bestForwardIndx = getIndex;
                end
                indxRw(getIndex,1) = 0;
                indxCol(getIndex,1) = 0;
            end
            indxRw(bestForwardIndx,1) = strongRefIndx;
            indxCol(bestForwardIndx,1) = strongTargetIndx;
        end
        
    end
    
    uniqEleRefBackward = unique(indxRw((2*k):L,1));
    bestBackwardIndex = 0;
    for backward_i = 1:1:numel(uniqEleRefBackward)
        uniqVal = uniqEleRefBackward(backward_i,1);
        redundantIndex = find((indxRw((2*k):L,1)) == uniqVal);
        redundantIndex = redundantIndex + ((2*k)-1);
        
        % now keep the strong bond
        if(length(redundantIndex) > 1)
            bestDist = Inf;
            strongRefIndx = 0;
            strongTargetIndx = 0;
            for getEachRedundant = 1:1:numel(redundantIndex)
                getIndex = redundantIndex(getEachRedundant,1);
                refCell =  indxRw(getIndex,1);
                targetCell = indxCol(getIndex,1);
                distAtTheCell = D(refCell,targetCell);
                if(distAtTheCell < bestDist)
                    strongRefIndx = refCell;
                    strongTargetIndx = targetCell;
                    bestBackwardIndex = getIndex;
                end
                indxRw(getIndex,1) = strongRefIndx;
                indxCol(getIndex,1) = strongTargetIndx;
            end
            indxRw(bestBackwardIndex,1) = 0;
            indxCol(bestBackwardIndex,1) = 0;    
        end
    end
    indxRw = nonzeros(indxRw);
    indxCol = nonzeros(indxCol);
    DistanceVal = 0;
    for croppedCell = 1:1: numel(indxRw,1)
        DistanceVal = DistanceVal + D((indxRw(croppedCell,1)),(indxCol(croppedCell,1)));
    end
    DistanceVal = DistanceVal /(numel(indxRw,1));
else
    return;
end
end
