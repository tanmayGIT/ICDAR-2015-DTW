function [D_targetData,nBlkTarget] = PAA_Symbolic_1(Data_Target,Data_Query,avgWidth)
[Data_TargetPAA,~] = PAA_ProcessSymbolic_1(Data_Target,avgWidth);
[Data_QueryPAA,~] = PAA_ProcessSymbolic_1(Data_Query,avgWidth);
[~, Target_Col] = size(Data_TargetPAA);
[~, Ref_Col] = size(Data_QueryPAA);

% represent into clustering format
numCluster = 4;
Data_TargetClustered = Inf(size(Data_TargetPAA));
for jj = 1:1:Target_Col
    therw = Data_TargetPAA(:,jj);
    clusterLabeled = kmeans(therw,numCluster);
    Data_TargetClustered(:,jj) = clusterLabeled';
end
Data_QueryClustered = Inf(size(Data_QueryPAA));
for jj = 1:1:Ref_Col
    therw = Data_QueryPAA(:,jj);
    clusterLabeled = kmeans(therw,numCluster);
    Data_QueryClustered(:,jj) = clusterLabeled';
end









if(N == M) % each set containing same no. of feature
    Dist = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample); % Initializing the array
    for i=1:noOfSamplesInRefSample % xSize
        for j=1:noOfSamplesInTestSample %ySize
            total = zeros(N,1);
            for goFeature=1:N %or M as N & M are same
                total(goFeature,1) = (double((D_refData(i,goFeature)-D_targetData(j,goFeature))^2));
            end
            Dist(i,j) =  (sqrt(sum(total)));
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
    indxRw =  Wrapped(:,1);%1:(size(refSample,1));
    %  indxRw = indxRw';
    indxCol = Wrapped(:,2);%1:(size(testSample,1));
    %  indxCol = indxCol';
    DistanceVal = (D(noOfSamplesInRefSample,noOfSamplesInTestSample))/ k ;
else
    return;
end
end
function [D_targetData,nBlkTarget] = PAA_ProcessSymbolic_1(Data_Targetori,avgWidth)
Data_Target = doDerivative(Data_Targetori);
if ((rem((size(Data_Target,1)),avgWidth)) == 0);
    nBlkTarget = (size(Data_Target,1))/avgWidth;
else
    nBlkTarget = ((size(Data_Target,1)) - (rem((size(Data_Target,1)),avgWidth)))/avgWidth;
end

[Target_Row, Target_Col] = size(Data_Target);
targetRes = mod(Target_Row,nBlkTarget);
target_Blk_Length = (Target_Row - targetRes)/nBlkTarget;

if(targetRes ~= 0)
    if(isnan(nBlkTarget))||(nBlkTarget == Inf)
        disp('you are ill');
    end
    D_targetData = Inf(nBlkTarget+1,Target_Col);
    targetCnt = 1;
    for j=1:Target_Col
        for i=1:target_Blk_Length:(Target_Row-targetRes)
            meanVal = mean(Data_Target(i:((i+target_Blk_Length)-1),j));
            D_targetData(targetCnt,j) = meanVal; % first cell is minVal, second cell is maxVal and the last cell is target_Blk_Length
            targetCnt = targetCnt +1;
        end
        meanVal = mean(Data_Target(i:Target_Row,j));
        D_targetData(targetCnt,j) = meanVal;
        targetCnt = 1;
    end
else
    D_targetData = Inf(nBlkTarget,Target_Col);
    targetCnt = 1;
    for j=1:Target_Col
        for i=1:target_Blk_Length:(Target_Row)
            meanVal = mean(Data_Target(i:((i+target_Blk_Length)-1),j));
            D_targetData(targetCnt,j) = meanVal;
            targetCnt = targetCnt +1;
        end
        targetCnt = 1;
    end
end
return;
end
function D_targetData = doDerivative(data)
Data_Target = data';
[Target_Row, Target_Col] = size(Data_Target);
D_targetData = zeros(Target_Row,Target_Col);

for i=1:Target_Row
    for j=2:(Target_Col-1)-1
        D_point=((Data_Target(i,j)-Data_Target(i,j-1))+((Data_Target(i,j+1)-Data_Target(i,j-1))/2))/2;
        if j == 2
            D_targetData(i,1)=D_point;
        end
        if j == (Target_Col-1)-1
            D_targetData(i,Target_Col-1)=D_point;
        end
        D_targetData(i,j)=D_point;
    end
end

D_targetData = D_targetData';
return;
end