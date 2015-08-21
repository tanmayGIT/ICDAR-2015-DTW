% This code is same as MVM_Updated_3 but here we have added the facility of
% reverse penalty.The reverse penalty is if the size of the query is bigger
% than the size of test word then the matching distance should come after
% than the matching distance with the words woth same size or bigger size
function [pathCost,pathTargetCol,indxcol,indxrow,distSum,jumpcost] = MVM_Updated_8(refSample,testSample,weight)

[noOfSamplesInRefSample,N] = size(refSample);
[noOfSamplesInTestSample,M] = size(testSample);

if(noOfSamplesInRefSample == 0)
    disp('This is unwanted/unknown error');
end

if(N == M) % each set containing same no. of feature
    Dist = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample); % Initializing the array
    pathCost = inf(noOfSamplesInRefSample,noOfSamplesInTestSample);
    pathTargetRw = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample);
    pathTargetCol = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample);
    
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
        %         statmatx = min(Dist');
        %         jumpcost = ( (mean(statmatx)+std(statmatx)) ) + eps;
    end
    
    if(noOfSamplesInTestSample >= noOfSamplesInRefSample) % this condition k is satisfied only when the above statement
        for ji=1:1:(elasticity)
            pathCost(1,ji) = ((Dist(1,ji)));%((ji-1)*jumpcost)+((Dist(1,ji)) * (Dist(1,ji)));
        end
        for i = 2:1:noOfSamplesInRefSample % for all the rows
            stopMotherRight = min((i-1+(elasticity)),noOfSamplesInTestSample);
            stopMotherLeft = max(((i-1)-elasticity),1);
            for k = stopMotherLeft:1:stopMotherRight % for the mother node
                stopj = min(((k+1+elasticity)-(abs(k-(i-1)))),noOfSamplesInTestSample); % here (k+1)+elasticity as we know k is mother node and we are finding the
                stopLeft  = max(((k)),1);   % for the same above defined reason we are doing (abs(j-i-1) in the following formula. As the the diagonal link is always right
                for j = (stopLeft):1:stopj % for the child node
                    if ((pathCost(i,j)) >  ( (pathCost(i-1,k) + ((Dist(i,j)))) + ( (abs(j-(k+1)))^(jumpcost*weight)  ) ) ) % see here pathcost(i-1,k) is required for calculation, and that is why we start from i=2
                        pathCost(i,j) = ( (pathCost(i-1,k) + ((Dist(i,j)))) + ( (abs(j-(k+1)))^(jumpcost*weight)  ) ) ;
                        pathTargetRw(i,j) = i;
                        pathTargetCol(i,j) = k;
                        %                         if(j == stopLeft)
                        if((j-1) > 0)
                            if((pathCost(i,j)) >  ( (pathCost(i,j-1) + ((Dist(i,j))))  ) )
                                pathCost(i,j) = ( (pathCost(i,j-1) + ((Dist(i,j)))) ) ;
                                pathTargetRw(i,j) = i;
                                pathTargetCol(i,j) = j-1;
                            end
                        end
                    end
                end
            end
        end
        
        minrow = noOfSamplesInRefSample;
        
        lastElasticity = max((noOfSamplesInRefSample-elasticity),1);
        [minVal,~] = min(pathCost(noOfSamplesInRefSample,lastElasticity:noOfSamplesInTestSample));
        tempArr = pathCost(noOfSamplesInRefSample,lastElasticity:noOfSamplesInTestSample);
        ind = find(tempArr == minVal);
        indices = max(ind); % if there are two same cost present in the same row
        mincol = (lastElasticity-1)+indices;
        
        indxcol = zeros(noOfSamplesInRefSample,1);
        indxrow = zeros(noOfSamplesInRefSample,1);
        cnt = 1;
        while (minrow>=1 && mincol>=1)
            indxcol(cnt,1) = mincol;
            indxrow(cnt,1) = minrow;
            
            mincol = pathTargetCol(minrow,mincol);
            minrow = pathTargetRw(minrow,mincol); % as simply the row is decreasing and indicating the match
            
            cnt = cnt + 1;
        end
        indxcol = flipdim(indxcol,1);
        indxrow = flipdim(indxrow,1);
        
        distSum = pathCost(noOfSamplesInRefSample,((lastElasticity-1)+indices));
        
        distSum = ((distSum))/(size(indxcol,1));
        
        return
    end
end