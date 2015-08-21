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
    elasticity = noOfSamplesInTestSample;%(noOfSamplesInTestSample - noOfSamplesInRefSample);
    fullElasticity = (noOfSamplesInTestSample); % is the number of
    
    if (~exist('jumpcost','var'))
        
        
%         DistTrans = Dist;
%         minArr = zeros(noOfSamplesInRefSample,1);
%         for jc = 1:1:noOfSamplesInRefSample
%             if(jc == 1)
%                 gfRight = max (jc,noOfSamplesInTestSample);
%                 minValu  = DistTrans(jc,jc:gfRight); % for ignoring the zero element
%                 minArr(jc,1) = min (minValu);
%             else
%                 gfRight = min ((jc+elasticity),noOfSamplesInTestSample);
%                 gfLeft = max ((jc-elasticity),1);
%                 minValu = DistTrans(jc,gfLeft:gfRight); % for ignoring the zero element
%                 minArr(jc,1) = min (minValu);
%             end
%         end
%         statmatx = minArr;


                statmatx = min(Dist,[],2); % comment this line and uncommnet other lines above 
        [~,~,statmatx] = find(statmatx);
        if(isempty(statmatx))
            jumpcost = 0;
            flexCost = 0;
        else
            jumpcost = ( (mean(statmatx)+ 1*std(statmatx)) );
            flexCost = ( (mean(statmatx) + (1*std(statmatx)) ) );
        end
    end
    
    paddedDist = zeros(noOfSamplesInRefSample+1,noOfSamplesInTestSample);
    paddedDist(1:end-1,:) = Dist(:,:);
    Dist = paddedDist;
    
    if(noOfSamplesInTestSample >= noOfSamplesInRefSample) % this condition k is satisfied only when the above statement
        pathCost(1,1) = Dist(1,1);
        for ji = 2:1:(noOfSamplesInTestSample)
            pathCost(1,ji) = Dist(1,ji) + pathCost(1,ji-1);%((ji-1)*jumpcost)+((Dist(1,ji)) * (Dist(1,ji)));
        end
        for i = 2:1:noOfSamplesInRefSample+1 % for all the rows
            if(i == 2)
                stopMotherRight = min((i-1+(fullElasticity)),noOfSamplesInTestSample);
                stopMotherLeft = max(((i-1)-(fullElasticity)),1);
            else
                stopMotherRight = min((i-1+(elasticity)),noOfSamplesInTestSample);
                stopMotherLeft = max(((i-1)-(elasticity)),1);
            end
            for k = stopMotherLeft:1:stopMotherRight % for the mother node
                stopj = min((k+1),noOfSamplesInTestSample); % here (k+1)+elasticity as we know k is mother node and we are finding the
                stopLeft  = max(((k)),1);   % for the same above defined reason we are doing (abs(j-i-1) in the following formula. As the the diagonal link is always right
                for j = (stopLeft):1:stopj % for the child node
                    if(j == stopLeft)% not penalizing the many to one matching
                        if ((pathCost(i,j)) >  (( pathCost(i-1,k) + (Dist(i,j))  )) ) % see here pathcost(i-1,k) is required for calculation, and that is why we start from i=2
                            pathCost(i,j) = ((pathCost(i-1,k) + (Dist(i,j))));
                            
                            pathTargetRw(i,j) = i-1;
                            pathTargetCol(i,j) = k;
                        end
                    else
                        if ((abs(j-(k+1))) == 0)
                            costJump = 0;
                        else
                            costJump = (jumpcost*weight)^(abs(j-(k+1)));
                        end
                        if ((pathCost(i,j)) >  (( (pathCost(i-1,k) + ((Dist(i,j)))) + costJump ) )) % see here pathcost(i-1,k) is required for calculation, and that is why we start from i=2
                            pathCost(i,j) = (( (pathCost(i-1,k) + ((Dist(i,j)))) + costJump )) ;
                            
                            pathTargetRw(i,j) = i-1;
                            pathTargetCol(i,j) = k;
                        end
                    end
                    takeMin = max(1,j-1);
                    if( (pathCost(i,j) > (pathCost(i,takeMin) + Dist(i,j)))  &&  (i < (noOfSamplesInRefSample)) ) % no penalizing one to many matching
                        pathCost(i,j) =   pathCost(i,takeMin) + Dist(i,j) ;
                        pathTargetRw(i,j) = i;
                        pathTargetCol(i,j) = j-1;
                    end
                end
            end
        end
        
        lastElasticity = max((noOfSamplesInRefSample),1);
        [minVal,~] = min(pathCost(noOfSamplesInRefSample+1,lastElasticity:noOfSamplesInTestSample));
        tempArr = pathCost(noOfSamplesInRefSample+1,lastElasticity:noOfSamplesInTestSample);
        ind = find(tempArr == minVal);
        indices = max(ind);
        
        mincol = (lastElasticity-1)+indices;
        minrow = noOfSamplesInRefSample+1;
        pathTargetRw(1,:) = pathTargetRw(2,:);
        pathTargetCol(1,:) = pathTargetCol(2,:);
        mincolTemp = pathTargetCol(minrow,mincol);
        minrow = pathTargetRw(minrow,mincol);
        mincol = mincolTemp;
%         mincol = noOfSamplesInTestSample;
        Wrapped =[];
        while (minrow>=1 && mincol>=1)
            Wrapped = cat(1,[minrow,mincol],Wrapped);
            if(minrow == 1)&&(mincol == 1)
                break;
            end
            mincolTemp = pathTargetCol(minrow,mincol);
            minrow = pathTargetRw(minrow,mincol);
            mincol = mincolTemp;
        end
        indxrow = Wrapped(:,1);
        indxcol = Wrapped(:,2);
        
        distSum = pathCost(indxrow(end,1),indxcol(end,1));
        
        distSum = ((distSum))/(size(indxcol,1));
        
        return
    end
end
