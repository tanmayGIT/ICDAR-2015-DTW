function [optimumDist,ultiCol,ultiRw] = DynamicTimeWarping_CW(refSample,testSample,avgCharWidth)
% DTW with corresponding window
avgCharWidth = round(avgCharWidth);
[noOfSamplesInRefSample,N]=size(refSample);
[noOfSamplesInTestSample,M]=size(testSample);

optimumDist = Inf;
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
    
    for cw = 1:avgCharWidth:(noOfSamplesInTestSample)% running for finding out the corresponding window
        if((cw+noOfSamplesInRefSample-1) < noOfSamplesInTestSample)
            DistNeed = Dist(:,cw:(cw+noOfSamplesInRefSample-1));
            [DistanceVal,indxCol,indxRw] = Chota_DTW(DistNeed);
            
            if(DistanceVal <= optimumDist)
                ultiRw = indxRw;
                ultiCol = indxCol;
                optimumDist = DistanceVal;
            end
        end
    end
    if((cw+noOfSamplesInRefSample-1) ~= noOfSamplesInTestSample)% means in the previous for loop we have not considered upto last block and still some column remains
        DistNeed = Dist(:,(noOfSamplesInTestSample -(noOfSamplesInRefSample-1) ):noOfSamplesInTestSample);
        [DistanceVal,indxCol,indxRw] = Chota_DTW(DistNeed);
        if(DistanceVal <= optimumDist)
            ultiRw = indxRw;
            ultiCol = indxCol;
            optimumDist = DistanceVal;
        end
    end
    
else
    return;
    
end

end

function [DistanceVal,indxCol,indxRw] = Chota_DTW(DistNeed)
[noOfSamplesInRefSample,noOfSamplesInTestSample] = size(DistNeed);
D = Inf(size(DistNeed));
D(1,1) = DistNeed(1,1);

for n = 2:noOfSamplesInRefSample
    D(n,1) = DistNeed(n,1)+D(n-1,1);
end
for m = 2:noOfSamplesInTestSample
    D(1,m) = DistNeed(1,m)+D(1,m-1);
end
for n = 2:noOfSamplesInRefSample
    for m = 2:noOfSamplesInTestSample
        D(n,m) = DistNeed(n,m)+min([D(n-1,m),(min([D(n-1,m-1),D(n,m-1)]))]); % Thanks for the suggestion by "Sven Mensing" in Matlab Central
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
while ((X>1)&&(Y>1))
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

DistanceVal = (D(noOfSamplesInRefSample,noOfSamplesInTestSample))/ k ;

indxRw =  Wrapped(:,1);
indxCol = Wrapped(:,2);
end
