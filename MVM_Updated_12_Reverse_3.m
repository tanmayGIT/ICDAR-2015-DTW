function [pathCost,pathTarget,indxcol,indxrow,distSum,jumpcost] = MVM_Updated_12_Reverse_3(refSample,testSample,weight,straight)
pathTarget = 1;
[noOfSamplesInRefSample,N] = size(refSample);
[noOfSamplesInTestSample,M] = size(testSample);

if(noOfSamplesInRefSample == 0)
    disp('This is unwanted/unknown error');
end

if(N == M)
    Dist = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample);
    pathCost = inf(noOfSamplesInRefSample,noOfSamplesInTestSample);
    pathTargetRw = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample);
    pathTargetCol = zeros(noOfSamplesInRefSample,noOfSamplesInTestSample);
    
    for i=1:noOfSamplesInRefSample
        for j=1:noOfSamplesInTestSample
            total = zeros(N,1);
            for goFeature = 1:N
                total(goFeature,1) = (double((refSample(i,goFeature)-testSample(j,goFeature))^2));
            end
            Dist(i,j) = sqrt(sum(total));
        end
    end
    elasticity = (noOfSamplesInTestSample - noOfSamplesInRefSample);
    if(noOfSamplesInTestSample == noOfSamplesInTestSample)
        elasticity = noOfSamplesInRefSample;
    end
    if (~exist('jumpcost','var'))
        statmatx = calcJumpCost(Dist, elasticity);
        %         statmatx = min(Dist,[],2);
        [~,~,statmatx] = find(statmatx);
        if(isempty(statmatx))
            jumpcost = 0;
        else
            jumpcost = ( (mean(statmatx)+ 3*std(statmatx)) );
            smalJC = mean(statmatx);
        end
    end
    
    
    
    
    %     if (jumpcost <1)
    %         grac = ones(noOfSamplesInRefSample,noOfSamplesInTestSample);
    %         Dist = Dist + grac;  %  0.335^3 = 0.0376 : bcoz of this reason we need to add by 1, so if we are using power for calculating jumpCost
    %         %  then it is necessary to add by 1 otherwise the technique will not work
    %         jumpcost = calJumpCost(Dist);
    %     end
    
    
    
    
    
    if(noOfSamplesInTestSample >= noOfSamplesInRefSample)
        pathCost(1,1) = Dist(1,1);
        for ji = 2:1:(noOfSamplesInTestSample)
            pathCost(1,ji) = Dist(1,ji) ;
            
            if( (pathCost(1,ji) >= (pathCost(1,ji-1) + Dist(1,ji)))  )
                pathCost(1,ji) =   pathCost(1,ji-1) + Dist(1,ji) ;
                pathTargetRw(1,ji) = 1;
                pathTargetCol(1,ji) = ji-1;
            end
        end
        for i = 2:1:noOfSamplesInRefSample
            
            stopMotherRight = min((i-1+(elasticity)),noOfSamplesInTestSample);
            stopMotherLeft = max(((i-1)-(elasticity)),1);
            
            for k = stopMotherLeft:1:stopMotherRight
                stopj = min(((k+1+elasticity)-(abs(k-(i-1)))),noOfSamplesInTestSample);
                stopLeft  = max(k,1);
                for j = (stopLeft):1:stopj
                    if ((abs(j-(k+1))) <= 0)
                        if ((j-(k+1)) == -1) % for vertical link
                            costJump = smalJC;
                        else
                            costJump = 0;
                        end
                    else
                        costJump = jumpcost*(weight*(abs(j-(k+1))));
                    end
                    if ((pathCost(i,j)) >  (( (pathCost(i-1,k) + ((Dist(i,j)))) + costJump ) ))
                        pathCost(i,j) = (( (pathCost(i-1,k) + ((Dist(i,j)))) + costJump )) ;
                        
                        pathTargetRw(i,j) = i-1;
                        pathTargetCol(i,j) = k;
                    end
                    takeMax = max(1,j-1);
                    if( (pathCost(i,j) > (pathCost(i,takeMax) + smalJC + Dist(i,j)))  )
                        pathCost(i,j) =   pathCost(i,takeMax) + smalJC + Dist(i,j) ;
                        pathTargetRw(i,j) = i;
                        pathTargetCol(i,j) = j-1;
                    end
                end
            end
        end
        
        lastElasticity = max((noOfSamplesInRefSample),1);
        [minVal,~] = min(pathCost(noOfSamplesInRefSample,lastElasticity:noOfSamplesInTestSample));
        tempArr = pathCost(noOfSamplesInRefSample,lastElasticity:noOfSamplesInTestSample);
        ind = find(tempArr == minVal);
        indices = max(ind);
        
        mincol = (lastElasticity-1)+indices;
        minrow = noOfSamplesInRefSample;
        
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
        distSum = normalizationTech_4(indxrow,indxcol,distSum,noOfSamplesInRefSample,noOfSamplesInTestSample,jumpcost);      
        return
    end
end
end
function myMinArr = calcJumpCost(distMat, elasticity)
myMinArr = zeros(1,1);
elasticity = 2;%round(elasticity/2);
for iiii = 1:1:size(distMat,1)
    tempMinArr =  sort(distMat(iiii,:));
    takeSome = tempMinArr(1,1:elasticity);
    myMinArr(iiii,1) = mean(takeSome);
end
end

function distSum = normalizationTech_0(~,indxcol,distSum,~,~,~)
distSum = ((distSum))/(size(indxcol,1));
end

function distSum = normalizationTech_1(indxrow,indxcol,distSum,~,~,~)
jumpedQueryEle = 0;
jumpedTargetEle = 0;
for iiu = 1:1:(size(indxrow,1)-1)
    dif1 = indxrow(iiu+1,1) - indxrow(iiu,1);
    dif2 = indxcol(iiu+1,1) - indxcol(iiu,1);
    if(dif1>1)
        jumpedQueryEle = jumpedQueryEle + (dif1-1); % as if  the difference is 1 then it is fine but it if is more than one then it has to be counted
    end
    if(dif2 > 1)
        jumpedTargetEle = jumpedTargetEle + (dif2-1);
    end
end
distSum = distSum/(size(indxcol,1))+ jumpedQueryEle + jumpedTargetEle;
return
end

function distSum = normalizationTech_2(~,indxcol,distSum,~,~,~)
distSum = ((distSum))/(abs(indxcol(end,1) - indxcol(1,1)) ) ;
return;
end

function distSum = normalizationTech_3(indxrow,indxcol,distSum,noOfSamplesInRefSample,~,jumpcost)
jumpedQueryEle = 0;
jumpedTargetEle = 0;
for iiu = 1:1:(size(indxrow,1)-1)
    dif1 = indxrow(iiu+1,1) - indxrow(iiu,1);
    dif2 = indxcol(iiu+1,1) - indxcol(iiu,1);
    if(dif1>1)
        jumpedQueryEle = jumpedQueryEle + (dif1-1); % as if  the difference is 1 then it is fine but it if is more than one then it has to be counted
    end
    if(dif2 > 1)
        jumpedTargetEle = jumpedTargetEle + (dif2-1);
    end
end
% so the main refinement has to be done from here as we had added one dummy row at the begginning
endSkip = abs(noOfSamplesInRefSample - indxrow(end,1));
begSkip = (indxrow(1,1) -1);
distSum = distSum + ((begSkip + endSkip)*jumpcost);
distSum = distSum/(size(indxcol,1))+jumpedQueryEle+jumpedTargetEle + (begSkip + endSkip);
end

function distSum = normalizationTech_4(indxrow,indxcol,distSum,noOfSamplesInRefSample,~,jumpcost)
endSkip = abs(noOfSamplesInRefSample - indxrow(end,1));
begSkip = (indxrow(1,1) -1);
distSum = distSum + ((begSkip + endSkip)*jumpcost);
distSum = distSum/(abs(indxcol(end,1) - indxcol(1,1)) ) + (begSkip + endSkip);
end

function distSum = normalizationTech_5(indxrow,indxcol,distSum,~,~,~)
jumpedQueryEle = 0;
jumpedTargetEle = 0;
for iiu = 1:1:(size(indxrow,1)-1)
    dif1 = indxrow(iiu+1,1) - indxrow(iiu,1);
    dif2 = indxcol(iiu+1,1) - indxcol(iiu,1);
    if(dif1>1)
        jumpedQueryEle = jumpedQueryEle + (dif1-1); % as if  the difference is 1 then it is fine but it if is more than one then it has to be counted
    end
    if(dif2 > 1)
        jumpedTargetEle = jumpedTargetEle + (dif2-1);
    end
end
distSum = distSum/(size(indxcol,1)) + jumpedTargetEle;
return
end
function distSum = normalizationTech_6(indxrow,indxcol,distSum,noOfSamplesInRefSample,~,jumpcost)
endSkip = abs(noOfSamplesInRefSample - indxrow(end,1));
begSkip = (indxrow(1,1) -1);
distSum = distSum + ((begSkip + endSkip)*jumpcost);
distSum = distSum/(size(indxcol,1)) + (begSkip + endSkip);
end
function distSum = normalizationTech_7(indxrow,indxcol,distSum,noOfSamplesInRefSample,~,jumpcost)
jumpedQueryEle = 0;
jumpedTargetEle = 0;
for iiu = 1:1:(size(indxrow,1)-1)
    dif1 = indxrow(iiu+1,1) - indxrow(iiu,1);
    dif2 = indxcol(iiu+1,1) - indxcol(iiu,1);
    if(dif1>1)
        jumpedQueryEle = jumpedQueryEle + (dif1-1); % as if  the difference is 1 then it is fine but it if is more than one then it has to be counted
    end
    if(dif2 > 1)
        jumpedTargetEle = jumpedTargetEle + (dif2-1);
    end
end
% so the main refinement has to be done from here as we had added one dummy row at the begginning
endSkip = abs(noOfSamplesInRefSample - indxrow(end,1));
begSkip = (indxrow(1,1) -1);
distSum = distSum + ((begSkip + endSkip)*jumpcost);
distSum = distSum/(size(indxcol,1))+jumpedTargetEle + (begSkip + endSkip);
end