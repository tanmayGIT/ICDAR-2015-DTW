% This code is same as MVM_Updated_3 but here we have added the facility of
% reverse penalty.The reverse penalty is if the size of the query is bigger
% than the size of test word then the matching distance should come after
% than the matching distance with the words woth same size or bigger size
function [pathCost,pathTarget,indxcol,indxrow,distSum,jumpcost] = MVM_Updated_9(refSample,testSample,weight)
pathTarget = 1;
[noOfSamplesInRefSample,N] = size(refSample);
[noOfSamplesInTestSample,M] = size(testSample);

if(noOfSamplesInRefSample == 0)
    disp('This is unwanted/unknown error');
end

if(N == M) % each set containing same no. of feature
    Dist = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample); % Initializing the array
    pathCost = inf(noOfSamplesInRefSample+1,noOfSamplesInTestSample);
    pathTargetRw = zeros(noOfSamplesInRefSample+1,noOfSamplesInTestSample);
    pathTargetCol = zeros(noOfSamplesInRefSample+1,noOfSamplesInTestSample);
    
    for i=1:noOfSamplesInRefSample % xSize
        for j=1:noOfSamplesInTestSample %ySize
            total = zeros(N,1);
            for goFeature=1:N %or M as N & M are same
                total(goFeature,1) = sqrt(double((refSample(i,goFeature)-testSample(j,goFeature))^2));
            end
            
            Dist(i,j) = (sum(total));  %(sum(total));
        end
    end
    
    elasticity = (noOfSamplesInTestSample); % is the number of
    
    if (~exist('jumpcost','var'))
        DistTrans = Dist;
        minArr = zeros((size(DistTrans,1)),1);
        for jc = 1:1:size(DistTrans,1)
            if(jc == 1)
                gfRight = min (((jc)+elasticity),(size(DistTrans,2)));
                minArr(jc,1) = min(DistTrans(jc,jc:gfRight));
            else
                gfRight = min (((jc)+elasticity),(size(DistTrans,2)));
                gfLeft = max (((jc)-elasticity),1);
                minArr(jc,1) = min(DistTrans(jc,gfLeft:gfRight));
            end
        end
        jumpcost = ( (mean(minArr) + (2*std(minArr)) ) ) + eps;
        flexCost = ( (mean(minArr) + (std(minArr)) ) ) + eps;
        
        %         statmatx = min(Dist');
        %         jumpcost = ( (mean(statmatx)+std(statmatx)) ) + eps;
    end
    
    paddedDist = zeros(noOfSamplesInRefSample+1,noOfSamplesInTestSample);
    paddedDist(2:end,:) = Dist(:,:);
    Dist = paddedDist;
    
    if(noOfSamplesInTestSample >= noOfSamplesInRefSample) % this condition k is satisfied only when the above statement
        for ji=1:1:(elasticity)
            pathCost(1,ji) = ((Dist(1,ji)));%((ji-1)*jumpcost)+((Dist(1,ji)) * (Dist(1,ji)));
        end
        for i = 2:1:noOfSamplesInRefSample+1 % for all the rows
            stopMotherRight = min((i-1+(elasticity)),noOfSamplesInTestSample);
            stopMotherLeft = max(((i-1)-elasticity),1);
            for k = stopMotherLeft:1:stopMotherRight % for the mother node
                stopj = min(((k+1+elasticity)-(abs(k-(i-1)))),noOfSamplesInTestSample); % here (k+1)+elasticity as we know k is mother node and we are finding the
                stopLeft  = max(((k)),1);   % for the same above defined reason we are doing (abs(j-i-1) in the following formula. As the the diagonal link is always right
                for j = (stopLeft):1:stopj % for the child node
                    if ((pathCost(i,j)) >  ( (pathCost(i-1,k) + ((Dist(i,j)))) + (jumpcost*weight) ^( (abs(j-(k+1)))  ) ) ) % see here pathcost(i-1,k) is required for calculation, and that is why we start from i=2
                        pathCost(i,j) = ( (pathCost(i-1,k) + ((Dist(i,j)))) + ( (jumpcost*weight) ^(abs(j-(k+1)))  ) ) ;
                        
                        pathTargetRw(i,j) = i-1;
                        pathTargetCol(i,j) = k;
                        
                        %                         if(j == stopLeft)
                        takeMin = max(1,j-1);
                        if(((pathCost(i,j)) >  ((      (pathCost(i,takeMin)           + ((Dist(i,j)))) + ( (jumpcost*weight) ^ 1  ) ) - flexCost) ) && (i < (noOfSamplesInRefSample+1)))
                            pathCost(i,j) = ( (       pathCost(i,takeMin)            + ((Dist(i,j)))) + ( (jumpcost*weight) ^ 1  ) ) - flexCost ;
                            pathTargetRw(i,j) = i;
                            pathTargetCol(i,j) = j-1;
                        end
                        %                         end
                    end
                end
            end
        end
        
        lastElasticity = max((noOfSamplesInRefSample-elasticity),1);
        [minVal,~] = min(pathCost(noOfSamplesInRefSample,lastElasticity:noOfSamplesInTestSample));
        tempArr = pathCost(noOfSamplesInRefSample,lastElasticity:noOfSamplesInTestSample);
        ind = find(tempArr == minVal);
        indices = max(ind);
        
        mincol = (lastElasticity-1)+indices;
        minrow = noOfSamplesInRefSample+1;
        
        mincolTemp = pathTargetCol(minrow,mincol);
        minrow = pathTargetRw(minrow,mincol);
        mincol = mincolTemp;

        Wrapped(1,:)=[minrow,mincol];
        while (minrow>1)
            mincolTemp = pathTargetCol(minrow,mincol);
            minrow = pathTargetRw(minrow,mincol);
            mincol = mincolTemp;
            Wrapped = cat(1,[minrow,mincol],Wrapped);
        end
        
        indxrow = Wrapped(:,1);
        indxcol = Wrapped(:,1);
        
        distSum = pathCost(indxrow(end,1),indxcol(end,1));
        
        distSum = ((distSum))/(size(indxcol,1));
        
        return
    end
end