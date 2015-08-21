% In this code, we will try to replicate "CDP" in MVM
% here we try to replicate CDP2
function [pathCost,pathTarget,indxColUp,indxRwUp,distSum,jumpcost] = MVM_Updated_19(refSample,testSample,weight,straight)
pathTarget = 1;
[noOfSamplesInRefSample,N] = size(refSample);
[noOfSamplesInTestSample,M] = size(testSample);

if(noOfSamplesInRefSample == 0)
    disp('This is unwanted/unknown error');
end

if(N == M)
    Dist = zeros(noOfSamplesInTestSample,noOfSamplesInRefSample);
    pathCost = inf(noOfSamplesInTestSample,noOfSamplesInRefSample);
    pathTargetRw = zeros(noOfSamplesInTestSample,noOfSamplesInRefSample);
    pathTargetCol = zeros(noOfSamplesInTestSample,noOfSamplesInRefSample);
    
    for i=1:noOfSamplesInTestSample
        for j=1:noOfSamplesInRefSample
            total = zeros(N,1);
            for goFeature = 1:N
                total(goFeature,1) = (double((testSample(i,goFeature)-refSample(j,goFeature))^2));
            end
            
            Dist(i,j) = sqrt(sum(total));
        end
    end
%     grac = ones(noOfSamplesInTestSample,noOfSamplesInRefSample);
%     Dist = Dist + grac;
    
    fullElasticity =  noOfSamplesInTestSample;
    elasticity = 0;%(noOfSamplesInTestSample - noOfSamplesInRefSample);
    
    if (~exist('jumpcost','var'))
        statmatx = min(Dist,[],2);
        [~,~,statmatx] = find(statmatx);
        if(isempty(statmatx))
            jumpcost = 0;
        else
            jumpcost = ( (mean(statmatx)+ 1*std(statmatx)) );
        end
    end
    
    if(noOfSamplesInTestSample >= noOfSamplesInRefSample)
        
        % For the 1st row of pathCost matrix
        %         pathCost(1,1) = Dist(1,1);
        %         for ji = 2:1:(noOfSamplesInTestSample)
        %             pathCost(1,ji) = Dist(1,ji) ;
        %         end
        pathCost(1,:) = Dist(1,:);
%         pathCost(2,:) = Inf;
        
        for i = 2:1:noOfSamplesInTestSample
            if(i == 2)
                % For very first matching we need to give full flexibility so that it can just as much it want
                stopMotherRight = min((i-1+(fullElasticity)),noOfSamplesInTestSample);
                stopMotherLeft = max(((i-1)-(fullElasticity)),1);
            else
                % After first jump, the flexibility is restricted and limited
                stopMotherRight = min((i-1+(elasticity)),noOfSamplesInTestSample);
                stopMotherLeft = max(((i-1)-(elasticity)),1);
            end
            
            for k = 1:1:noOfSamplesInRefSample  % For parent node
                stopj = min(k+1,noOfSamplesInRefSample); %min(((k+1+elasticity)-(abs(k-(i-1)))),noOfSamplesInTestSample);
                stopLeft  = max(k,1);
                for j = (stopLeft):1:stopj % For child node
                    
                    if(j == 1) % For the 1st column in second row
                        pathCost(i,j) = Dist(i,j);
                    else  % For all other column
                        if(j == stopLeft)
                            if ((pathCost(i,j)) >  (pathCost(i-1,k) + Dist(i,j)))
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
                            if ((pathCost(i,j)) >  (( (pathCost(i-1,k) + ((Dist(i,j)))) + costJump ) ))
                                pathCost(i,j) = (( (pathCost(i-1,k) + ((Dist(i,j)))) + costJump )) ;
                                
                                pathTargetRw(i,j) = i-1;
                                pathTargetCol(i,j) = k;
                            end
                        end
                        takeMin = max(1,j-1);
                        if(pathCost(i,j) >= (pathCost(i,takeMin) + Dist(i,j)))
                            pathCost(i,j) =   pathCost(i,takeMin) + Dist(i,j) ;
                            pathTargetRw(i,j) = i;
                            pathTargetCol(i,j) = j-1;
                        end
                    end
                end
            end
            
        end
    end
    
    lastElasticity = max((noOfSamplesInRefSample),1);
    [minVal,~] = min(pathCost(lastElasticity:noOfSamplesInTestSample,noOfSamplesInRefSample));
    tempArr = pathCost(lastElasticity:noOfSamplesInTestSample,noOfSamplesInRefSample);
    ind = find(tempArr == minVal);
    indices = max(ind);
    
    minrow = (lastElasticity-1)+indices;
    mincol = noOfSamplesInRefSample;
    
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
    
    indxColUp = indxrow;
    indxRwUp = indxcol;
    
    distSum = pathCost(indxrow(end,1),indxcol(end,1));
    %         if(straight == 2)
    %             noOfExtraJump = abs( (noOfSamplesInTestSample-indxcol(end,1)) + (indxcol(1,1) - 1) );
    %             distSum = (distSum +  (jumpcost ^noOfExtraJump )  ) / (size(indxcol,1) + noOfExtraJump );
    %         else
    distSum = ((distSum))/noOfSamplesInRefSample;
    %         end
    return
end
end